//
//  SettingsView.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        List {
            Section {
                SettingsButtonView(sfSymbol: .envelopeFill, text:  "settings_feedback") { feedbackTapped() }
                SettingsButtonView(sfSymbol: .starFill, text:  "settings_review") { reviewTapped() }
                SettingsButtonView(sfSymbol: .messageFill, text:  "settings_recommend") { shareTapped() }
            } header: {
                Text("settings_general".localized)
            }
            
            Section {
                SettingsLinkView(urlString: SettingsConstants.privacyPolicyURL, sfSymbol: .privacy, text: "settings_privacy_policy")
                SettingsLinkView(urlString: SettingsConstants.termsOfUseURL, sfSymbol: .document, text: "settings_terms_of_use")
            } header: {
                Text("settings_privacy".localized)
            }
        }
    }
}

// MARK: - Methods
private extension SettingsView {
    @MainActor
    func feedbackTapped() {
        if let mailtoString = SettingsConstants.emailAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let mailtoUrl = URL(string: mailtoString),
           UIApplication.shared.canOpenURL(mailtoUrl) {
            UIApplication.shared.open(mailtoUrl)
        }
    }
    
    @MainActor
    func reviewTapped() {
        if let appStoreReviewUrl = URL(string: SettingsConstants.appStoreReviewURL),
           UIApplication.shared.canOpenURL(appStoreReviewUrl) {
            UIApplication.shared.open(appStoreReviewUrl)
        }
    }
    
    @MainActor
    func shareTapped() {
        let message = "settings_share_message".localized
        let link = URL(string: SettingsConstants.appLink)!
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let viewController = windowScene.windows.first?.rootViewController {
            let activityController = UIActivityViewController(activityItems: [message, link], applicationActivities: nil)
            // Set a sourceView for the UIPopoverPresentationController otherwise on iPad will crash
            activityController.popoverPresentationController?.sourceView = viewController.view
            viewController.present(activityController, animated: true, completion: nil)
        }
    }
}

#Preview {
    SettingsView()
}
