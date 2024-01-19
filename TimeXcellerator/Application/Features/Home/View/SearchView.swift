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
    
    var searchEvents: [Event] {
        guard !searchText.isEmpty else { return [] }
        return Events.list.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(searchEvents) { event in
                        NavigationLink {
                            VStack {
                                Text(event.title)
                                Text(event.description)
                            }
                        } label: {
                            Text(event.title)
                        }
                    }
                } header: {
                    if !searchEvents.isEmpty {
                        Text("\(searchEvents.count > 1 ? "Events" : "Event") Found")
                    }
                }
            }
            .scrollDisabled(true)
            .searchable(text: $searchText) {
                if !searchEvents.isEmpty {
                    ForEach(searchEvents) { event in
                        Text("Are you looking for **\(event.title)** ?").searchCompletion(event.title)
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
