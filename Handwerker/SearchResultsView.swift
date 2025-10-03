import SwiftUI

struct SearchResultsView: View {
    @EnvironmentObject var store: BookingStore
    @StateObject private var vm = ProvidersViewModel()
    @Binding var query: String

    var filtered: [Provider] {
        if query.isEmpty {
            return vm.providers
        }
        let lower = query.lowercased()
        return vm.providers.filter {
            $0.name.lowercased().contains(lower)
        }
    }

    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView()
            } else if let error = vm.error {
                VStack(spacing: 8) {
                    Text("Error: \(error.localizedDescription)")
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        Task {
                            await vm.load()
                        }
                    }
                }
                .padding()
            } else if filtered.isEmpty {
                ContentUnavailableView("No matching providers found.")
            } else {
                List(filtered) { provider in
                    NavigationLink(value: provider) {
                        HStack(spacing: 12) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                            VStack(alignment: .leading) {
                                Text(provider.name)
                                    .font(.headline)
                                if let tags = provider.tags, !tags.isEmpty {
                                    Text(tags.joined(separator: ", "))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .navigationDestination(for: Provider.self) { provider in
                        NeueBuchungView(providerName: provider.name)
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
