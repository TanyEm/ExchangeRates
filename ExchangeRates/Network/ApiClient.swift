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

    private let requestUrl = "https://www.cbr-xml-daily.ru/daily_json.js"

    func obtainCurrencies(closure: @escaping ([CurrencyData]) -> Void) {
        guard let apiURL = URL(string: requestUrl) else {
            return
        }

        Alamofire.request(apiURL).responseJSON { (response) in

            var currenciesData = CurrenciesData()
            do{
                currenciesData = try JSONDecoder().decode(CurrenciesData.self, from: response.data!)
                closure(Array(currenciesData.Valute.values))

            } catch {
                print(error.localizedDescription)
            }
        }
    }

    
}
