//
//  StartseiteView.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI

struct StartseiteView: View {
    @EnvironmentObject var store: BookingStore
    
    // Kategorien dynamisch aus den Providern
    var kategorien: [String] {
        Set(serviceProviders.map { $0.kategorie }).sorted()
    }
    
    @State private var selectedKategorie: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // Hintergrund
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .blue.opacity(0.7)]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 30) {
                            
                            // 🔹 Profil-Icon
                            HStack {
                                Button(action: {
                                    // TODO: Profilaktion
                                }) {
                                    Image(systemName: "person.crop.circle")
                                        .font(.system(size: 28))
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .clipShape(Circle())
                                }
                                Spacer()
                            }
                            
                            // 🔹 Rabattkarte
                            Text("10% Rabatt auf deine erste Reinigung")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .cornerRadius(10)
                            
                            // 🔹 Kategorie-Buttons (oben)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(kategorien, id: \.self) { kat in
                                        Button(action: {
                                            withAnimation {
                                                proxy.scrollTo(kat, anchor: .top)
                                                selectedKategorie = kat
                                            }
                                        }) {
                                            Text(kat)
                                                .padding(.horizontal, 14)
                                                .padding(.vertical, 6)
                                                .background(
                                                    selectedKategorie == kat ? Color.white : Color.white.opacity(0.6)
                                                )
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            
                            // 🔹 Kategorien-Abschnitte
                            ForEach(kategorien, id: \.self) { kategorie in
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(kategorie)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(.leading, 8)
                                        .id(kategorie) // Marker für ScrollViewReader
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 16) {
                                            ForEach(serviceProviders.filter { $0.kategorie == kategorie }) { provider in
                                                VStack(alignment: .leading, spacing: 8) {
                                                    Text(provider.name)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                    
                                                    Text(provider.beschreibung)
                                                        .font(.subheadline)
                                                        .foregroundColor(.white.opacity(0.8))
                                                    
                                                    Spacer()
                                                    
                                                    // Navigation zur neuen Buchung
                                                    NavigationLink(
                                                        destination: NeueBuchungView(providerName: provider.name)
                                                            .environmentObject(store)
                                                    ) {
                                                        Text("Jetzt buchen")
                                                            .padding(.horizontal, 16)
                                                            .padding(.vertical, 8)
                                                            .background(Color.white)
                                                            .cornerRadius(8)
                                                    }
                                                }
                                                .frame(width: 220, height: 140)
                                                .padding()
                                                .background(Color.blue.opacity(0.6))
                                                .cornerRadius(12)
                                            }
                                        }
                                        .padding(.horizontal, 8)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
   ContentView()
}
