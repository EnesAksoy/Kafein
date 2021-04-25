//
//  DetailScreenViewModel.swift
//  Kafein
//
//  Created by ENES AKSOY on 25.04.2021.
//

import UIKit

class DetailScreenViewModel: NSObject {
    
    // MARK: - Properties
    
    private var apiService: APIService!
    var delegate: DetailScreenViewModelDelegate?
    
    // MARK: - Life Cycles
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.getWeatherDetailData()
    }
    
    // MARK: - Functions
    
    private func getWeatherDetailData() {
        apiService.connectApi(endPoint: "currentconditions/v1/\(ObjectStore.shared.selectedCityData?.key ?? "")", parameters: nil) { [weak self] response, error in
            guard self != nil else { return }
            if let response = response, error.isEmpty {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode([WeatherModel].self, from: response)
                    self?.delegate?.updateView(response: response, error: "")
                } catch let error {
                    self?.delegate?.updateView(response: nil, error: error.localizedDescription)
                }
            }else {
                self?.delegate?.updateView(response: nil, error: error)
            }
        }
    }
}
