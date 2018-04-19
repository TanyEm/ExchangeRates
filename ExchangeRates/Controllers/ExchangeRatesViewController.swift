//
//  ExchangeRatesViewController.swift
//  ExchangeRates
//
//  Created by Tanya Tomchuk on 18/04/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit

class ExchangeRatesViewController: UIViewController {


    let dataArray = ["AUD", "AZN", "GBP", "AMD", "BYN", "BGN", "USD", "EUR", "RUB"]
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
        exchangeRatesCollectionView.register(UINib(nibName: "CurrencyCell", bundle: nil),
                                             forCellWithReuseIdentifier: "CurrencyCell")

        // Set Delegates
        self.exchangeRatesCollectionView.delegate = self
        self.exchangeRatesCollectionView.dataSource = self

        // Setup grid view
        self.setupGridWiew()
    }

    func setupGridWiew() {
        let flow = exchangeRatesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ExchangeRatesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exchangeRatesCollectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        cell.setData(code: self.dataArray[indexPath.row])
        return cell
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
