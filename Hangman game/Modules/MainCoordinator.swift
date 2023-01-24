//
//  MainCoordinator.swift
//  Hangman game
//
//  Created by Maria Wosiek on 20/01/2023.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator, CategoriesViewModelDelegate {
    private(set) var childCoordinatores = [Coordinator]()
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CategoriesViewController.instantiate()
        let vm = CategoriesViewModel(categoriesDataSource: CategoriesDataSource())
        vm.delegate = self
        vc.viewModel = vm
        navigationController.viewControllers = [vc]
    }

    func startGame(withWord word: String) {
        navigationController.pushViewController(UIViewController(), animated: true)
        print("word: \(word)")
    }
}
