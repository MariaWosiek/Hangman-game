//
//  GameViewModel.swift
//  Hangman game
//
//  Created by Maria Wosiek on 22/01/2023.
//

import Foundation
import UIKit.UIImage

protocol GameViewModelControllerDelegate: AnyObject {
    func resetButtonsState()
    func showToastMessage(message: String)
    func updateScreen()
}

protocol GameViewModelCoordinatorDelegate: AnyObject {
    func gameOverAlert()
}

class GameViewModel {
    private(set) var passwordWord: String = ""
    private(set) var hangmanImage: UIImage?
    private(set) var score: Int = 0
    private(set) var butttonEnabled = true
    
    weak var coordinatorDelegate: GameViewModelCoordinatorDelegate?
    weak var controllerDelegate: GameViewModelControllerDelegate?

    private var inncorectTapsCounter: Int = 0
    private var word: String = ""
    private var unusedWords = [String]()
    private var timer: Timer?

    init(category: Category) {
        unusedWords = category.words
        loadNewWord()
    }
    
    deinit {
        timer?.invalidate()
    }

    func characterTapped(choosenCharacter: Character) {
        if word.uppercased().contains(choosenCharacter) {
            showLetter(selectedLetter: choosenCharacter)
        } else {
            inncorectTapsCounter += 1
            updateHangmanImage()
        }

        if !passwordWord.contains(Character("_")) {
            controllerDelegate?.showToastMessage(message: "Congratulation, you have won 1 point")
            unusedWords.removeAll(where: { $0 == word })
            score += 1
            startTimer()
        }
        
        if inncorectTapsCounter == 10 {
            controllerDelegate?.showToastMessage(message: "Sorry, you have lost 1 point, try again.")
            score -= 1
            unusedWords.removeAll(where: { $0 == word })
            startTimer()
        }

        if unusedWords.isEmpty {
            coordinatorDelegate?.gameOverAlert()
            timer?.invalidate()
        }
        controllerDelegate?.updateScreen()
    }

    private func loadNewWord() {
        prepareWord()
        inncorectTapsCounter = 0
        updateHangmanImage()
        controllerDelegate?.resetButtonsState()
    }
    
    private func updateHangmanImage() {
        hangmanImage = UIImage(named: "Hangman\(inncorectTapsCounter + 1)-11")
    }

    private func prepareWord() {
        word = unusedWords.randomElement() ?? ""
        print("Word: \(word)")

        passwordWord = word
            .split(separator: " ")
            .map { singleWord in
                singleWord
                    .map { _ in "_" }
                    .joined(separator: " ")
            }
            .joined(separator: "\n")
    }

    private func showLetter(selectedLetter: Character) {
        var indexes: [Int] = []
        for (index, character) in word.uppercased().enumerated() {
            if selectedLetter == character {
                indexes.append(index)
            }
        }

        var array = Array(passwordWord)
        for index in indexes {
            let stringIndex = word.index(word.startIndex, offsetBy: index)
            let newLinesCounter = word[word.startIndex...stringIndex]
                .filter { $0 == " " }
                .count
            array[(index - newLinesCounter) * 2] = selectedLetter
        }
        passwordWord = String(array)
    }
    
    private func startTimer() {
        butttonEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self] _ in
            self?.loadNewWord()
            self?.butttonEnabled = true
            self?.controllerDelegate?.updateScreen()
        })
    }
}
