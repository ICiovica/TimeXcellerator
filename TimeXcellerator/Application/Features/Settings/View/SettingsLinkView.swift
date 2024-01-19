//
//  SettingsLinkView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

struct SettingsLinkView: View {
    let urlString: String
    let sfSymbol: SFImages
    let text: String
    
    var body: some View {
        if let policyURL = URL(string: urlString) {
            Link(destination: policyURL) {
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
}

#Preview {
    SettingsLinkView(urlString: "", sfSymbol: .chevron, text: "")
}
