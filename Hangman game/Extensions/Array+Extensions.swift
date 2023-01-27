//
//  Array+Extensions.swift
//  Hangman game
//
//  Created by Maria Wosiek on 27/01/2023.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
