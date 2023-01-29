//
//  CategoriesViewModel.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation

protocol CategoriesViewModelCoordinatorDelegate: AnyObject {
    func startGame(withCategory category: Category)
}

protocol CategoriesViewModelControllerDelegate: AnyObject {
    func reloadData()
}

class CategoriesViewModel {
    private(set) var categories: [Category] = []

    weak var coordinatorDelegate: CategoriesViewModelCoordinatorDelegate?
    weak var controllerDelegate :CategoriesViewModelControllerDelegate?
        
    private let categoriesDataSource: CategoriesDataSourceProtocol
    
    init(categoriesDataSource: CategoriesDataSourceProtocol) {
        self.categoriesDataSource = categoriesDataSource
        loadData()
    }
    
    private func loadData() {
        categoriesDataSource.fetchCategories(completion: { [weak self] in
            self?.categories = $0
            self?.controllerDelegate?.reloadData()
        })
    }
    
    func categoryTapped(choosenCategory: Category) {
        coordinatorDelegate?.startGame(withCategory: choosenCategory)
    }
}
