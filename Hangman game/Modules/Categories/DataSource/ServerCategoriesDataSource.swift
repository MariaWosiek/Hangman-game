//
//  CategoriesDataSource.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation

class ServerCategoriesDataSource: CategoriesDataSourceProtocol {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> ()) {
        let url = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Category].self, from: data)
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
}
