//
//  AboutCurrencyTableViewController.swift
//  ExchangeRates
//
//  Created by Tanya Tomchuk on 14/04/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit

class AboutCurrencyTableViewController: UITableViewController {

    private var currenciesArray = [CurrencyData]()
    var currencyIndex = 0

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var numCodeLabel: UILabel!
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var previousLabel: UILabel!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        // iOS not collapsing large navbar workaround
        navigationItem.largeTitleDisplayMode = .always
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        ApiClient.obtainCurrencies(closure: { (currenciesArray) -> Void in
            self.currenciesArray = currenciesArray
            DispatchQueue.main.async { [weak self] in

                self?.valueLabel.text = String(format: "%.3f",(self?.currenciesArray[(self?.currencyIndex)!].Value)!)
                self?.idLabel.text = self?.currenciesArray[(self?.currencyIndex)!].ID
                self?.nameLabel.text = self?.currenciesArray[(self?.currencyIndex)!].Name
                self?.nominalLabel.text = String(format: "%d",(self?.currenciesArray[(self?.currencyIndex)!].Nominal)!)
                self?.numCodeLabel.text = self?.currenciesArray[(self?.currencyIndex)!].NumCode
                self?.previousLabel.text = String(format: "%.3f",(self?.currenciesArray[(self?.currencyIndex)!].Previous)!)


                self?.tableView.reloadData()
            }
        })
    }

    
}
