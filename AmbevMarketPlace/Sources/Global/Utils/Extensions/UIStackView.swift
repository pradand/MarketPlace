//
//  UIStackView.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 21/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        views.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
}
