//
//  Category.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation

struct Category: Decodable {
    let categoryName: String
    let categoryImage: String
    let words: [String] 
}
