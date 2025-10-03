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
                                    Text(provider.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(provider.kategorie)
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.85))
                                    Text(provider.beschreibung)
                                        .font(.footnote)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    .glassBackground,
                                    in: RoundedRectangle(cornerRadius: 16, style: .continuous)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .stroke(Color.white.opacity(0.15))
                                )
                                .accessibilityHint("Termin bei \(provider.name) buchen")
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
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
