//
//  ViewControllerMulti.swift
//  Apple Pie
//
//  Created by Denny Caruso on 01/01/2019.
//  Copyright © 2019 Denny Caruso. All rights reserved.
//

import UIKit

class ViewControllerMulti: UIViewController {
    var currentGame: GameMulti!
    static let shared = ViewControllerMulti()
    
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
    var textScore: String = "Player 1 Turn"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = GameMulti(word: newWord, incorrectWordRemaining: incorrectMovesAllowed, guessedLetters: [], count: 0)
            enableLetterButtons(true)
            scoreLabel.text = "Player 1 Turn"
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
        scoreLabel.text = ViewControllerMulti.shared.textScore
        //print(textScore)
        threeImageView.image = UIImage(named: "Tree \(currentGame.incorrectWordRemaining)")
    }
    
    func updateGameState(){
        if currentGame.incorrectWordRemaining == 0 {
            totalLosses += 1
            
            scoreLabel.text = "You Lost"
            if ViewControllerMulti.shared.globalPoints > 3 {
                ViewControllerMulti.shared.globalPoints -= 3
               
            } else {
                ViewControllerMulti.shared.globalPoints -= ViewControllerMulti.shared.globalPoints
                
            }
            
            newRound()

        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            ViewControllerMulti.shared.globalPoints +=  3
            scoreLabel.text = "You Win"
            newRound()
        } else {
            updateUI()
        }
        //updateUI()
        updateUI()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}
