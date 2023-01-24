//
//  CategoriesViewModel.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation

protocol CategoriesViewModelDelegate: AnyObject {
    func startGame(withWord word: String)
}

class CategoriesViewModel {
    
    weak var delegate: CategoriesViewModelDelegate?
    
    private(set) var categories:[Category] = []
    
    private let categoriesDataSource: CategoriesDataSourceProtocol
    
    init(categoriesDataSource: CategoriesDataSourceProtocol) {
        self.categoriesDataSource = categoriesDataSource
        loadData()
    }
    
    private func loadData() {
        categories = categoriesDataSource.fetchCategories()
    }
    
    func categoryTapped(choosenCategory: Category) {
        guard let word = choosenCategory.words.randomElement() else { return }
        delegate?.startGame(withWord: word)
    }
}
