//
//  CategoriesDataSource.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation

protocol CategoriesDataSourceProtocol {
    func fetchCategories() -> [Category]
}

class CategoriesDataSource: CategoriesDataSourceProtocol {
        
    func fetchCategories() -> [Category] {
        guard let url = Bundle.main.url(forResource: "LocalCategories", withExtension: "json") else { return [] }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Category].self, from: data)
            return jsonData
        } catch {
            print("error: \(error)")
        }
        return []
    }
}
