//
//  UIViewController.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 21/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension UIViewController {
    var safeArea: UILayoutGuide {
        return view.layoutMarginsGuide
    }

    func setNavigationControllerAttributes(barTintColor: UIColor, titleTextColor: UIColor) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: titleTextColor]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleTextColor]
            navBarAppearance.backgroundColor = barTintColor
            navBarAppearance.shadowColor = .clear
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
}
