//
//  Constants.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 21/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

struct Constants {

    enum EndPoint {
        case apiURLBase
        case productsJson

        var literal: String {
            switch self {
            case .productsJson:
                return "Products"
            default:
                return ""
            }
        }
    }

    enum Lottie {
        enum Animations: String {
            case fillingUpBeerCup = "loading-beer-animation"
            var filename: String {
                return self.rawValue
            }
        }
    }

    enum Locales {
        case ptBR
        case `do`

        var literal: String {
            switch self {
            case .ptBR:
                return "pt_BR"
            case .do:
                return "DO"
            }
        }

        var currencyPrefix: String {
            switch self {
            case .ptBR:
                return "R$ "
            case .do:
                return "RD$ "
            }
        }
    }
}
