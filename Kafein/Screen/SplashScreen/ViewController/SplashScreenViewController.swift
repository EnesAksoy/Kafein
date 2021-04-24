//
//  SplashScreenViewController.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    // MARK: - Constant
    
    private let connectionMessageLocalizationKey = "splashScreen.connectionMessage"
    private let errorTitleLocalizationKey = "messageErrorTitle"

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        if !Reachability.isConnectedToNetwork() {
            self.createAlert(message: self.localizableGetString(forkey: connectionMessageLocalizationKey), title: self.localizableGetString(forkey: errorTitleLocalizationKey), completion: {
                print("clicked")
            })
            return
        }
        self.pushViewControllerMethod()
    }
    
    // MARK: - Functions
    
    private func pushViewControllerMethod() {
        let viewController = HomeScreenViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
