//
//  TabBarModels.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 23/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

enum TabBar {

    case Browse
    case MyAccount
    case Deals
    case Rewards
    case MyDelivery

    var Item: UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: image)
    }

    private var title: String {
        switch self {
        case .Browse:
            return HomeStrings.browse
        case .MyAccount:
            return HomeStrings.myAccount
        case .Deals:
            return HomeStrings.deals
        case .Rewards:
            return HomeStrings.rewards
        case .MyDelivery:
            return HomeStrings.myDelivery
        }
    }

    private var image: UIImage {
        switch self {
        case .Browse:
            return Images.browse.literal
        case .MyAccount:
            return Images.account.literal
        case .Deals:
            return Images.deals.literal
        case .Rewards:
            return Images.rewards.literal
        case .MyDelivery:
            return Images.delivery.literal
        }
    }

}
