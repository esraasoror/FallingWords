//
//  WordsDataTests.swift
//  FallingWordsTests
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import XCTest
@testable import FallingWords

class WordsDataTests: XCTestCase {

    var wordsManager: WordsManager!
    
    override func setUp() {
        wordsManager = WordsManager()
    }
    
    func testDownloadWords() {
        let expectation = XCTestExpectation(description: "Download Words")
        wordsManager.downloadWords({ (isSuccess) in
            XCTAssertTrue(isSuccess, "Failed to download words.")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetWordWithEnglishText() {
        guard let word = wordsManager.getWord(withEnglishText: "class") else {
            XCTFail("Failed to get word with english text 'class' from local storage.")
            return
        }
        XCTAssertEqual(word.spanish, "curso", "Failed to get correct translation for the english text 'class'")
    }
    
    func testGetRandomWrongTranslationForWordWithEnglishText() {
        let wrongTranslations = wordsManager.geWrongTranslations(forEnglish: "class")
        guard wrongTranslations.count > 0, let randomWord = wrongTranslations.randomElement() else {
            XCTFail("Failed to get wrong translations for word with english text 'class' from local storage.")
            return
        }
        
        XCTAssertNotEqual(randomWord.spanish, "curso", "Failed to get correct translation for the english text 'class'")
    }
    
    override func tearDown() {
    }
}
