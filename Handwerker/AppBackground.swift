import SwiftUI

struct AppBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .blue.opacity(0.7)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func appBackground() -> some View { modifier(AppBackground()) }
}
