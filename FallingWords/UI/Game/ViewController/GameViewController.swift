//
//  GameViewController.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewModelDelegate {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    var viewModel: GameViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.startGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAnswer(_ answer: String) {
        DispatchQueue.main.async {
            let label = UILabel(frame: CGRect(x: Int(arc4random_uniform(100)), y: 90, width: 300, height: 40))
            
            label.textAlignment = .center
            label.textColor = UIColor.blue
            label.font = UIFont(name: "Futura Meduim", size: 20)
            label.text = answer
            label.tag = 2
            label.isUserInteractionEnabled = true

            self.view.addSubview(label)
            UIView.animate(withDuration: 10.0, delay: 0, options: .allowUserInteraction, animations: {
                label.frame = CGRect(x: label.frame.origin.x, y: self.view.frame.height - 277, width: label.frame.width, height: label.frame.height)
            }, completion: { (_) in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    label.isHidden = true
                    label.removeFromSuperview()
                })
            })
        }
    }
    
    func displayEnglish(_ english: String) {
        DispatchQueue.main.async {
            self.englishLabel.text = english
        }
    }
    func updateScore(_ score: Int) {
        DispatchQueue.main.async {
            self.scoreLabel.text = "Score: \(score)"
        }
    }
}
extension GameViewController
{
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self.view)

        for subs in self.view.subviews{
            print(subs)
            guard let ourLabel = subs as? UILabel, ourLabel.tag > 0, let presentation = ourLabel.layer.presentation(), let gameViewModel = self.viewModel else{
                continue
            }
            if presentation.hitTest(touchLocation) != nil{
                print("Touching")
                if gameViewModel.isValidAnswer(ourLabel.text ?? ""){
                    Utils.playMp3Sound("matching") {
                        print("matching select")
                    }
                } else {
                    Utils.playMp3Sound("error") {
                        print("mismatching select")
                    }
                }
            }
        }
        
    }
}
