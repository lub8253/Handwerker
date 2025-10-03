// UNUSED: This view is not referenced anywhere. Consider deleting this file to reduce clutter.
// Keeping temporarily for reference/previews.

import SwiftUI

struct SearchResultsView: View {
    @EnvironmentObject var store: BookingStore
    @StateObject private var vm = ProvidersViewModel()
    @Binding var query: String

    var filtered: [ServiceProvider] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return vm.providers }
        return vm.providers.filter {
            $0.name.localizedCaseInsensitiveContains(q)
            || $0.beschreibung.localizedCaseInsensitiveContains(q)
            || $0.kategorie.localizedCaseInsensitiveContains(q)
        }
    }

    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView()
            } else if let err = vm.errorMessage {
                VStack(spacing: 8) {
                    Text(err)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        Task {
                            await vm.load()
                        }
                    }
                }
                .padding()
            } else if filtered.isEmpty {
                ContentUnavailableView("Keine Treffer",
                                       systemImage: "magnifyingglass",
                                       description: Text("Versuche einen anderen Suchbegriff."))
            } else {
                List(filtered) { provider in
                    NavigationLink {
                        NeueBuchungView(providerName: provider.name)
                            .environmentObject(store)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(provider.name).font(.headline)
                            Text(provider.kategorie)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(provider.beschreibung)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .accessibilityHint("Termin bei \(provider.name) buchen")
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .refreshable {
                    await vm.load()
                }
            }
        }
        .task {
            await vm.load()
        }
    }
}

#Preview {
    SearchResultsView(query: .constant(""))
        .environmentObject(BookingStore())
}

