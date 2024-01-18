//
//  HomeView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var searchTapped = false
    
    var body: some View {
        List {
            Section {
                Button("Search Events") {
                    searchTapped.toggle()
                }
                .listRowBackground(Color.orangeApp)
            } header: {
                Text("Header")
            }
        }
        .fullScreenCover(isPresented: $searchTapped) {
            SearchView()
        }
    }
}

#Preview {
    HomeView()
}
