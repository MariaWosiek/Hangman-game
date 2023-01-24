//
//  Coordinator.swift
//  Hangman game
//
//  Created by Maria Wosiek on 20/01/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinatores: [Coordinator] { get }
    var navigationController: UINavigationController { get }

    func start()
}
