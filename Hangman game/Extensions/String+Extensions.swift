//
//  String+Extensions.swift
//  Hangman game
//
//  Created by Maria Wosiek on 31/01/2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    var url: URL? {
        URL(string: self)
    }
}
