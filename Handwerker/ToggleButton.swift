import SwiftUI

struct ToggleButton: View {
    let title: String
    @Binding var selectedExtras: [String]

    var body: some View {
        Button(action: { toggle() }) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedExtras.contains(title) ? Color.blue.opacity(0.4) : Color.white.opacity(0.3))
                .cornerRadius(8)
        }
    }

    private func toggle() {
        if let index = selectedExtras.firstIndex(of: title) {
            selectedExtras.remove(at: index)
        } else {
            selectedExtras.append(title)
        }
    }
}
