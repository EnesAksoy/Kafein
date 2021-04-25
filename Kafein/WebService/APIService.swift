//
//  APIService.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit
import Alamofire

class APIService: NSObject {

    // MARK: - Constants
    
    private let baseUrl = URL(string: "http://dataservice.accuweather.com/")!
    private let apikey = "hADv4K25RQCEfXX1hbR0mG7fZEcCkX0T"
    
    // MARK: - Functions
    
    func connectApi(endPoint: String, parameters: [String:String]?, completion: @escaping(_ response: Data?, _ error: String) -> ()) {
        let connectUrl = "\(baseUrl)\(endPoint)?apikey=\(apikey)"
        
        Alamofire.request(connectUrl, method: .get, parameters: parameters).response { (response) in
            guard let data = response.data else {
                completion(nil, response.error?.localizedDescription ?? "nil data")
                return
            }
            completion(data, "")
        }
    }
    
}
