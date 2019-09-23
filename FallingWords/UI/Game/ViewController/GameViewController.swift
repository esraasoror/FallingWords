//
//  GameViewController.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var congratsView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    
    var viewModel: GameViewModel? = nil
    var countdownTimer: Timer!
    var totalTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.startGame()
        startTimer()
        setupCongratsViewStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupCongratsViewStyle() {
        congratsView.layer.cornerRadius = 10
        congratsView.layer.borderWidth = 1
        congratsView.layer.borderColor = UIColor.black.cgColor
        congratsView.isHidden = true
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - timer handling methods
    func startTimer() {
        totalTime = viewModel?.getTimer() ?? 60
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        viewModel?.endGame()
        self.finalScoreLabel.text = "Your score is \(viewModel?.getScore() ?? 0)"
        hideAnswers()
        Utils.playMp3Sound(Constants.Sounds.finish) {
            print("game finished")
        }
        animateCongratsView()
    }
    
    func hideAnswers() {
        self.englishLabel.isHidden = true
        for view in self.view.subviews {
            if view.tag == 2 {
                view.isHidden = true
            }
        }
    }
    
    func animateCongratsView(){
            self.congratsView.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.congratsView.isHidden = false
                UIView.animate(withDuration: 1.0, animations: {
                    self.congratsView.transform = CGAffineTransform(scaleX: 2, y: 2)
                }, completion: { done in
                    UIView.animate(withDuration: 0.5) {
                        self.congratsView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                })
    }
    
}
// MARK: - GameViewModelDelegate methods
extension GameViewController: GameViewModelDelegate{
    func displayAnswer(_ answer: String) {
        DispatchQueue.main.async {
            if self.totalTime != 0 {
                let label = UILabel(frame: CGRect(x: Int(arc4random_uniform(100)), y: 90, width: 300, height: 40))
                
                label.textAlignment = .center
                label.textColor = UIColor.blue
                label.font = UIFont(name: "Futura Meduim", size: 20)
                label.text = answer
                label.tag = 2
                label.isUserInteractionEnabled = true
                
                self.view.addSubview(label)
                UIView.animate(withDuration: TimeInterval(self.viewModel?.getAnimationDuration() ?? 10), delay: 0, options: .allowUserInteraction, animations: {
                    label.frame = CGRect(x: label.frame.origin.x, y: self.view.frame.height - 200, width: label.frame.width, height: label.frame.height)
                }, completion: { (_) in
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        label.isHidden = true
                        label.removeFromSuperview()
                    })
                })
            }
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

// MARK: - touch handling method
extension GameViewController {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self.view)

        for subs in self.view.subviews{
            guard let ourLabel = subs as? UILabel, ourLabel.tag > 0, let presentation = ourLabel.layer.presentation(), let gameViewModel = self.viewModel else{
                continue
            }
            if presentation.hitTest(touchLocation) != nil{
                if gameViewModel.isValidAnswer(ourLabel.text ?? ""){
                    Utils.playMp3Sound(Constants.Sounds.success) {
                        print("matching select")
                    }
                } else {
                    Utils.playMp3Sound(Constants.Sounds.error) {
                        print("mismatching select")
                    }
                }
            }
        }
        
    }
}
