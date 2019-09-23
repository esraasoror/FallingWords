//
//  Utils.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import Foundation
import Toast
import AudioPlayer

class Utils {
	/**
	Show toast message
	- Parameters:
		- message : the message that will be displayed in the toast
	*/	
	static func showToast(message: String) {
		guard let topController =  UIApplication.shared.keyWindow?.rootViewController?.topMostViewController() else {
			return
		}
		topController.view.makeToast(message, duration: 3, position: CSToastPositionBottom)
	}
    
    /**
     play mp3 sound
     - it is based on pod called **AudioPlayerSwift**
     - Parameters:
     - soundName : the mp3 file in resources
     - completion : form type DefaultCompletionHandler
     */
    static func playMp3Sound(_ soundName: String, completion: @escaping DefaultCompletionHandler) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        do {
            let audioPlayer = try AudioPlayer(contentsOf: url)
            audioPlayer.play()
            // Stop playing with a fade out
            audioPlayer.fadeOut()
            completion()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
