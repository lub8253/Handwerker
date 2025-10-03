import SwiftUI

struct SucheView: View { @Binding var selectedTab: Int
    @EnvironmentObject var store: BookingStore
    @StateObject private var vm = ProvidersViewModel()
    @State private var query: String = ""

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
        NavigationStack {
            ZStack {
                Group {
                    if vm.isLoading {
                        ProgressView("Lade Anbieter…")
                    } else if let err = vm.errorMessage {
                        VStack(spacing: 12) {
                            Text(err)
                            Button("Erneut versuchen") { Task { await vm.load() } }
                                .buttonStyle(.borderedProminent)
                        }
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
                    }
                }
            }
            .appBackground()
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .searchable(text: $query, prompt: "Suche nach Name, Kategorie, …")
        .task { await vm.load() }
        .refreshable { await vm.load() }
    }
}

#Preview {
    SucheView(selectedTab: .constant(2))
        .environmentObject(BookingStore())
}
