//
//  MainCoordinator.swift
//  Hangman game
//
//  Created by Maria Wosiek on 20/01/2023.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator, CategoriesViewModelCoordinatorDelegate, GameViewModelCoordinatorDelegate {
    
    private(set) var childCoordinatores = [Coordinator]()
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CategoriesViewController.instantiate()
        let vm = CategoriesViewModel(categoriesDataSource: CategoriesDataSource())
        vm.coordinatorDelegate = self
        vc.viewModel = vm
        navigationController.viewControllers = [vc]
    }

    func startGame(withCategory category: Category) {
        let vc = GameViewController.instantiate()
        let vm = GameViewModel(category: category)
        vm.coordinatorDelegate = self
        vc.gameViewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
    func gameOverAlert() {
        let alert = UIAlertController(title: "Game over", message: "You have completed all passwords in this category, please choose another.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.navigationController.popViewController(animated: true)
        }))
        navigationController.present(alert, animated: true)
    }
    
}
