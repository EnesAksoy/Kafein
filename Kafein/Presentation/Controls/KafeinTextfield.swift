//
//  KafeinTextfield.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation
import UIKit

class KafeinTextfield: UITextField {
    @IBInspectable var localizableKey: String? = nil {
        didSet {
            if localizableKey != nil {
                self.placeholder = NSLocalizedString(localizableKey!, comment: "")
            }
        }
    }
}
