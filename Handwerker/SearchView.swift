import SwiftUI

struct SearchView: View {
    @EnvironmentObject var store: BookingStore
    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""

    // Combined search across name, description, and category
    var filteredProviders: [ServiceProvider] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return serviceProviders }
        return serviceProviders.filter { provider in
            provider.name.localizedCaseInsensitiveContains(q) ||
            provider.beschreibung.localizedCaseInsensitiveContains(q) ||
            provider.kategorie.localizedCaseInsensitiveContains(q)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .blue.opacity(0.7)]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                List {
                    if filteredProviders.isEmpty {
                        Text("Keine Treffer")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(filteredProviders) { provider in
                            NavigationLink(
                                destination: NeueBuchungView(providerName: provider.name)
                                    .environmentObject(store)
                            ) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(provider.name)
                                        .font(.headline)
                                    Text("Kategorie: \(provider.kategorie)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text(provider.beschreibung)
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 6)
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Suche")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(8)
                            .background(.glassBackground, in: Circle())
                    }
                }
            }
        }
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Suche nach Name, Kategorie, ..."))
        .onAppear { 
            // Optionally pre-focus keyboard on appear (best-effort)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // No direct API to focus .searchable field programmatically, left intentional.
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(BookingStore())
}
