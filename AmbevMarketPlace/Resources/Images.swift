//
//  Images.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 21/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

enum Images {
    case account
    case beer
    case browse
    case deals
    case delivery
    case more
    case remove
    case rewards
    case thick
    case sortAsc
    case sortDesc

    var literal: UIImage {
        switch self {
        case .account:
            return UIImage(named: "Account") ?? UIImage()
        case .beer:
            return UIImage(named: "Beer") ?? UIImage()
        case .browse:
            return UIImage(named: "Browse") ?? UIImage()
        case .deals:
            return UIImage(named: "Deals") ?? UIImage()
        case .delivery:
            return UIImage(named: "Delivery") ?? UIImage()
        case .more:
            return UIImage(named: "More") ?? UIImage()
        case .remove:
            return UIImage(named: "Remove") ?? UIImage()
        case .rewards:
            return UIImage(named: "Rewards") ?? UIImage()
        case .thick:
            return UIImage(named: "Thick") ?? UIImage()
        case .sortAsc:
            return UIImage(named: "SortAsc") ?? UIImage()
        case .sortDesc:
            return UIImage(named: "SortDesc") ?? UIImage()
        }
    }

}
