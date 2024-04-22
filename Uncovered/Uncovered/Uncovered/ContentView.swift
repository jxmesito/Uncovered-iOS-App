//
//  ContentView.swift
//  Uncovered
//
//  Created by David Martinez on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var selection = 0

    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selection) {
                    HomeView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                        .accentColor(selection == 0 ? .green : nil) // Set green color when selected

                    CartView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "cart")
                            Text("Cart")
                        }
                        .tag(1)
                        .accentColor(selection == 1 ? .green : nil) // Set green color when selected
                    
                    ProfileView(viewModel: viewModel)
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                        .tag(2)
                        .accentColor(selection == 2 ? .green : nil) // Set green color when selected
                }
                .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    ContentView()
}
