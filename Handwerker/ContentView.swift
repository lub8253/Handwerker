//
//  ContentView.swift
//  Handwerker
//
//  Created by Lukas Brand on 26.09.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = BookingStore()
    @State private var selectedTab: Int = 0
    
    var body: some View {
        if #available(iOS 18.0, *) {
            TabView(selection: $selectedTab) {
                Tab(value: 0) {
                    StartseiteView()
                        .environmentObject(store)
                } label: {
                    Label("Startseite", systemImage: "house.fill")
                }

                Tab(value: 1) {
                    BuchungListView()
                        .environmentObject(store)
                } label: {
                    Label("Buchungen", systemImage: "book.fill")
                }

                Tab(value: 2, role: .search) {
                    SucheView(selectedTab: $selectedTab)
                        .environmentObject(store)
                } label: {
                    Label("Suche", systemImage: "magnifyingglass")
                }
            }
            .task { await store.startListeningIfPossible() }
        } else {
            TabView(selection: $selectedTab) {
                StartseiteView()
                    .environmentObject(store)
                    .tabItem {
                        Label("Startseite", systemImage: "house.fill")
                    }
                    .tag(0)

                BuchungListView()
                    .environmentObject(store)
                    .tabItem {
                        Label("Buchungen", systemImage: "book.fill")
                    }
                    .tag(1)

                SucheView(selectedTab: $selectedTab)
                    .environmentObject(store)
                    .tabItem {
                        Label("Suche", systemImage: "magnifyingglass")
                    }
                    .tag(2)
            }
            .task { await store.startListeningIfPossible() }
        }
    }
}

#Preview {
    ContentView()
}
