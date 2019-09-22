//
//  Word.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Word: Object {
    
    @objc dynamic var english = ""
    @objc dynamic var spanish = ""
    
    override static func primaryKey() -> String? {
        return "english"
    }
    
    /**
     this function to return a new refrence not the database reference
     - Returns: Word
     */
    func clone() -> Word {
        let wordClone = Word()
        wordClone.english = english
        wordClone.spanish = spanish
        return wordClone
    }
    
    convenience init(value: JSON) {
        self.init()
        self.english = value["text_eng"].string ?? ""
        self.spanish = value["text_spa"].string ?? ""
    }
    
}

