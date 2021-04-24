//
//  GeneralInfoModel.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation


struct GeneralInfoModel: Codable {
    let key: String
    let administrativeArea: AdministrativeAreaModel
    
    private enum CodingKeys: String, CodingKey {
        case key = "Key", administrativeArea = "AdministrativeArea"
    }
}
