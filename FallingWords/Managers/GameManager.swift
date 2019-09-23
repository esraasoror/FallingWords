//
//  GameManager.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

class GameManager {
    
    // MARK: - private variables
    private let wordsManager = WordsManager()
    private let level: Enums.Levels
    // MARK: - public variables
    var answers = [Word]()
    var currentWord = Word()
    
    init(withLevel level : Enums.Levels) {
        self.level = level
        intializeNextWord()
    }
    
    func intializeNextWord() {
        guard let word = wordsManager.getWordsList().randomElement() else {
            currentWord = Word()
            return
        }
        answers.removeAll()
        currentWord = word
        answers.append(word)
        let wrongAnswers = wordsManager.geWrongTranslations(forEnglish: word.english)
        for _ in 0...self.getAnswersCount() {
            if let randomAnswer = wrongAnswers.randomElement(){
                answers.append(randomAnswer)
            }
        }
        answers.sort(by: {$0.english > $1.english})
    }
    
    func getAnswersCount() -> Int{
        switch self.level {
        case .level1:
            return 5
        case .level2:
            return 10
        case .level3:
            return 15
        }
    }
    
    func getDuration() -> Int{
        switch self.level {
        case .level1:
            return 180
        case .level2:
            return 120
        case .level3:
            return 100
        }
    }
    
    func isValidAnswer(_ answer: String) -> Bool {
        return answer.elementsEqual(self.currentWord.spanish)
    }
}
