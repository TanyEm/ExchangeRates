//
//  NetworkManager.swift
//  ExchangeRates
//
//  Created by Tanya Tomchuk on 20/04/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient{

    static private let requestUrl = "https://www.cbr-xml-daily.ru/daily_json.js"
    static private var currenciesArray = [CurrencyData]()

    static func obtainCurrencies(closure: @escaping ([CurrencyData]) -> Void) {

        // If the data is not yet received, we will begin to receive it,
        // otherwise return the previously received data currenciesArray
        if currenciesArray.isEmpty{
            guard let apiURL = URL(string: requestUrl) else {
                return
            }

            Alamofire.request(apiURL).responseJSON { (response) in

                var currenciesData = CurrenciesData()
                do{
                    currenciesData = try JSONDecoder().decode(CurrenciesData.self, from: response.data!)
                    currenciesArray = Array(currenciesData.Valute.values)
                    closure(currenciesArray)

                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            closure(currenciesArray)
        }
    }
}
