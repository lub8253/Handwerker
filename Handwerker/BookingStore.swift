//
//  BookingStore.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI
import Combine

class BookingStore: ObservableObject {
    @Published var bookings: [Booking] = []
    
    func addBooking(_ booking: Booking) {
        bookings.append(booking)
    }
}

