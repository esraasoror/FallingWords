//
//  Constants.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import Foundation

typealias DefaultCompletionHandler = () -> Void

class Constants {
	
    // MARK: - API CONSTANTS
	class BackendRequests {
        static let baseURL = "https://gist.githubusercontent.com/"
		static let allWordsGetURL = "DroidCoder/7ac6cdb4bf5e032f4c737aaafe659b33/raw/baa9fe0d586082d85db71f346e2b039c580c5804/words.json"
	}

	// MARK: - ErrorMessage CONSTANTS
    class ErrorMessages {
        static let serverErrorMessage = "Server Error"
        static let noInternetErrorMessage = "No Internet Connection"
    }
    // MARK: - Sounds CONSTANTS
    class Sounds {
        static let finish = "TaDa"
        static let success = "matching"
        static let error = "error"
    }
}
