//
//  HomeViewController.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 23/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    private var tabBarEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let browseViewController: UINavigationController = {
            let viewController = UINavigationController(rootViewController: BrowseProductsViewController())
            viewController.tabBarItem = TabBar.Browse.Item
            viewController.tabBarItem.imageInsets = tabBarEdgeInsets
            return viewController
        }()

        let myAccountViewController: UINavigationController = {
            let viewController = UINavigationController(rootViewController: MyAccountViewController())
            viewController.tabBarItem = TabBar.MyAccount.Item
            viewController.tabBarItem.imageInsets = tabBarEdgeInsets
            return viewController
        }()

        let dealsViewController: UINavigationController = {
            let viewController = UINavigationController(rootViewController: DealsViewController())
            viewController.tabBarItem = TabBar.Deals.Item
            viewController.tabBarItem.imageInsets = tabBarEdgeInsets
            return viewController
        }()

        let rewardsViewController: UINavigationController = {
            let viewController = UINavigationController(rootViewController: RewardsViewController())
            viewController.tabBarItem = TabBar.Rewards.Item
            viewController.tabBarItem.imageInsets = tabBarEdgeInsets
            return viewController
        }()
        
        let myDeliveryViewController: UINavigationController = {
            let viewController = UINavigationController(rootViewController: MyDeliveryViewController())
            viewController.tabBarItem = TabBar.MyDelivery.Item
            viewController.tabBarItem.imageInsets = tabBarEdgeInsets
            return viewController
        }()

        viewControllers = [
            browseViewController,
            myAccountViewController,
            dealsViewController,
            rewardsViewController,
            myDeliveryViewController
        ]

        tabBar.tintColor = Colors.bluePepsi.literal
        tabBarController?.selectedIndex = 1
        tabBarController?.selectedViewController = browseViewController
    }

}
