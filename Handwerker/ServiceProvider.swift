//
//  ServiceProvider.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import Foundation

struct ServiceProvider: Identifiable {
    let id = UUID()
    let name: String
    let beschreibung: String
    let kategorie: String
}

let serviceProviders: [ServiceProvider] = [
    // Reinigung
    ServiceProvider(name: "Käse Krainer", beschreibung: "Reinigung & Pflege", kategorie: "Reinigung"),
    ServiceProvider(name: "Putz-Profi", beschreibung: "Schnell & gründlich", kategorie: "Reinigung"),
    ServiceProvider(name: "Glanz & Gloria", beschreibung: "Fenster & Böden", kategorie: "Reinigung"),
    
    // Maler
    ServiceProvider(name: "Maler Max", beschreibung: "Streichen & Renovieren", kategorie: "Maler"),
    ServiceProvider(name: "Farb-Fee", beschreibung: "Individuelle Farbkonzepte", kategorie: "Maler"),
    
    // Bau
    ServiceProvider(name: "Bau Peter", beschreibung: "Bauarbeiten & Reparaturen", kategorie: "Bau"),
    ServiceProvider(name: "Maurer Maik", beschreibung: "Stein auf Stein", kategorie: "Bau"),
    
    // Elektro
    ServiceProvider(name: "Elektriker Emil", beschreibung: "Strom & Licht", kategorie: "Elektro"),
    ServiceProvider(name: "Kabel Klaus", beschreibung: "Sicher & zuverlässig", kategorie: "Elektro")
]
