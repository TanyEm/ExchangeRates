//
//  CurrencyData.swift
//  ExchangeRates
//
//  Created by Tanya Tomchuk on 17/04/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import Foundation

struct CurrenciesData: Decodable {
    var Timestamp: String?
    var Valute: [String: CurrencyData]
    init() {
        Timestamp = ""
        Valute = [String: CurrencyData]()
    }
}

struct CurrencyData: Decodable {
    var Value: Double?
    var CharCode: String?
    init() {
        Value = 0.0
        CharCode = ""
    }
}
