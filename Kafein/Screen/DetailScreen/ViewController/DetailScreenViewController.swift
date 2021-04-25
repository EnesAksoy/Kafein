//
//  DetailScreenViewController.swift
//  Kafein
//
//  Created by ENES AKSOY on 25.04.2021.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    // MARK: - Constant
    
    private let errorTitleLocalizationKey = "messageErrorTitle"
    private let dayLocalizationKey = "homeScreen.day"
    private let nightLocalizationKey = "homeScreen.night"
    
    // MARK: - Outlets
    
    @IBOutlet weak var weatherTextLabel: UILabel!
    @IBOutlet weak var isDayTimeResultLabel: UILabel!
    @IBOutlet weak var hasPrecipitationResultImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // MARK: - Proporties
    
    private var viewModel: DetailScreenViewModel!
    private var weatherData: [WeatherModel]?

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = ObjectStore.shared.selectedCityData?.administrativeArea.localizedName
        self.viewModel = DetailScreenViewModel()
        self.viewModel.delegate = self
    }
    
    // MARK: - Functions
    
    private func updateView() {
        self.weatherTextLabel.text = self.weatherData?[0].weatherText
        self.isDayTimeResultLabel.text = self.weatherData?[0].isDayTime == true ? self.localizableGetString(forkey: self.dayLocalizationKey) : self.localizableGetString(forkey: self.nightLocalizationKey)
        self.hasPrecipitationResultImageView.image = self.weatherData?[0].hasPrecipitation == true ? UIImage(named: "true") : UIImage(named: "false")
        self.temperatureLabel.text = "\(self.weatherData?[0].temperature.metric.value ?? 0)°C"
    }
}

    // MARK: - DetailScreenViewModel Methods

extension DetailScreenViewController: DetailScreenViewModelDelegate {
    func updateView(response: [WeatherModel]?, error: String) {
        if !error.isEmpty {
            self.createAlert(message: error, title: self.localizableGetString(forkey: self.errorTitleLocalizationKey)) {
                self.navigationController?.popViewController(animated: true)
            }
        }else {
            self.weatherData = response
            self.updateView()
        }
    }
}
