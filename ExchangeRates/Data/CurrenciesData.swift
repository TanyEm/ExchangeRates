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
    var ID: String?
    var NumCode: String?
    var Nominal: Int?
    var Name: String?
    var Previous: Double?
    init() {
        Value = 0.0
        CharCode = ""
        ID = ""
        NumCode = ""
        Nominal = 0
        Name = ""
        Previous = 0.0
    }
}
