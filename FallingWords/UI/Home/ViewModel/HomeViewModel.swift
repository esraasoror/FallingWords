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
}
