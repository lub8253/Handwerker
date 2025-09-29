import SwiftUI

enum Theme {
    // Dark, high-contrast background
    static let backgroundTop = Color(red: 0.07, green: 0.07, blue: 0.08) // ~#121314
    static let backgroundBottom = Color(red: 0.15, green: 0.16, blue: 0.18) // ~#272A2E
    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Theme.backgroundTop, Theme.backgroundBottom]),
        startPoint: .top,
        endPoint: .bottom
    )

    // Surfaces and strokes for cards
    static let card = Color.white.opacity(0.06)
    static let surface = Color.white.opacity(0.12)
    static let stroke = Color.white.opacity(0.10)

    // Text colors
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.85)

    // Accent colors (warm, high contrast)
    static let accent = Color.orange
    static let accentStrong = Color(red: 1.0, green: 0.55, blue: 0.0)
}
