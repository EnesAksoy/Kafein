//
//  DetailScreenViewController.swift
//  Kafein
//
//  Created by ENES AKSOY on 25.04.2021.
//

import UIKit

class DetailScreenViewController: UIViewController {

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = ObjectStore.shared.selectedCityData?.administrativeArea.localizedName
    }
    
    
}
