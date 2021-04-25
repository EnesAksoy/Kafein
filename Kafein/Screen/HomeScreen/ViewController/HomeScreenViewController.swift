//
//  HomeScreenViewController.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController {
    
    // MARK: - Enum
    
    private enum TableViewType {
        case search
        case searched
    }
    
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
    @IBOutlet weak var weatherView: KafeinView!
    
    // MARK: - Proporties
    
    private let locationManager = CLLocationManager()
    private var viewModel: HomeScreenViewModel!
    private var searchArray: [GeneralInfoModel]?
    private var searchedArray: [String]?
    private var tableViewType: TableViewType?
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.viewModel = HomeScreenViewModel()
        self.checkLocationPermit()
        self.searchTextField.delegate = self
        self.tableViewConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Functions
    
    private func checkLocationPermit() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    self.weatherView.isHidden = true
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    self.viewModel.getCurrentLocationsData { [weak self] error in
                        guard self != nil else { return }
                        LoadingView.removeLoadingView()
                        if !error.isEmpty {
                            self?.createAlert(message: error, title: self?.localizableGetString(forkey: self?.errorTitleLocalizationKey ?? "") ?? "") {
                                self?.weatherView.isHidden = true
                            }
                        }else {
                            self?.updateView()
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
        self.weatherView.isHidden = false
        self.weatherTextLabel.text = ObjectStore.shared.currentWeatherData?[0].weatherText
        self.isDayTimeResultLabel.text = ObjectStore.shared.currentWeatherData?[0].isDayTime == true ? self.localizableGetString(forkey: self.dayLocalizationKey) : self.localizableGetString(forkey: self.nightLocalizationKey)
        self.hasPrecipitationResultImageView.image = ObjectStore.shared.currentWeatherData?[0].hasPrecipitation == true ? UIImage(named: "true") : UIImage(named: "false")
        self.temperatureLabel.text = "\(ObjectStore.shared.currentWeatherData?[0].temperature.metric.value ?? 0)°C"
        self.cityNameLabel.text = ObjectStore.shared.currentLocationData?.administrativeArea.localizedName
    }
    
    // MARK: - Last 5 keywords save funtion
    
    private func saveLastSearchedKey(keyWord: String) {
        if var searchedArray = UserDefaults.standard.object(forKey: "home_screen_searchedkey_word") as? [String], searchedArray.count > 0 {
                searchedArray.append(keyWord)
                searchedArray.reverse()
                if searchedArray.count > 5 {
                   searchedArray = searchedArray.dropLast()
                }
                self.searchedArray = searchedArray
                searchedArray.reverse()
                UserDefaults.standard.setValue(searchedArray, forKey: "home_screen_searchedkey_word")
                UserDefaults.standard.synchronize()
        }else {
            var searchedArray = [String]()
            searchedArray.append(keyWord)
            UserDefaults.standard.setValue(searchedArray, forKey: "home_screen_searchedkey_word")
            UserDefaults.standard.synchronize()
        }
    }
    
    private func getSearchedKeyWord() {
        if var searchedArray = UserDefaults.standard.object(forKey: "home_screen_searchedkey_word") as? [String], searchedArray.count > 0  {
            searchedArray.reverse()
            self.searchedArray = searchedArray
            self.searchTableView.isHidden = false
            self.tableViewType = .searched
            self.searchTableView.reloadData()
        }
    }
    
    // MARK: - Table View Configuration
    
    private func tableViewConfiguration() {
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.register(UINib(nibName: self.listTableViewCellId, bundle: nil),
                                forCellReuseIdentifier: self.listTableViewCellId)
        self.searchTableView.isHidden = true
    }
}

    // MARK: - CLLocationManagerDelegate Methods

extension HomeScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.viewModel.getCurrentLocationsData { [weak self] error in
                guard self != nil else { return }
                LoadingView.removeLoadingView()
                if !error.isEmpty {
                    self?.createAlert(message: error, title: self?.localizableGetString(forkey: self?.errorTitleLocalizationKey ?? "") ?? "") {
                        self?.weatherView.isHidden = true
                    }
                }else {
                    self?.updateView()
                }
            }
        }else {
            self.weatherView.isHidden = true
        }
    }
}

// MARK: - UITextFieldDelegate Methods

extension HomeScreenViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.getSearchedKeyWord()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text! as NSString
        var replacedString: String?
        let newString: NSString = currentString.replacingCharacters(in: range, with: replacedString ?? "\(string)") as NSString
        
        if newString.length >= 2 {
            replacedString = string.replacingOccurrences(of: " ", with: "+")
            self.viewModel.getSearchApi(searchText: newString as String) { [weak self] response, error in
                guard self != nil else { return }
                if !error.isEmpty {
                    self?.createAlert(message: error, title: self?.localizableGetString(forkey: self?.errorTitleLocalizationKey ?? "") ?? "") {
                        print("clicked")
                    }
                }else {
                    if let response = response, response.count > 0 {
                        self?.searchArray = response
                        self?.searchTableView.isHidden = false
                        self?.tableViewType = .search
                        self?.searchTableView.reloadData()
                    }else {
                        self?.searchTableView.isHidden = true
                    }
                }
            }
        } else if newString.length == 0 {
            self.getSearchedKeyWord()
        }
        return true
    }
}

    // MARK: - UITableViewDelegate, UITableViewDataSource Methods

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.tableViewType {
        case .search:
            return self.searchArray?.count ?? 0
        case .searched:
            return self.searchedArray?.count ?? 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        switch self.tableViewType {
        case .search:
            cell.configureCell(cityName: self.searchArray?[indexPath.row].administrativeArea.localizedName ?? "")
        case .searched:
            cell.configureCell(cityName: self.searchedArray?[indexPath.row] ?? "")
        case .none:
            print("none")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.tableViewType {
        case .search:
            self.saveLastSearchedKey(keyWord: self.searchArray?[indexPath.row].administrativeArea.localizedName ?? "")
            ObjectStore.shared.selectedCityData = self.searchArray?[indexPath.row]
            let viewController = DetailScreenViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case.searched:
            self.searchTextField.text = self.searchedArray?[indexPath.row]
        default:
            print("default")
        }
    }
}
