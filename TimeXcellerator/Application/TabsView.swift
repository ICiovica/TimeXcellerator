//
//  TabsView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

enum Tab {
    case home
    case calendar
    case alerts
    case settings
}

struct TabsView: View {
    @State private var selectedTab: Tab = .home
    @State private var shortFormatDate = ""
    @State private var fullFormatDate = ""
    @State private var isDaytime = false
    
    private var navigationTitle: String {
        switch selectedTab {
        case .home:
            fullFormatDate
        case .calendar:
            "Calendar"
        case .alerts:
            "Alerts"
        case .settings:
            "Settings"
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                Group {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(Tab.home)
                    CalendarView()
                        .tabItem {
                            Label(shortFormatDate, systemImage: "calendar")
                        }
                        .tag(Tab.calendar)
                    AlertsView()
                        .tabItem {
                            Label("Alerts", systemImage: "bell.fill")
                        }
                        .tag(Tab.alerts)
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                        .tag(Tab.settings)
                }
                .font(.system(.headline, design: .rounded, weight: .medium))
                .tint(.blueApp)
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    toolbarImage
                        .foregroundStyle(.blueApp)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    toolbarImage
                        .foregroundStyle(.blueApp)
                        .rotationEffect(.degrees(270))
                }
            }
            .tint(.redApp)
            .contentTransition(.symbolEffect(.replace))
            .onAppear {
                getDate()
            }
        }
    }
}

// MARK: - Methods
private extension TabsView {
    func getDate() {
        let currentDate = Date()
        
        let fullFormatFormatter = DateFormatter()
        fullFormatFormatter.dateFormat = "EEEE, d MMMM yyyy"
        fullFormatDate = fullFormatFormatter.string(from: currentDate)
        
        let shortFormatFormatter = DateFormatter()
        shortFormatFormatter.dateFormat = "d MMMM"
        shortFormatDate = shortFormatFormatter.string(from: currentDate)
        
        let currentHour = Calendar.current.component(.hour, from: currentDate)
        isDaytime = (6...18).contains(currentHour)
    }
}

// MARK: - Views {
private extension TabsView {
    var toolbarImage: some View {
        if isDaytime {
            return SFImages.sun.toImage(frame: 24)
        } else {
            return SFImages.moon.toImage(frame: 24)
        }
    }
}

#Preview {
    TabsView()
}