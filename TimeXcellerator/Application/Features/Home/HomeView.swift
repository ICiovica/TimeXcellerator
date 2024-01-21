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
                
                DatePicker(isSameDay ? "Today:" : "Selected Date:", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.automatic)
                    .tint(.redApp)
                
                Toggle("\(showPreviousEvents ? "Hide" : "Show") Previous Events", isOn: $showPreviousEvents)
            } header: {
                Text("Explore")
            }
            .listRowBackground(Color.white)
            
            Section {
                LazyVStack(alignment: .leading, spacing: 6) {
                    ForEach(hours, id: \.self) { hour in
                        HStack(spacing: 16) {
                            Text(hour > 9 ? "\(hour):00" : "0\(hour):00")
                                .frame(width: 50)
                            
                            if let events = filteredEventsByHour(hour), events.count > 1 {
                                EventLinkView(title: "Multiple Events") { router.navigate(to: [.events(events)]) }
                            } else if let event = filteredEventsByHour(hour)?.first {
                                EventLinkView(title: event.title) { router.navigate(to: [.event(event)])}
                            } else {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundStyle(.grayApp)
                            }
                        }
                        .frame(height: 28)
                    }
                }
            } header: {
                Text("Events")
            }
            .listRowBackground(Color.white)
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
    
    func filteredEventsByHour(_ hour: Int) -> [Event]? {
        let events = filteredEvents.filter({ $0.startTime == hour })
        guard !events.isEmpty else { return nil }
        return events
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}

struct EventLinkView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            SFImages.timer.toImage()
                .padding(6)
            Text(title)
            Spacer()
            SFImages.chevron.toImage()
        }
        .background(Color.redApp)
        .foregroundStyle(.white)
        .cornerRadius(6)
        .onTapGesture { action() }
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

#Preview {
    SettingsButtonView(sfSymbol: .chevron, text: "") {}
}
