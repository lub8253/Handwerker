//
//  ContentView.swift
//  Handwerker
//
//  Created by Lukas Brand on 26.09.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = BookingStore()
    
    var body: some View {
        TabView {
            StartseiteView()
                .environmentObject(store)
                .tabItem {
                    Label("Startseite", systemImage: "house.fill")
                }
            
            BuchungListView()
                .environmentObject(store)
                .tabItem {
                    Label("Buchungen", systemImage: "book.fill")
                }
            
            SucheView()
                .tabItem {
                    Label("Suche", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}

