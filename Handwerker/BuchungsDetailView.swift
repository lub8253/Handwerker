//
//  BuchungsDetailView.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI

struct BuchungsDetailView: View {
    @Environment(\.dismiss) private var dismiss
    var booking: Booking
    
    var body: some View {
        ZStack {
            // Hintergrund wie auf den anderen Screens
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .blue.opacity(0.7)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Custom navigation header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.glassBackground, in: Circle())
                        }
                        Spacer()
                    }
                    
                    Text("Details")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.black)
                    
                    Text(booking.providerName)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Datum: \(booking.date)")
                        Text("Uhrzeit: \(booking.time)")
                    }
                    .font(.body)
                    .foregroundStyle(.black.opacity(0.9))
                    
                    if !booking.extras.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Extras:")
                                .font(.headline)
                                .foregroundStyle(.black)
                            ForEach(booking.extras, id: \.self) { extra in
                                Text("• \(extra)")
                                    .foregroundStyle(.black.opacity(0.9))
                            }
                        }
                    }
                    
                    Text("Zahlungsmethode: \(booking.paymentMethod)")
                        .padding(.top, 8)
                        .foregroundStyle(.black.opacity(0.95))
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
            }
        }
        .navigationBarHidden(true)
    }
}
