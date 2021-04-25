//
//  DetailScreenViewModelDelegate.swift
//  Kafein
//
//  Created by ENES AKSOY on 25.04.2021.
//

import Foundation

protocol DetailScreenViewModelDelegate {
    func updateView(response: [WeatherModel]?, error: String)
}
