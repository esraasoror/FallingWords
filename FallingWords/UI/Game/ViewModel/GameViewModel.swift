//
//  GameViewModel.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/23/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

protocol GameViewModelDelegate: class {
    /**
     display new answer propability on game view
     */
    func displayAnswer(_ answer: String)
    /**
     display new english text on game view
     */
    func displayEnglish(_ english: String)
    /**
     update score label with new score
     */
    func updateScore(_ score: Int)
}
class GameViewModel {
    
    // MARK: - private variables
    private let gameManager: GameManager
    private var score = 0
    // MARK: - public variables
    var delegate: GameViewModelDelegate? = nil
    
    init(withLevel level: Enums.Levels) {
        gameManager = GameManager(withLevel: level)
    }
    
    func startGame() {
        DispatchQueue.global().async {
            self.delegate?.displayEnglish(self.gameManager.currentWord.english)
            for answer in self.gameManager.answers{
                guard let view = self.delegate else {
                    return
                }
                sleep(self.gameManager.getSleepDuration())
                view.displayAnswer(answer.spanish)
            }
            sleep(self.gameManager.getSleepDuration())
            self.gameManager.intializeNextWord()
            self.startGame()
        }
    }
    
    func endGame() {
        self.delegate = nil
    }
    
    func isValidAnswer(_ answer: String) -> Bool {
        if gameManager.isValidAnswer(answer) {
            incrementScore()
            return true
        }
        return false
    }
    
    func incrementScore() {
        score += 1
        self.delegate?.updateScore(score)
    }
    
    func getTimer() -> Int {
        return gameManager.getGameDuration()
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getAnimationDuration() -> Int {
        return gameManager.getAnswersAnimationDuration()
    }
    
}
