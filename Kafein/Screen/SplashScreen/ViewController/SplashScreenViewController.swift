//
//  SplashScreenViewController.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit

class SplashScreenViewController: UIViewController {

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Reachability.isConnectedToNetwork() {
            // create alert
        }
        navigationController?.setNavigationBarHidden(true, animated: true)
    }


}
