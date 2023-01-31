//
//  GameViewController.swift
//  Hangman game
//
//  Created by Maria Wosiek on 20/01/2023.
//

import UIKit

class GameViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var hangmanImageView: UIImageView!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var lettersContainerView: UIView!
    
    private var buttonsArray = [UIButton]()
    
    var gameViewModel: GameViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameViewModel.controllerDelegate = self
        configureView()
        updateScreen()
    }

    private func configureView() {
        createButtons()
        passwordLabel.font = .systemFont(ofSize: 30, weight: .light)
        passwordLabel.textColor = Constants.Colors.primaryColor
        hangmanImageView.tintColor = Constants.Colors.primaryColor
        scoreLabel.textColor = Constants.Colors.primaryColor
        navigationController?.navigationBar.tintColor = Constants.Colors.primaryColor
        setGradientBackground()
    }
    
    private func createButtons() {
        let startChar = Unicode.Scalar("A").value
        let endChar = Unicode.Scalar("Z").value

        let chunkSize = 4
        let alphabet = (startChar...endChar)
            .compactMap { Unicode.Scalar($0) }
            .map { String($0) }
            .chunked(into: chunkSize)

        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 30
        
        for alphabetChunk in alphabet {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            
            for char in alphabetChunk {
                let button = UIButton(type: .system)
                button.setTitle(char, for: .normal)
                button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
                button.tintColor = Constants.Colors.primaryColor
                buttonsArray.append(button)

                stackView.addArrangedSubview(button)
            }
            for _ in alphabetChunk.count..<chunkSize {
                stackView.addArrangedSubview(UIView())
            }

            mainStackView.addArrangedSubview(stackView)
        }
        
        lettersContainerView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: lettersContainerView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: lettersContainerView.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: lettersContainerView.trailingAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: lettersContainerView.leadingAnchor),
        ])
    }
    
    @objc
    private func buttonClicked(_ sender: UIButton) {
        guard let letterSelected = sender.titleLabel?.text else {
            return
        }
        sender.isEnabled = false
        gameViewModel.characterTapped(choosenCharacter: Character(letterSelected))
    }
}

// MARK: - GameViewModelControllerDelegate
extension GameViewController: GameViewModelControllerDelegate {

    func resetButtonsState() {
        for button in buttonsArray {
            button.isEnabled = true
        }
    }
    
    func showToastMessage(message: String) {
        showToast(message: message)
    }
    func updateScreen() {
        UIView.transition(
            with: view,
            duration: 0.2,
            options: [
                .transitionCrossDissolve,
                .allowUserInteraction,
            ],
            animations: { [weak self] in
                self?.passwordLabel.text = self?.gameViewModel.passwordWord
                self?.hangmanImageView.image = self?.gameViewModel.hangmanImage?.withRenderingMode(.alwaysTemplate)
                
                let score = self?.gameViewModel.score ?? 0
                let formattedString = String(format: Constants.Strings.gameScore.localized, score)
                
                self?.scoreLabel.text = formattedString
            }
        )
        
        view.isUserInteractionEnabled = gameViewModel.butttonEnabled
    }
}
