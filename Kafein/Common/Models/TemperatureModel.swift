//
//  TemperatureModel.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation

struct TemperatureModel: Codable {
    let metric: TemperatureMetricModel
    
    private enum CodingKeys: String, CodingKey {
        case metric = "Metric"
    }
}
