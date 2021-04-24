//
//  HomeScreenViewModel.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit

class HomeScreenViewModel: NSObject {

    // MARK: - Properties
    
    private var apiService: APIService!
    
    
    // MARK: - Life Cycles
    
    override init() {
        super.init()
        self.apiService = APIService()
    }
    
    func getCurrentLocationsData() {
        apiService.connectApi(endPoint: "locations/v1/cities/ipaddress", parameters: ["q":"\(UIDevice.current.ipAddress() ?? "")"]) { [weak self] response, error in
            guard self != nil else { return }
            print(response)
        }
    }
}
