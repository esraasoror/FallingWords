//
//  GameManagerTests.swift
//  FallingWordsTests
//
//  Created by Esraa Yasser on 9/23/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import XCTest
@testable import FallingWords

class GameManagerTests: XCTestCase {

    var gameManager: GameManager!
    
    override func setUp() {
    }
    
    func testGameDurationForLevel1() {
        gameManager = GameManager(withLevel: .level1)
        XCTAssertEqual(gameManager.getGameDuration(), 120, "Game duration for level1 does not equal 120 seconds")
    }
    
    func testWrongAnswersCountForLevel2() {
        gameManager = GameManager(withLevel: .level2)
        XCTAssertEqual(gameManager.getAnswersCount(), 10, "Game wrong answers count for level 2 does not equal 10")
    }
    
    func testSleepDurationForLevel3() {
        gameManager = GameManager(withLevel: .level3)
        XCTAssertEqual(gameManager.getSleepDuration(), 1, "Game sleep duration for level 3 does not equal 1 second")
    }
    
    override func tearDown() {
    }
}
