//
//  Fonts.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 21/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

enum Fonts {

    enum openSansCondensed: String {
        case bold = "OpenSansCondensed-Bold"

        public func size(_ ofSize: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }

    enum helveticaNeue: String {
        case bold = "HelveticaNeue-Bold"
        case regular = "HelveticaNeue-Regular"

        public func size(_ ofSize: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }

    enum futura: String {
        case bold = "Futura-Bold"

        public func size(_ ofSize: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        }
    }

}
