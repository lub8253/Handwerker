//
//  BuchungView.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI

struct BuchungListView: View {
    @EnvironmentObject var store: BookingStore
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(store.bookings) { booking in
                        NavigationLink(destination: BuchungsDetailView(booking: booking)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(booking.providerName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(booking.date) um \(booking.time)")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.85))
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(Color.blue.opacity(0.25))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(Color.white.opacity(0.15))
                            )
                            .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("\(booking.providerName), am \(booking.date) um \(booking.time)")
                            .accessibilityHint("Zeige Buchungsdetails")
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .appBackground()
            .navigationTitle("Buchungen")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
