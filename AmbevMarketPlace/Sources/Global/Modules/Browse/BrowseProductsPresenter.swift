//
//  BrowseProductsPresenter.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

protocol BrowseProductsPresentationLogic {
    func presentNavigationTitle()
    func presentScreenValues(_ model: [BrowseProducts.Model.ProductsModel]?)
    func animateScreen(_ isLoading: Bool)
}

class BrowseProductsPresenter: BrowseProductsPresentationLogic {
    
    // MARK: Architecture Objects
    
    weak var viewController: BrowseProductsDisplayLogic?
    
    // MARK: Functions

    func presentNavigationTitle() {
        let viewModel = BrowseProducts.Model.ViewModel(navigationTitle: BrowseProductsStrings.navigationTitle)
        viewController?.displayNavigationTitle(viewModel)
    }

    func presentScreenValues(_ model: [BrowseProducts.Model.ProductsModel]?) {
        guard let model = model else { return }
        let tableListViewModel = createTableListViewModel(model)
        let viewModel = TableListView.Model.ViewModel(products: tableListViewModel, actionButtonTitle: BrowseProductsStrings.actionButtonTitle)
        viewController?.displayScreenValues(viewModel)
    }

    private func createTableListViewModel(_ response: [BrowseProducts.Model.ProductsModel]) -> [TableListView.Model.Product] {
        return response.compactMap { (item) -> TableListView.Model.Product? in
            return TableListView.Model.Product(id: item.id,
                                               image: item.image,
                                               placeholderImage: Images.beer.literal,
                                               title: item.description,
                                               subtitle: item.unity,
                                               description: item.volume,
                                               comments: getComments(item),
                                               isSelected: item.isSelected,
                                               stepperValue: item.quantity)
        }
    }
    
    func animateScreen(_ isLoading: Bool) {
        viewController?.animateScreen(isLoading)
    }

    private func getComments(_ item: BrowseProducts.Model.ProductsModel) -> NSAttributedString? {
        guard let price = item.price else { return nil }
        let priceAttributedString = priceToAttributedString(value: price, font: Fonts.helveticaNeue.bold.size(13), size: 13, color: Colors.green7Up.literal)
        guard let oldPrice = item.oldPrice else { return priceAttributedString }

        let oldPriceString = priceToString(value: oldPrice, font: Fonts.helveticaNeue.bold.size(11), size: 11, color: .gray)
        let oldPriceStrikeThrough = oldPriceString.strikethroughStyle(font: Fonts.helveticaNeue.bold.size(11), size: 11, fontColor: .gray, strikethroughColor: .gray)

        let text = NSMutableAttributedString()
        text.append(priceAttributedString)
        text.append(NSAttributedString(string: "  "))
        text.append(oldPriceStrikeThrough)
        return text
    }

    private func priceToAttributedString(value: Double, font: UIFont, size: CGFloat, color: UIColor) -> NSAttributedString {
        let valueInString = value.currencyString(withPrefix: Constants.Locales.do.currencyPrefix, locale: Constants.Locales.do.literal)
        return valueInString.attributedText(font: font, size: size, color: color)
    }

    private func priceToString(value: Double, font: UIFont, size: CGFloat, color: UIColor) -> String {
        let valueInString = value.currencyString(withPrefix: Constants.Locales.do.currencyPrefix, locale: Constants.Locales.do.literal)
        return valueInString
    }
}
