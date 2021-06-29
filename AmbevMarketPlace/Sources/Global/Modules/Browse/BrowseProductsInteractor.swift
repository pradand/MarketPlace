//
//  BrowseProductsInteractor.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

protocol BrowseProductsBusinessLogic {
    func loadScreenValues()
    func didTapSort(_ isSelected: Bool)
    func didTapKartButton(_ isSelected: Bool, _ id: Int, _ stepperValue: String)
}

protocol BrowseProductsDataStore {}

class BrowseProductsInteractor: BrowseProductsBusinessLogic, BrowseProductsDataStore {
    
    // MARK: Architecture Objects
    
    var presenter: BrowseProductsPresentationLogic?
    let worker: BrowseProductsWorker
    
    // MARK: - DataStore Objects
    

    // MARK: - Variables

    private var productsModel: [BrowseProducts.Model.ProductsModel]?
    private var orderedProducts: [OrderedProducts]?
    
    // MARK: Init

    init(worker: BrowseProductsWorker = BrowseProductsWorker()) {
        self.worker = worker
    }
    
    // MARK: Functions

    func loadScreenValues() {
        presenter?.animateScreen(true)
        presenter?.presentNavigationTitle()
        fetchFromEntity()
    }

    func didTapSort(_ isSelected: Bool) {
        presenter?.animateScreen(true)
        let sortedProducts = self.productsModel?.sorted(by: { (current, next) -> Bool in
            guard let currentDescription = current.description?.lowercased(), let nextDescription = next.description?.lowercased() else { return false }
            let comparisonResult: ComparisonResult = isSelected ? ComparisonResult.orderedAscending : ComparisonResult.orderedDescending
            return currentDescription.compare(nextDescription) == comparisonResult
        })
        self.productsModel = sortedProducts
        presenter?.presentScreenValues(self.productsModel)
        presenter?.animateScreen(false)
    }

    func didTapKartButton(_ isSelected: Bool, _ id: Int, _ stepperValue: String) {
        guard let selectedData = self.productsModel?.first(where: {$0.id == id}) else { return }
        let data = self.productsModel?.compactMap({ (item) -> BrowseProducts.Model.ProductsModel? in
            if selectedData.id == item.id {
                return BrowseProducts.Model.ProductsModel(id: item.id,
                                                          image: item.image,
                                                          description: item.description,
                                                          unity: item.unity,
                                                          volume: item.volume,
                                                          price: item.price,
                                                          oldPrice: item.oldPrice,
                                                          isSelected: isSelected,
                                                          quantity: isSelected ? stepperValue : item.quantity)
            } else {
                return BrowseProducts.Model.ProductsModel(id: item.id,
                                                          image: item.image,
                                                          description: item.description,
                                                          unity: item.unity,
                                                          volume: item.volume,
                                                          price: item.price,
                                                          oldPrice: item.oldPrice,
                                                          isSelected: item.isSelected,
                                                          quantity: item.quantity)
            }
        })
        self.productsModel = data

        guard isSelected else {
            let request = BrowseProducts.Model.Request(id: "\(id)", quantity: stepperValue)
            worker.deleteEntity(request, completion: { _ in })
            //deleteEntity(request)
            presenter?.presentScreenValues(self.productsModel)
            return
        }

        let request = BrowseProducts.Model.Request(id: "\(selectedData.id)", quantity: stepperValue)
        saveEntity(request)
        presenter?.presentScreenValues(self.productsModel)
    }

    private func saveEntity(_ request: BrowseProducts.Model.Request) {
        worker.saveToEntity(request) { (response) in
            switch response {
            case .success(_ ):
                return
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    self?.handleErrorFromEntity(failure)
                }
            }
        }
    }
    /*
     Faltou implementar
    private func deleteEntity(_ request: BrowseProducts.Model.Request) {
        worker.deleteEntity(request) { (response) in
            switch response {
            case .success(_ ):
                return
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    self?.handleErrorDeleteEntity(failure)
                }
            }
        }
    }
*/
    private func fetchFromEntity() {
        worker.fetchDataFromEntity { (response) in
            switch response {
            case .success(let success):
                DispatchQueue.main.async { [weak self] in
                    self?.handleSuccess(success)
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    self?.handleErrorFromEntity(failure)
                }
            }
        }
    }

    private func fetchProducts() {
        worker.fetchData { [weak self] (response) in
            switch response {
            case .success(let success):
                DispatchQueue.main.async { [weak self] in
                    self?.handleSuccess(success)
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    self?.handleError(failure)
                }
            }
        }
    }

    private func handleSuccess(_ response: BrowseProducts.Model.Response) {
        self.productsModel = response.products.compactMap({ (product) -> BrowseProducts.Model.ProductsModel? in
            let contextProduct = orderedProducts?.first(where: {$0.productId == "\(product.id)"})
            return BrowseProducts.Model.ProductsModel(id: product.id,
                                                      image: product.image,
                                                      description: product.description,
                                                      unity: product.unity,
                                                      volume: product.volume,
                                                      price: product.price,
                                                      oldPrice: product.oldPrice,
                                                      isSelected: contextProduct?.productId != nil,
                                                      quantity: contextProduct?.quantity)
        })
        presenter?.presentScreenValues(productsModel)
        presenter?.animateScreen(false)
    }
    
    private func handleSuccess(_ response: [OrderedProducts]) {
        self.orderedProducts = response
        fetchProducts()
    }

    private func handleError(_ error: Error) {
        presenter?.animateScreen(false)
        switch error {
        default:
            print("error \(error.localizedDescription.description)")
        }
    }
    
    private func handleErrorFromEntity(_ error: Error) {
        switch error {
        default:
            print("error \(error.localizedDescription.description)")
        }
        fetchProducts()
    }

    private func handleErrorDeleteEntity(_ error: NSError) {
        switch error {
        default:
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
