//
//  UIViewController+Extensions.swift
//  Hangman game
//
//  Created by Maria Wosiek on 27/01/2023.
//

import UIKit

extension UIViewController {
    func setGradientBackground() {
        let colorTop = Constants.Colors.gradientTopColor.cgColor
        let colorBottom = Constants.Colors.gradientBottomColor.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func showToast(message : String) {
        let toastLabel = UILabel()
        view.addSubview(toastLabel)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            toastLabel.heightAnchor.constraint(equalToConstant: 40),
            toastLabel.widthAnchor.constraint(equalToConstant: 300),
        ])

        toastLabel.backgroundColor = .black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 12)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 1.0
        }, completion: { isCompleted in
            UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { isCompleted in
                toastLabel.removeFromSuperview()
            })
        })
    }
}
