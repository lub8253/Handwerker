//
//  ShapeStyle+Glass.swift
//  Handwerker
//
//  Created by Assistant on 29.09.25.
//

import SwiftUI

// Provides convenient aliases for a "glass" look using SwiftUI's built-in Material.
// This fixes usages like `.background(.glassBackground, in: Circle())` and
// `.background(.glassBarMaterial)` without changing existing view code.
extension ShapeStyle where Self == Material {
    /// A subtle, translucent material suitable for circular buttons and bubbles.
    static var glassBackground: Material { .ultraThinMaterial }

    /// A slightly stronger material suitable for bars/toolbars.
    static var glassBarMaterial: Material { .thinMaterial }
}
