//
//  HomeScreenViewController.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController {
    
    // MARK: - Proporties
    
    let locationManager = CLLocationManager()
    private var viewModel: HomeScreenViewModel!
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.viewModel = HomeScreenViewModel()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    self.viewModel.getCurrentLocationsData()
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
        }
        
        
    }
}

    // MARK: - CLLocationManagerDelegate Methods

extension HomeScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.viewModel.getCurrentLocationsData()
        }
    }
}
