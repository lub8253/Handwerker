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
    @State private var suchText: String = ""
    
    
    var body: some View {
        Group{
            if #available(iOS 26, *){
                NativeTabView()
                    .tabBarMinimizeBehavior(.onScrollDown)
                    .tabViewBottomAccessory{
                        TestView()
                    }
            } else {
                NativeTabView()
            }
        }
    }
    
    
    @ViewBuilder
    func NativeTabView() -> some View {
        TabView{
            Tab.init("Start", systemImage: "house.fill"){
                    StartseiteView()
            }
            Tab.init("Buchungen", systemImage: "book.fill"){}
            Tab.init("Suche", systemImage: "magnifyingglass", role: .search){
                NavigationStack{
                    List{}
                        .navigationTitle("Suche")
                        .searchable(text: $suchText, placement: .toolbar, prompt: Text("Suche..."))
                }
            }
        }
    }
}

@ViewBuilder
func TestView() -> some View {
    Text("Hello, World!")
}

#Preview {
    ContentView()
}
