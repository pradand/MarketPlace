//
//  UIView.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 21/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension UIView {
    var safeArea: UILayoutGuide {
        return layoutMarginsGuide
    }

    func addSubviews(views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
