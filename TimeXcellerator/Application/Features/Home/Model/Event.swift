//
//  Event.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 19/01/2024.
//

import Foundation

struct Event: Identifiable, Hashable {
    let id = UUID().uuidString
    let title: String
    let description: String
    let startTime: Int
    let duration: Int
    let date: Date
}
enum Events {
    static let list: [Event] = [
        Event(title: "Eat", description: "Breakfast", startTime: 10, duration: 60, date: .now),
        Event(title: "Eat", description: "Lunch", startTime: 12, duration: 90, date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!),
        Event(title: "Meet", description: "John", startTime: 14, duration: 30, date: .now),
        Event(title: "Sleep", description: "22:00", startTime: 15, duration: 15, date: .now)
    ]
}
