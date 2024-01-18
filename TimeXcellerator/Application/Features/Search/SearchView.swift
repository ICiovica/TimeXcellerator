//
//  SearchView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    let events = ["Eat", "Sleep", "Call", "Meet"]
    
    var searchResults: [String] {
        guard !searchText.isEmpty else { return [] }
        return events.sorted().filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(searchResults, id: \.self) { event in
                        NavigationLink {
                            Text(event)
                        } label: {
                            Text(event)
                        }
                    }
                } header: {
                    if !searchResults.isEmpty {
                        Text("Events Found")
                    }
                }
            }
            .scrollDisabled(true)
            .searchable(text: $searchText) {
                if !searchResults.isEmpty {
                    ForEach(searchResults, id: \.self) { result in
                        Text("Are you looking for **\(result)** ?").searchCompletion(result)
                    }
                }
            }
            .navigationTitle("Search Events")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
