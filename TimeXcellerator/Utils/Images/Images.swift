//
//  Images.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import SwiftUI

// MARK: - Images
enum Images: String {
    case appIcon
}

extension Images {
    var toImage: Image {
        Image(rawValue)
    }
}

// MARK: - SFImages
enum SFImages: String {
    case messageFill = "message.fill"
    case envelopeFill = "envelope.fill"
    case starFill = "star.fill"
    case privacy = "lock.fill"
    case document = "doc.fill"
    case chevron = "chevron.right"
    case laurelLeading = "laurel.leading"
    case laurelTrailing = "laurel.trailing"
    case sun = "sun.max.circle.fill"
    case moon = "moon.circle.fill"
}

extension SFImages {
    func toImage(frame: CGFloat = 19) -> some View {
        VStack {
            Image(systemName: rawValue)
                .resizable()
                .scaledToFit()
        }
        .frame(width: frame, height: frame)
    }
}

// MARK: - Icons
enum Icons: String {
    case appIcon
}

extension Icons {
    var toImage: Image {
        Image(rawValue)
    }
}
