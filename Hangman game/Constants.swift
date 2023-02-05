//
//  Constants.swift
//  Hangman game
//
//  Created by Maria Wosiek on 27/01/2023.
//

import UIKit

enum Constants {
    enum API {
        static let baseURL = URL(string: "https://api.mocklets.com/p68659/")!
    }
    
    enum Colors {
        static let primaryColor = UIColor(red: 179/255, green: 179/225, blue: 255/255, alpha: 1.0)
        static let secondaryColor = UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 173.0/255.0, alpha: 1.0)

        static let gradientTopColor = UIColor(
            red: 102.0/255.0, green: 0.0/255.0, blue: 102.0/255.0, alpha: 1.0)
        static let gradientBottomColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 153.0/255.0, alpha: 1.0)
    }
    
    enum Strings {
        static let gameOver = "game_over"
        static let gameFinishAlertMessage = "game_finish_alert_message"
        static let ok = "ok"
        static let gameAddPointMessage = "game_add_point_message"
        static let gameMinusPointMessage = "game_minus_point_message"
        static let gameScore = "game_score"
    }
}
