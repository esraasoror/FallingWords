//
//  NetworkManager.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class NetworkManager {

    /**
     Request from the Api with get method.
     - Parameters:
        - url: The path to the Api request that will be concatenated with the base url.
        - parameters: The query parameters if exists.
        - headers: The headers of request if exists.
        - onSuccess: Has the Projects json array.
        - onError: tells an error happen.
     */
    func getRequestFrom(url: String,
                        parameters: Parameters = [:],
                        onSuccess: @escaping (JSON) -> Void,
                        onError: @escaping DefaultCompletionHandler) {
        if NetworkReachabilityManager()!.isReachable {
            Alamofire.request(Constants.BackendRequests.baseURL + url,
                              method: .get,
                              parameters: parameters,
                              headers: nil)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            onSuccess(JSON(data))
                        } else {
                            onError()
                        }
                    case .failure:
                        onError()
                        Utils.showToast(message: Constants.ErrorMessages.serverErrorMessage)
                    }
            }
        } else {
            onError()
            DispatchQueue.main.async {
                Utils.showToast(message: Constants.ErrorMessages.noInternetErrorMessage)
            }
        }
    }
}
