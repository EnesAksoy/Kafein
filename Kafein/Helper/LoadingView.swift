//
//  LoadingView.swift
//  Kafein
//
//  Created by ENES AKSOY on 25.04.2021.
//

import UIKit

class LoadingView {
    
    static func showLoadingView() {
        removeLoadingView()
        let mainView = UIView(frame: UIScreen.main.bounds)
        mainView.backgroundColor = .clear
        let darkView = UIView(frame: mainView.frame)
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0.6
        mainView.addSubview(darkView)
        let spinnerView = UIActivityIndicatorView(style: .whiteLarge)
        spinnerView.color = .white
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(spinnerView)
        spinnerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        spinnerView.startAnimating()
        mainView.tag = 1991
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                sceneDelegate.window?.addSubview(mainView)
            }else {
                (UIApplication.shared.delegate as? AppDelegate)?.window?.addSubview(mainView)
            }
        }
    }
    
    static func removeLoadingView() {
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
                sceneDelegate.window?.viewWithTag(1991)?.removeFromSuperview()
            }else {
                (UIApplication.shared.delegate as? AppDelegate)?.window?.viewWithTag(1991)?.removeFromSuperview()
            }
        }
    }
}
