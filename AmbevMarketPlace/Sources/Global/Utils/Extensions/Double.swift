//
//  Double.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 22/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation

extension Double {
    func currencyString(withPrefix prefix: String = Constants.Locales.ptBR.currencyPrefix, locale: String = Constants.Locales.ptBR.literal) -> String {
        return String(format: "\(prefix)%.02f", locale: Locale(identifier: locale), arguments: [self])
    }
}
