//
//  BookingStore.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

class BookingStore: ObservableObject {
    @Published var bookings: [Booking] = []

    private let db = Firestore.firestore()

    // Listener handle to keep the snapshot listener alive
    private var bookingsListener: ListenerRegistration?

    // Returns the current authenticated user id, if any
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }

    func addBooking(_ booking: Booking) {
        // Update local list immediately for responsive UI
        bookings.append(booking)

        // Also write to Firestore if we have a user
        guard let userId = userId else { return }
        let doc = db.collection("users").document(userId).collection("bookings").document()
        let payload: [String: Any] = [
            "providerName": booking.providerName,
            "date": booking.date,
            "time": booking.time,
            "extras": booking.extras,
            "paymentMethod": booking.paymentMethod,
            "createdAt": FieldValue.serverTimestamp()
        ]
        doc.setData(payload) { error in
            // You could handle errors here (e.g., retry or show a message)
        }
    }

    @MainActor
    func startListeningIfPossible() async {
        // Ensure we have a user before listening
        guard userId != nil else { return }
        startListening()
    }

    private func startListening() {
        guard let userId = userId else { return }
        // Remove any existing listener first
        bookingsListener?.remove()
        bookingsListener = db.collection("users").document(userId).collection("bookings")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self, let snapshot = snapshot else { return }
                let remote: [Booking] = snapshot.documents.compactMap { doc in
                    let data = doc.data()
                    guard let providerName = data["providerName"] as? String,
                          let date = data["date"] as? String,
                          let time = data["time"] as? String,
                          let extras = data["extras"] as? [String],
                          let paymentMethod = data["paymentMethod"] as? String else { return nil }
                    return Booking(providerName: providerName,
                                   date: date,
                                   time: time,
                                   extras: extras,
                                   paymentMethod: paymentMethod)
                }
                DispatchQueue.main.async {
                    self.bookings = remote
                }
            }
    }
}
