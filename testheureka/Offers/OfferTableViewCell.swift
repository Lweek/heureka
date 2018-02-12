//
//  OfferTableViewCell.swift
//  testheureka
//
//  Created by UX Team Prague on 12.02.18.
//  Copyright © 2018 heureka. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func setProductPrice(price : String?) {
        if let price = price {
            productPriceLabel.text = price + ",-"
        } else {
            productPriceLabel.text = "-"
        }
    }
    
    func setProductName(name : String?) {
        productNameLabel.text = name
    }

}
