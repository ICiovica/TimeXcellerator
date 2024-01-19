//
//  HomeView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: Router
    @State private var searchTapped = false
    @State private var showPreviousEvents = false
    @State private var date: Date = .now
    @State private var presentCalendar = false
    
    var hours: Range<Int> {
        if showPreviousEvents {
            return 0..<24
        } else {
            let currentDate = Date()
            let currentHour = Calendar.current.component(.hour, from: currentDate)
            return currentHour..<24
        }
    }
    
    var filteredEvents: [Event] {
        Events.list.filter({ areSameDay(date1: $0.date, date2: date) })
    }
    
    var isSameDay: Bool {
        areSameDay(date1: date, date2: Date())
    }
    
    var body: some View {
        List {
            Section {
                Button("Search Events") {
                    searchTapped.toggle()
                }
                
                DatePicker(isSameDay ? "Current Day:" : "Selected Day:", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.automatic)
                    .tint(.redApp)
                
                Toggle("\(showPreviousEvents ? "Hide" : "Show") Previous Events", isOn: $showPreviousEvents)
            } header: {
                Text("Explore")
            }
            
            Section {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(hours, id: \.self) { hour in
                        HStack(spacing: 16) {
                            Text(hour > 9 ? "\(hour):00" : "0\(hour):00")
                                .frame(width: 50)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.grayApp)
                                .overlay {
                                    if let event = filteredEvents.first(where: { $0.startTime == hour }) {
                                        Button {
                                            router.navigate(to: [.event(event)])
                                        } label: {
                                            EventLinkView(title: event.title)
                                                .padding(.top, 36)
                                        }
                                    }
                                }
                        }
                    }
                }
            } header: {
                Text("Events")
            }
        }
        .fullScreenCover(isPresented: $searchTapped) {
            SearchView()
        }
    }
    
    func areSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        let components1 = calendar.dateComponents([.day, .month, .year], from: date1)
        let components2 = calendar.dateComponents([.day, .month, .year], from: date2)
        
        return components1.day == components2.day &&
        components1.month == components2.month &&
        components1.year == components2.year
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}

struct EventLinkView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
        .background(.redApp)
        .cornerRadius(8)
        .padding(.horizontal, 1)
    }
}

struct EventView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
            Text(event.description)
            Text(event.startTime.description)
            Text(event.duration.description)
        }
    }
}
