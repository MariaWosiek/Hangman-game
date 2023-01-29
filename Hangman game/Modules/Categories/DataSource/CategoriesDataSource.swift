//
//  CategoriesDataSource.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation


protocol CategoriesDataSourceProtocol {
    func fetchCategories(completion: @escaping ([Category]) -> Void)
}

class CategoriesDataSource: CategoriesDataSourceProtocol {

    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let url = Bundle.main.url(forResource: "LocalCategories", withExtension: "json") else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Category].self, from: data)
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch {
                print("error: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
}
