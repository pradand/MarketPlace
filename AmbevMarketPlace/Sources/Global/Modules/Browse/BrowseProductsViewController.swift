//
//  BrowseProductsViewController.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

protocol BrowseProductsDisplayLogic: class {
    func displayNavigationTitle(_ viewModel: BrowseProducts.Model.ViewModel)
    func displayScreenValues(_ viewModel: TableListView.Model.ViewModel)
    func animateScreen(_ isLoading: Bool)
}

class BrowseProductsViewController: TableListViewController {
    
    // MARK: Architecture Objects
    
    var interactor: BrowseProductsBusinessLogic?
    var router: (NSObjectProtocol & BrowseProductsRoutingLogic & BrowseProductsDataPassing)?

    // MARK: ViewController lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        setupDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupDelegate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupDelegate() {
        delegate = self
    }

    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = BrowseProductsInteractor()
        let presenter = BrowseProductsPresenter()
        let router = BrowseProductsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationControllerAttributes(barTintColor: Colors.bluePepsi.literal, titleTextColor: .white)
        interactor?.loadScreenValues()
    }

    override func didTapSort(isSelected: Bool) {
        interactor?.didTapSort(isSelected)
    }
}

extension BrowseProductsViewController: BrowseProductsDisplayLogic {
    func displayNavigationTitle(_ viewModel: BrowseProducts.Model.ViewModel) {
        self.title = viewModel.navigationTitle
    }

    func displayScreenValues(_ viewModel: TableListView.Model.ViewModel) {
        setViewModel(viewModel)
    }
}

extension BrowseProductsViewController: TableListViewDelegate {
    func didTapKartButton(_ isSelected: Bool, _ id: Int, _ stepperValue: String) {
        interactor?.didTapKartButton(isSelected, id, stepperValue)
    }
}
