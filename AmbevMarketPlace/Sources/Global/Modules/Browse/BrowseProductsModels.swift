//
//  BrowseProductsModels.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright (c) 2020 Andre. All rights reserved.
//

import UIKit

enum BrowseProducts {
    
    // MARK: Use cases
    
    enum Model {

        struct Request {
            let id: String
            let quantity: String
        }

        struct ProductsModel {
            let id: Int
            let image: String?
            let description: String?
            let unity: String?
            let volume: String?
            let price: Double?
            let oldPrice: Double?
            let isSelected: Bool
            let quantity: String?

            init(id: Int,
                 image: String? = nil,
                 description: String? = nil,
                 unity: String? = nil,
                 volume: String? = nil,
                 price: Double? = nil,
                 oldPrice: Double? = nil,
                 isSelected: Bool = false,
                 quantity: String? = nil) {
                self.id = id
                self.image = image
                self.description = description
                self.unity = unity
                self.volume = volume
                self.price = price
                self.oldPrice = oldPrice
                self.isSelected = isSelected
                self.quantity = quantity
            }
        }

        struct Response: Codable {
            let products: [Product]

            enum CodingKeys: String, CodingKey {
                case products
            }
        }

        struct Product: Codable {
            let id: Int
            let image: String?
            let description: String?
            let unity: String?
            let volume: String?
            let price: Double?
            let oldPrice: Double?

            enum CodingKeys: String, CodingKey {
                case id = "product_id"
                case image = "product_image"
                case description = "product_description"
                case unity
                case volume
                case price = "price"
                case oldPrice = "old_price"
            }
        }

        struct ViewModel {
            let navigationTitle: String
        }
    }
}
