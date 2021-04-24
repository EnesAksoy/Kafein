//
//  WeatherModel.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation

struct WeatherModel: Codable {
    
    let weatherText: String
    let hasPrecipitation: Bool
    let isDayTime: Bool
    let temperature: TemperatureModel
    
    private enum CodingKeys: String, CodingKey {
        case weatherText = "WeatherText", hasPrecipitation = "HasPrecipitation", isDayTime = "IsDayTime", temperature = "Temperature"
    }
}
