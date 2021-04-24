//
//  UIViewControllerExtensions.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import UIKit

public extension UIViewController {
    
    func createAlert(message: String, title: String, completion: @escaping() -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "asdad", style: .default) { (_) in
            completion()
        }
        alertController.addAction(OkAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func localizableGetString(forkey: String) -> String {
        let string = NSLocalizedString(forkey, comment: "")
        return string
    }
}
