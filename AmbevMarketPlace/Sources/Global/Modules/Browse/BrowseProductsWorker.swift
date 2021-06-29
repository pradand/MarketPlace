//
//  BrowseProductsWorker.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

class BrowseProductsWorker {
    
    private let serviceProvider: ServiceProvider
    var provider: RequestProvider?

    init(serviceProvider: ServiceProvider = ServiceProvider.shared) {
        self.serviceProvider = serviceProvider
    }

    func fetchData(completion: @escaping (browseProductsCompletion)) {
        let serviceProvider: ServiceProvider = ServiceProvider.shared

        serviceProvider.fetch(of: BrowseProducts.Model.Response.self, for: Constants.EndPoint.productsJson.literal) { (response) in
            completion(response)
        }
    }

    func fetchDataFromEntity(completion: @escaping (Result<[OrderedProducts], CustomError>) -> ()) {
        let serviceProvider: CoreDataController = CoreDataController.share

        serviceProvider.fetch { (response) in
            completion(response)
        }
    }
    
    func saveToEntity(_ requestData: BrowseProducts.Model.Request, completion: @escaping (Result<Bool, NSError>) -> ()) {
        let serviceProvider: CoreDataController = CoreDataController.share

        serviceProvider.save(request: requestData) { (response) in
            completion(response)
        }
    }
    
    func updateEntity(_ requestData: BrowseProducts.Model.Request, completion: @escaping (Result<Bool, NSError>) -> ()) {
        let serviceProvider: CoreDataController = CoreDataController.share

        serviceProvider.update(request: requestData) { (response) in
            completion(response)
        }
    }

    func deleteEntity(_ requestData: BrowseProducts.Model.Request, completion: @escaping (Result<Bool, NSError>) -> ()) {
        let serviceProvider: CoreDataController = CoreDataController.share
        serviceProvider.delete(request: requestData)
    }
}
