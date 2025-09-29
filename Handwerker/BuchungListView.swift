//
//  BuchungView.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import SwiftUI

struct BuchungView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .blue.opacity(0.7)]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Profil-Icon
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 28))
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    
                    Text("Käse Krainer")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Kommt zu deiner Stelle")
                        .foregroundColor(.white.opacity(0.8))
                    
                    Group {
                        Text("Datum & Uhrzeit auswählen")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        TextField("Datum", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Uhrzeit", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Group {
                        Text("Extras")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Button("+ Fensterreinigung - 20€") {}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(8)
                        
                        Button("+ Bodenreinigung - 15€") {}
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(8)
                    }
                    
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
                    
                    Button("Buchung bestätigen") {}
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}
