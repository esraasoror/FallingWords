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
}
