//
//  Booking.swift
//  Handwerker
//
//  Created by Lukas Brand on 29.09.25.
//

import Foundation

struct Booking: Identifiable {
    let id = UUID()
    let providerName: String
    let date: String
    let time: String
    let extras: [String]
    let paymentMethod: String
}
