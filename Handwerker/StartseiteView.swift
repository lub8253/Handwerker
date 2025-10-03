//
//  StartseiteView.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI

struct StartseiteView: View {
    @EnvironmentObject var store: BookingStore
    @StateObject private var vm = ProvidersViewModel()
    
    // Kategorien dynamisch aus den Providern
    var kategorien: [String] {
        Set(vm.providers.map { $0.kategorie }).sorted()
    }
    
    @State private var selectedKategorie: String? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                if vm.isLoading {
                    ProgressView("Lade Anbieter…")
                        .tint(.white)
                } else if let err = vm.errorMessage {
                    VStack(spacing: 12) {
                        Text(err)
                            .foregroundColor(.white)
                        Button("Erneut versuchen") {
                            Task { await vm.load() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
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
                                    .accessibilityLabel("Profil")
                                    .accessibilityHint("Profil öffnen")
                                    Spacer()
                                }
                                
                                // 🔹 Rabattkarte
                                Text("10% Rabatt auf deine erste Reinigung")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                    .accessibilityLabel("Rabatt: 10 Prozent auf deine erste Reinigung")
                                    .accessibilityHint("Angebot für neue Kundinnen und Kunden")
                                
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
                                                    .padding(.vertical, 10)
                                                    .background(
                                                        selectedKategorie == kat ? Color.white : Color.white.opacity(0.6)
                                                    )
                                                    .cornerRadius(20)
                                            }
                                            .accessibilityLabel("Kategorie \(kat)")
                                            .accessibilityHint("Zu Kategorie scrollen")
                                            .accessibilityValue(selectedKategorie == kat ? "Ausgewählt" : "")
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
                                            .accessibilityAddTraits(.isHeader)
                                            .foregroundColor(.black)
                                            .padding(.leading, 8)
                                            .id(kategorie) // Marker für ScrollViewReader
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 16) {
                                                ForEach(vm.providers.filter { $0.kategorie == kategorie }) { provider in
                                                    VStack(alignment: .leading, spacing: 8) {
                                                        Text(provider.name)
                                                            .font(.headline)
                                                            .foregroundColor(.black)
                                                        
                                                        Text(provider.beschreibung)
                                                            .font(.subheadline)
                                                            .foregroundColor(.black.opacity(0.8))
                                                        
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
                                                        .accessibilityLabel("Jetzt buchen bei \(provider.name)")
                                                        .accessibilityHint("Termin auswählen")
                                                    }
                                                    .frame(width: 220, height: 140)
                                                    .padding()
                                                    .background(Color.white.opacity(0.6))
                                                    .cornerRadius(12)
                                                    .accessibilityElement(children: .combine)
                                                    .accessibilityLabel("\(provider.name), Kategorie \(provider.kategorie). \(provider.beschreibung)")
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
            }
            .appBackground()
            .navigationBarHidden(true)
            .task {
                await vm.load()
            }
        }
    }
}

#Preview {
   ContentView()
}
