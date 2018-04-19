//
//  CurrenciesCollectionViewCell.swift
//  ExchangeRates
//
//  Created by Tanya Tomchuk on 14/04/2018.
//  Copyright © 2018 Tanya Tomchuk. All rights reserved.
//

import UIKit

class CurrencyCell: UICollectionViewCell {

    @IBOutlet weak var ISOCode: UILabel!
    @IBOutlet weak var Currency: UILabel!
    @IBOutlet weak var Flag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(code:String){
        self.ISOCode.text = code
    }

}
