//
//  HomeScreenViewController.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController {
    
    // MARK: - Constant
    
    private let errorTitleLocalizationKey = "messageErrorTitle"
    private let dayLocalizationKey = "homeScreen.day"
    private let nightLocalizationKey = "homeScreen.night"
    private let listTableViewCellId = "SearchTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var weatherTextLabel: UILabel!
    @IBOutlet weak var isDayTimeResultLabel: UILabel!
    @IBOutlet weak var hasPrecipitationResultImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var searchTextField: KafeinTextfield!
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Proporties
    
    private let locationManager = CLLocationManager()
    private var viewModel: HomeScreenViewModel!
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.viewModel = HomeScreenViewModel()
        self.checkLocationPermit()
        self.searchTextField.delegate = self
    }
    
    // MARK: - Functions
    
    private func checkLocationPermit() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    self.viewModel.getCurrentLocationsData { (error) in
                        if !error.isEmpty {
                            self.createAlert(message: error, title: self.localizableGetString(forkey: self.errorTitleLocalizationKey)) {
                                print("clicked")
                            }
                        }else {
                            self.updateView()
                        }
                    }
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
        }
    }
    
    private func updateView() {
        self.weatherTextLabel.text = ObjectStore.shared.currentWeatherData?[0].weatherText
        self.isDayTimeResultLabel.text = ObjectStore.shared.currentWeatherData?[0].isDayTime == true ? self.localizableGetString(forkey: self.dayLocalizationKey) : self.localizableGetString(forkey: self.nightLocalizationKey)
        self.hasPrecipitationResultImageView.image = ObjectStore.shared.currentWeatherData?[0].hasPrecipitation == true ? UIImage(named: "true") : UIImage(named: "false")
        self.temperatureLabel.text = "\(ObjectStore.shared.currentWeatherData?[0].temperature.metric.value ?? 0)°C"
        self.cityNameLabel.text = ObjectStore.shared.currentLocationData?.administrativeArea.localizedName
    }
    
    // MARK: - Table View Configuration
    
    private func tableViewConfiguration() {
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.register(UINib(nibName: self.listTableViewCellId, bundle: nil),
                                forCellReuseIdentifier: self.listTableViewCellId)
    }
}

    // MARK: - CLLocationManagerDelegate Methods

extension HomeScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.viewModel.getCurrentLocationsData { (error) in
                if !error.isEmpty {
                    self.createAlert(message: error, title: self.localizableGetString(forkey: self.errorTitleLocalizationKey)) {
                        print("clicked")
                    }
                }else {
                    self.updateView()
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate Methods

extension HomeScreenViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text! as NSString
        var replacedString: String?
        let newString: NSString = currentString.replacingCharacters(in: range, with: replacedString ?? "\(string)") as NSString
        
        if newString.length >= 2 {
            replacedString = string.replacingOccurrences(of: " ", with: "+")
            // call api
            self.searchTableView.isHidden = false
        } else if newString.length == 0 {
            self.searchTableView.isHidden = true
        }
        return true
    }
}


