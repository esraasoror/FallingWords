//
//  ViewController.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Oultelt refrences
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    
    // MARK: - private variables
    private var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.downloadWords()
        setupButtonsStyle()
    }
    /**
     set rounded border for level buttons
     */
    func setupButtonsStyle() {
        level1Button.layer.cornerRadius = level1Button.frame.height / 2
        level1Button.layer.borderWidth = 1
        level1Button.layer.borderColor = UIColor.black.cgColor
        
        level2Button.layer.cornerRadius = level2Button.frame.height / 2
        level2Button.layer.borderWidth = 1
        level2Button.layer.borderColor = UIColor.black.cgColor
        
        level3Button.layer.cornerRadius = level3Button.frame.height / 2
        level3Button.layer.borderWidth = 1
        level3Button.layer.borderColor = UIColor.black.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? GameViewController else {
            return
        }
        viewController.viewModel = homeViewModel.getGameViewModel(forIndentifier: segue.identifier ?? "")
    }
}

