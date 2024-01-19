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
                    .foregroundStyle(.redApp)
                Text(text.localized)
                Spacer()
                SFImages.chevron.toImage()
                    .foregroundStyle(.redApp)
            }
        }
        .listRowBackground(Color.white)
    }
}

#Preview {
    SettingsButtonView(sfSymbol: .chevron, text: "") {}
}
