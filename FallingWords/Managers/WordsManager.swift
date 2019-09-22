//
//  WordsManager.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class WordsManager: NSObject {
    
    // MARK: - Api Methods
    /**
     Download the Projects from the Api. Then save them to database, then download and pasre
     its products files
     - Parameters:
     - completion: It's called when the download is done or failed. In case of fail it will
     return false and if it's done it returns true.
     */
    func downloadWords(_ completion: @escaping (Bool) -> Void) {
        let networkManager = NetworkManager()
        networkManager.getRequestFrom(url: Constants.BackendRequests.allWordsGetURL,
                                      onSuccess: { responseData in
                                        if let wordsJsonArray = JSON(responseData).array {
                                            let databaseManager = DatabaseManager()
                                            wordsJsonArray.forEach { json in
                                                let word = Word(value: json)
                                                databaseManager.saveWord(word)
                                            }
                                            completion(true)
                                        }
            }, onError: {
                completion(false)
        })
    }
    // MARK: - Get Methods
    /**
     Returns a word using its english text.
     - Parameters:
     - english: The *english text* of the *word* required.
     - Returns: A word object from database.
     */
    func getWord(withEnglishText english: String) -> Word? {
        return DatabaseManager().getWord(byEnglish: english)
    }
    
    /**
     Get all words in the database.
     - Returns: Words array copy from database.
     */
    func getWordsList() -> [Word] {
        return DatabaseManager().getWordsList()
    }
    
    /**
     Get all wrong translations for an english text.
     - Parameters:
     - english: The *length* of the barcode.
     - Returns: Words array copy from database.
     */
    func geWrongTranslations(forEnglish english: String) -> [Word] {
       return DatabaseManager().geWrongTranslations(forEnglish: english)
    }
}

