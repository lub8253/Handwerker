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
//        Group{
//            if #available(iOS 26, *){
                NativeTabView()
                    .tabBarMinimizeBehavior(.onScrollDown)
                    .tabViewBottomAccessory{
                        TestPlayer()
                    }
            } //else {
  //              NativeTabView()
  //          }
  //      }
  //  }
    
    
    @ViewBuilder
    func NativeTabView() -> some View {
        TabView{
            Tab.init("Start", systemImage: "house.fill"){
                StartseiteView().environmentObject(store)
                /*NavigationStack {
                    List{
                        
                    }
                    .navigationTitle("Home")
                }*/
            }
            Tab.init("Buchungen", systemImage: "book.fill") {
                  NavigationStack {
                      List(0..<100, id: \.self) { i in
                          Text("Eintrag \(i)")
                      }
                      .navigationTitle("Buchungen")
                  }
              }
            Tab.init("Notizen", systemImage: "airplane"){
                NavigationStack {
                    List(0..<100, id: \.self) { i in
                        Text("Eintrag \(i)")
                    }
                    .navigationTitle("Notizen")
                }
                
            }
            Tab.init("Test", systemImage: "paperplane"){
                NavigationStack {
                    List{
                        
                    }
                    .navigationTitle("Papier")
                }
                
            }
            Tab.init("Suche", systemImage: "line.3.horizontal.decrease", role: .search){
                NavigationStack{
                    List{}
                        .navigationTitle("Suche")
                        .searchable(text: $suchText, placement: .toolbar, prompt: Text("Suche..."))
                }
            }
        }
    }
    
    
    @ViewBuilder
    func TestView(_ size: CGSize) -> some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: size.height / 4)
                .fill(.blue.gradient)
                .frame(width: size.width, height: size.height)
            VStack(alignment: .leading, spacing: 6) {
                Text("Some Titke")
                    .font(.callout)
                
                Text("Der Sänder")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
        }
    }
    
    @ViewBuilder
    func TestPlayer() -> some View {
        HStack(spacing: 12) {
            TestView(.init(width: 30, height: 30))
            
            Spacer(minLength: 0)
            
            Button{
                
            } label: {
                Image(systemName: "play.fill")
                    .contentShape(.rect)
            }
            .padding(.trailing, 10)
            
            Button{
                
            } label: {
                Image(systemName: "forward.fill")
                    .contentShape(.rect)
            }
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    ContentView()
}
