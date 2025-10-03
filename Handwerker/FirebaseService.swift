import Foundation
import FirebaseFirestore

struct FirestoreProvider: Codable {
    let name: String
    let beschreibung: String
    let kategorie: String
}

final class FirebaseService {
    private let db = Firestore.firestore()

    func fetchProviders() async throws -> [ServiceProvider] {
        let snapshot = try await db.collection("providers").getDocuments()
        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard let name = data["name"] as? String,
                  let beschreibung = data["beschreibung"] as? String,
                  let kategorie = data["kategorie"] as? String else { return nil }
            return ServiceProvider(name: name, beschreibung: beschreibung, kategorie: kategorie)
        }
    }
}
