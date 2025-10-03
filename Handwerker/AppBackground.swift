import SwiftUI

struct AppBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color(red:0.91, green:0.91, blue:0.91)
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func appBackground() -> some View { modifier(AppBackground()) }
}
