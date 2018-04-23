//
//  ExchangeRatesViewController.swift
//  ExchangeRates
//
//  Created by Tanya Tomchuk on 18/04/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ExchangeRatesViewController: UIViewController {

    private var currenciesArray = [CurrencyData]()
    private let cellID = "CurrencyCell"
    private let imageURL = "https://raw.githubusercontent.com/transferwise/currency-flags/master/src/flags"

    var estimateWith = 160.0
    var cellMarginSize = 16.00

    @IBOutlet weak var exchangeRatesCollectionView: UICollectionView!


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

        // Register cells
        exchangeRatesCollectionView.register(UINib(nibName: cellID, bundle: nil),
                                             forCellWithReuseIdentifier: cellID)

        // Set Delegates
        self.exchangeRatesCollectionView.delegate = self
        self.exchangeRatesCollectionView.dataSource = self

        // Setup grid view
        self.setupGridWiew()

        // Do any additional setup after loading the view.

        ApiClient.obtainCurrencies(closure: { (currenciesArray) -> Void in
            self.currenciesArray = currenciesArray
            DispatchQueue.main.async { [weak self] in
                self?.exchangeRatesCollectionView.reloadData()
            }
        })

    }

    func setupGridWiew() {
        let flow = exchangeRatesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
}

extension ExchangeRatesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currenciesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exchangeRatesCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CurrencyCell
        cell.setData(code: currenciesArray[indexPath.row].CharCode!, currency: currenciesArray[indexPath.row].Value!)

        DispatchQueue.global(qos: .background).async {
            let imageName = "\(self.currenciesArray[indexPath.row].CharCode!.lowercased()).png"
            let baseURL = URL(string: "\(self.imageURL)")
            let url = baseURL?.appendingPathComponent(imageName)
            if url != nil{
                cell.Flag.sd_setShowActivityIndicatorView(true)
                cell.Flag.sd_setIndicatorStyle(.gray)
                cell.Flag.sd_setImage(with: url)
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let aboutCurrencyTableViewController = storyboard.instantiateViewController(withIdentifier: "About") as! AboutCurrencyTableViewController
        aboutCurrencyTableViewController.title = currenciesArray[indexPath.row].CharCode!
        aboutCurrencyTableViewController.currencyIndex = indexPath.row

        self.navigationController?.show(aboutCurrencyTableViewController, sender: Any?.self)
        self.exchangeRatesCollectionView.deselectItem(at: indexPath, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()

        return CGSize(width: width, height: width)
    }

    func calculateWith() -> CGFloat {
        let estimatedWith = CGFloat(estimateWith)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWith))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount

        return width
    }

}
