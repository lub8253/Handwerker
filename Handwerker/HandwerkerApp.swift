//
//  HandwerkerApp.swift
//  Handwerker
//
//  Created by Lukas Brand on 26.09.25.
//

import SwiftUI
import FirebaseAuth

@main
struct HandwerkerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let store = BookingStore()
            ContentView()
                .environmentObject(store)
                .task {
                    // Anonymous sign-in for a quick unique user ID
                    do {
                        let _ = try await Auth.auth().signInAnonymously()
                    } catch {
                        // Handle auth error if needed
                    }
                    await store.startListeningIfPossible()
                }
        }
    }
}
