//
//  SettingsButtonView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

struct SettingsButtonView: View {
    let sfSymbol: SFImages
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 15) {
                sfSymbol.toImage()
                Text(text.localized)
                Spacer()
                SFImages.chevron.toImage()
            }
        }
        .listRowBackground(Color.white)
    }
}

#Preview {
    SettingsButtonView(sfSymbol: .chevron, text: "") {}
}
