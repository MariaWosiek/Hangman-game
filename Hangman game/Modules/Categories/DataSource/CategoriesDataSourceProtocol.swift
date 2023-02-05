//
//  CategoriesDataSourceProtocol.swift
//  Hangman game
//
//  Created by Maria Wosiek on 03/02/2023.
//

import Foundation

protocol CategoriesDataSourceProtocol {
    func fetchCategories(completion: @escaping ([Category]) -> Void)
}
