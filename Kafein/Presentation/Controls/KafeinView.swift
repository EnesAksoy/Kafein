//
//  KafeinView.swift
//  Kafein
//
//  Created by ENES AKSOY on 24.04.2021.
//

import Foundation
import UIKit

class KafeinView: UIView {
    
    enum cornerType: Int {
        case full
        case onlyTop
        case onlyBottom
    }
    
    var selectCorner: cornerType = .full
    
    @IBInspectable var chooseCorner: Int = 0 {
        didSet {
            selectCorner = cornerType(rawValue: chooseCorner) ?? .full
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            switch selectCorner {
            case .full:
                self.layer.cornerRadius = cornerRadius
            case .onlyTop:
                self.layer.cornerRadius = cornerRadius
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            case .onlyBottom:
                self.layer.cornerRadius = cornerRadius
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        }
    }
}
