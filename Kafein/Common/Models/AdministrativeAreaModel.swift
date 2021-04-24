//
//  AdministrativeAreaModel.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation


struct AdministrativeAreaModel: Codable {
    
    let localizedName: String
    
    private enum CodingKeys: String, CodingKey {
        case localizedName = "LocalizedName"
    }
}
