//
//  GameMulti.swift
//  Apple Pie
//
//  Created by Denny Caruso on 01/01/2019.
//  Copyright © 2019 Denny Caruso. All rights reserved.
//

import Foundation

struct GameMulti {
    var word: String
    var incorrectWordRemaining: Int //incorrect moves Remaining error writing
    var guessedLetters: [Character]
    //var totalPoints: Int
    //var player: Int
    var count: Int
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectWordRemaining -= 1
            print("\(count % 2)")
            count += 1
            if count % 2 == 0 {
                ViewControllerMulti.shared.textScore = "Player 1 Turn"
            } else {
                ViewControllerMulti.shared.textScore = "Player 2 Turn"
            }
        //print(ViewController.shared.globalPoints)
    }
}
}
