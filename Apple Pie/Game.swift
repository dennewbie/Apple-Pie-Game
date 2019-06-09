//
//  Game.swift
//  Apple Pie
//
//  Created by Denny Caruso on 31/12/2018.
//  Copyright © 2018 Denny Caruso. All rights reserved.
//

import Foundation

struct Game {
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
        count += 1
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectWordRemaining -= 1
        
            if ViewController.shared.globalPoints > 0 {
                 ViewController.shared.globalPoints -= 1
            } else {
                ViewController.shared.globalPoints -= ViewController.shared.globalPoints
            }
        } else {
            ViewController.shared.globalPoints += 1
        }
        //print(ViewController.shared.globalPoints)
    }
}
