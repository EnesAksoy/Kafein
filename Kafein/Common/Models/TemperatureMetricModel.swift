//
//  TemperatureMetricModel.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation

struct TemperatureMetricModel: Codable {
    
    let value: Double?
    
    private enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
