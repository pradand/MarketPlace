//
//  BrowseProductsRouter.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

@objc protocol BrowseProductsRoutingLogic {
    func routeToSomewhere()
}

protocol BrowseProductsDataPassing {
    var dataStore: BrowseProductsDataStore? { get }
}

class BrowseProductsRouter: NSObject, BrowseProductsRoutingLogic, BrowseProductsDataPassing {
    
    // MARK: Architecture Objects
    
    weak var viewController: BrowseProductsViewController?
    var dataStore: BrowseProductsDataStore?
    
    // MARK: Routing
    
    func routeToSomewhere() {
        //let nextController = NextViewController()
        //var destinationDS = nextController.router?.dataStore
        //passDataToSomewhere(source: dataStore, destination: &destinationDS)
        //viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: BrowseProductsDataStore, destination: inout SomewhereDataStore) {
        //destination.name = source.name
    //}
}
