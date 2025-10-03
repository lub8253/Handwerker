import SwiftUI
import Combine

@MainActor
final class ProvidersViewModel: ObservableObject {
    @Published var providers: [ServiceProvider] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let service = FirebaseService()

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await service.fetchProviders()
            self.providers = result
            self.errorMessage = nil
        } catch {
            self.providers = []
            self.errorMessage = "Konnte Anbieter nicht laden."
        }
    }
}

