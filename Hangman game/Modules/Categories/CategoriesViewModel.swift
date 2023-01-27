//
//  CategoriesViewModel.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation

protocol CategoriesViewModelDelegate: AnyObject {
    func startGame(withCategory category: Category)
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
        delegate?.startGame(withCategory: choosenCategory)
    }
}
