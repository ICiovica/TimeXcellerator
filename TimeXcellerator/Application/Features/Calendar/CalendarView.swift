//
//  CalendarView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
    
    var body: some View {
            List {
                Section {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .tint(.redApp)
                } header: {
                    Text("calendar_header".localized)
                }
        }
    }
}

#Preview {
    CalendarView()
}
