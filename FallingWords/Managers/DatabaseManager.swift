//
//  DatabaseManager.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager: NSObject {
    
    // MARK: - private variables
    private let realm = try? Realm()
    
    // MARK: - Configuration Method
    /**
     Configure the database version to be more than the old one because we added columns to the model object
     */
    func configureRealm() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            schemaVersion: 1,
            // Set the block when opening a Realm with a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: - Get Methods
    /**
     Get the word from the database.
     - Parameters:
     - english: The *english text* of the word required.
     - Returns: Word copy from database.
     */
    func getWord(byEnglish english: String) -> Word? {
        guard let realm = self.realm else { return nil }
        let wordsList = realm.objects(Word.self).filter("english == '\(english)'")
        return wordsList.first?.clone()
    }
    /**
     Get all words in the database.
     - Returns: Words array copy from database.
     */
    func getWordsList() -> [Word] {
        guard let realm = self.realm else { return [] }
        let wordsList = realm.objects(Word.self)
        var allWords = [Word]()
        wordsList.forEach { word in
            allWords.append(word.clone())
        }
        return allWords
    }
    /**
     Get all wrong translations for an english text.
     - Parameters:
     - english: The *length* of the barcode.
     - Returns: Words array copy from database.
     */
    func geWrongTranslations(forEnglish english: String) -> [Word] {
        guard let realm = self.realm else { return [] }
        let wordsList = realm.objects(Word.self).filter("english != \"\(english)\"")
        var allWords = [Word]()
        wordsList.forEach { word in
            allWords.append(word.clone())
        }
        return allWords
    }
    
    // MARK: - Save Methods
    /**
     Add or Update the word to the database.
     - Parameters:
     - word: The *word* required to be added.
     */
    func saveWord(_ word: Word) {
        guard let realm = self.realm else { return }
        try? realm.write {
            realm.add(word, update: Realm.UpdatePolicy.all)
        }
    }
}

