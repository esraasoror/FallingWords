//
//  HomeViewModel.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

class HomeViewModel {
    
    /**
      download words data from backend and update local storage 
     */
    func downloadWords() {
        WordsManager().downloadWords { (isSuccess) in
            print("words download result : \(isSuccess)")
        }
    }
    
    func getGameViewModel(forIndentifier identifier: String) -> GameViewModel {
        switch identifier {
        case "level1":
            return GameViewModel(withLevel: .level1)
        case "level2":
            return GameViewModel(withLevel: .level2)
        case "level3":
            return GameViewModel(withLevel: .level3)
        default:
            return GameViewModel(withLevel: .level1)
        }
    }
}
