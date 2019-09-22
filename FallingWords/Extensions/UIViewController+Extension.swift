//
//  UIViewController+Extension.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

	/**
	Show Alert view
	
	- Note: 
		The alert can contain ok action with its completion and cancel action with its completion also ,
		but since the cancel action is optional and also its completion is optional , 
		so the default for the alert is just the OK action , and if you need to do action on OK click you can use
        onConfirm completion
	
	- Parameters:
		- title : the title of the alert view 
		- message : the content of the message of the alert view 
		- confirmTitle : title of confirm action
		- confirmStyle : style of the alert action 
		- cancelTitle : title of cancel action
		- onConfirm : the completion that will be excuted when user press confirm
		- onCancel : the completion that will be excuted when user press cancel
	- Returns:
		 UIAlertController with actions
	*/
    @discardableResult func showAlert(_ title: String,
                                      message: String,
                                      confirmTitle: String? = "Ok",
                                      confirmStyle: UIAlertAction.Style? = .default,
                                      cancelTitle: String? = nil,
                                      onConfirm: DefaultCompletionHandler? = nil,
                                      onCancel: DefaultCompletionHandler? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let title = cancelTitle {
            alert.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
                onCancel?()
            }))
        }
        alert.addAction(UIAlertAction(title: confirmTitle, style: confirmStyle ?? .default, handler: { (_) in
            onConfirm?()
        }))
        present(alert, animated: true, completion: nil)
        return alert
    }

	/**
	Returns the top most view controller 
	
	- Returns:
		 the top view controller which is visible now on the screen 
	*/
	func topMostViewController() -> UIViewController? {
		if self.presentedViewController == nil {
			return self
		}
		if let alert =  self.presentedViewController as? UIAlertController {
			return self
		}
		if let navigation = self.presentedViewController as? UINavigationController,
            let visibleViewController = navigation.visibleViewController {
			return visibleViewController.topMostViewController()
		}
		if let tab = self.presentedViewController as? UITabBarController {
			if let selectedTab = tab.selectedViewController {
				return selectedTab.topMostViewController()
			}
			return tab.topMostViewController()
		}
		return self.presentedViewController?.topMostViewController()
	}
}
