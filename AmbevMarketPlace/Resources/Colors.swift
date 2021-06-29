//
//  Colors.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 21/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

enum Colors {
    case redAmbev
    case yellowBeer
    case bluePepsi
    case green7Up

    var literal: UIColor {
        switch self {
        case .redAmbev:
            return UIColor(named: "Red Ambev") ?? UIColor.red
        case .yellowBeer:
            return UIColor(named: "Yellow Beer") ?? UIColor.yellow
        case .bluePepsi:
            return UIColor(named: "Blue Pepsi") ?? UIColor.blue
        case .green7Up:
            return UIColor(named: "Green 7Up") ?? UIColor.green
        }
    }
}
