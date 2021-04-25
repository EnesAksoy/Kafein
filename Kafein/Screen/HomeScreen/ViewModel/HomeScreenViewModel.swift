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
    
    // MARK: - Functions
    
    func getCurrentLocationsData(completion: @escaping(_ error: String) -> Void) {
        apiService.connectApi(endPoint: "locations/v1/cities/ipaddress", parameters: ["q":"\(UIDevice.current.ipAddress() ?? "")"]) { [weak self] response, error in
            guard self != nil else { return }
            if let response = response, error.isEmpty {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(GeneralInfoModel.self, from: response)
                    print("\(response.key)")
                    ObjectStore.shared.currentLocationData = response
                    self?.getCurrentConditionsData(localizationKey: response.key, completion: { (error) in
                        if error.isEmpty {
                            completion("")
                        }else {
                            completion(error)
                        }
                    })
                } catch let error {
                    completion(error.localizedDescription)
                }
            }else {
                completion(error)
            }
        }
    }
    
    func getCurrentConditionsData(localizationKey: String, completion: @escaping(_ error: String) -> Void) {
        apiService.connectApi(endPoint: "currentconditions/v1/\(localizationKey)", parameters: nil) { [weak self] response, error in
            guard self != nil else { return }
            if let response = response, error.isEmpty {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([WeatherModel].self, from: response)
                    ObjectStore.shared.currentWeatherData = response
                    completion("")
                } catch let error {
                    completion(error.localizedDescription)
                }
            }else {
                completion(error)
            }
        }
    }
    
    func getSearchApi(searchText: String, completion: @escaping(_ response: [GeneralInfoModel]?, _ error: String) -> Void) {
        apiService.connectApi(endPoint: "locations/v1/cities/autocomplete", parameters: ["q":"\(searchText)"]) { [weak self] response, error in
            guard self != nil else { return }
            if let response = response, error.isEmpty {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([GeneralInfoModel].self, from: response)
                    completion(response, "")
                } catch let error {
                    completion(nil, error.localizedDescription)
                }
            }else {
                completion(nil, error)
            }
        }
    }
}
