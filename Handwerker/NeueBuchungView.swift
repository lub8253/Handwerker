//
//  NeueBuchungView.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI

struct NeueBuchungView: View {
    @EnvironmentObject var store: BookingStore
    @Environment(\.dismiss) var dismiss
    
    var providerName: String
    
    @State private var appointmentDate: Date = Date()
    @State private var selectedExtras: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text(providerName)
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text("Kommt zu deiner Stelle")
                .foregroundColor(.white.opacity(0.8))
            
            // Datum & Uhrzeit
            Group {
                Text("Datum & Uhrzeit auswählen")
                    .font(.headline)
                    .foregroundColor(.white)
                
                DatePicker("Datum", selection: $appointmentDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                
                DatePicker("Uhrzeit", selection: $appointmentDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
            }
            
            // Extras
            Group {
                Text("Extras")
                    .font(.headline)
                    .foregroundColor(.white)
                
                ToggleButton(title: "+ Fensterreinigung - 20€", selectedExtras: $selectedExtras)
                ToggleButton(title: "+ Bodenreinigung - 15€", selectedExtras: $selectedExtras)
            }
            
            // Zahlungsmethode
            Group {
                Text("Zahlungsmethode")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("VISA **** 4635")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(8)
            }
            
            Spacer()
            
            // Buchung speichern
            Button("Buchung bestätigen") {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                
                let timeFormatter = DateFormatter()
                timeFormatter.dateStyle = .none
                timeFormatter.timeStyle = .short
                
                let dateString = dateFormatter.string(from: appointmentDate)
                let timeString = timeFormatter.string(from: appointmentDate)
                
                let newBooking = Booking(
                    providerName: providerName,
                    date: dateString,
                    time: timeString,
                    extras: selectedExtras,
                    paymentMethod: "VISA **** 4635"
                )
                store.addBooking(newBooking)
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.cyan)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .background(
            LinearGradient(colors: [.blue.opacity(0.3), .blue.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

struct ToggleButton: View {
    let title: String
    @Binding var selectedExtras: [String]
    
    var body: some View {
        Button(action: {
            toggle()
        }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedExtras.contains(title) ? Color.blue.opacity(0.4) : Color.white.opacity(0.3))
                .cornerRadius(8)
        }
    }
    
    private func toggle() {
        if let index = selectedExtras.firstIndex(of: title) {
            selectedExtras.remove(at: index)
        } else {
            selectedExtras.append(title)
        }
    }
}
