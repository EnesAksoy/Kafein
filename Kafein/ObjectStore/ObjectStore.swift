//
//  ObjectStore.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation

class ObjectStore {
    
    static let shared = ObjectStore()
    
    var currentLocationData: GeneralInfoModel?
    var currentWeatherData: [WeatherModel]?
}
