//
//  String.swift
//  TimeXcellerator
//
//  Created by IonutCiovica on 18/01/2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
