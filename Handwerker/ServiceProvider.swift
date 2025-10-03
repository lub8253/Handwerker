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
