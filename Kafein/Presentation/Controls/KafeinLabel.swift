//
//  KafeinLabel.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation
import UIKit

class KafeinLabel: UILabel {
    @IBInspectable var localizableKey: String? = nil {
        didSet {
            if localizableKey != nil {
                self.text = NSLocalizedString(localizableKey!, comment: "")
            }
        }
    }
}
