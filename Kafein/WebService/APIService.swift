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
    private let apikey = "wG6l5ZL1imiJJLmwhNUkJoQjVcge2LAu"
    
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
