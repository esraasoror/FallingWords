//
//  GameViewController.swift
//  FallingWords
//
//  Created by Yehia on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
