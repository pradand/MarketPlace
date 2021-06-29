//
//  TableListViewModels.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

enum TableListView {
    
    // MARK: Use cases
    
    enum Model {
        struct ViewModel {
            let products: [Product]
            let actionButtonTitle: String
        }

        struct Product {
            let id: Int
            let image: String?
            let placeholderImage: UIImage
            let title: String?
            let subtitle: String?
            let description: String?
            let comments: NSAttributedString?
            let isSelected: Bool
            let stepperValue: String?

            init(id: Int, image: String? = nil, placeholderImage: UIImage, title: String? = nil, subtitle: String? = nil, description: String? = nil, comments: NSAttributedString? = nil, isSelected: Bool, stepperValue: String? = nil) {
                self.id = id
                self.image = image
                self.placeholderImage = placeholderImage
                self.title = title
                self.subtitle = subtitle
                self.description = description
                self.comments = comments
                self.isSelected = isSelected
                self.stepperValue = stepperValue
            }
        }
    }
}
