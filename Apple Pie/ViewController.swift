//
//  ViewController.swift
//  Apple Pie
//
//  Created by Denny Caruso on 31/12/2018.
//  Copyright © 2018 Denny Caruso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentGame: Game!
    static let shared = ViewController()
    
    @IBOutlet weak var threeImageView: UIImageView! //tree, not three
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var listOfWords = ["entertainment", "flaghsip", "spooky", "intelligent", "swift", "beneficial", "satisfying", "enthusiastic", "pizza", "hysterical", "developer", "surprise", "spoon", "blue"]
    let incorrectMovesAllowed = 3
    var totalWins = 0
    var totalLosses = 0
    var globalPoints = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }


    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectWordRemaining: incorrectMovesAllowed, guessedLetters: [], count: 0)
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
            updateUI()
        }
    }
    
    func updateUI(){
        var letters = [String]()
        //old method
    /*  for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
    */
        //new way
        letters = Array(currentGame.formattedWord.characters).map { String($0) }

        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Loses: \(totalLosses), Points: \(ViewController.shared.globalPoints)"
        threeImageView.image = UIImage(named: "Tree \(currentGame.incorrectWordRemaining)")
    }
    
    func updateGameState(){
        if currentGame.incorrectWordRemaining == 0 {
            totalLosses += 1
            if ViewController.shared.globalPoints > 3 {
                ViewController.shared.globalPoints -= 3
            } else {
                ViewController.shared.globalPoints -= ViewController.shared.globalPoints
            }
            newRound()
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            ViewController.shared.globalPoints +=  3
            newRound()
        } else {
            updateUI()
        }
        updateUI()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}

