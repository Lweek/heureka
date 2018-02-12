//
//  Offer.swift
//  testheureka
//
//  Created by UX Team Prague on 12.02.18.
//  Copyright © 2018 heureka. All rights reserved.
//

import UIKit

class Offer: NSObject {
    
    static let offerIdKey = "offerId"
    static let productIdKey = "productId"
    static let titleKey = "title"
    static let productDescriptionKey = "description"
    static let urlKey = "url"
    static let imgUrlKey = "imgUrl"
    static let priceKey = "price"
    
    var offerId : Int?
    var productId : Int?
    var title : String?
    var productDescription : String?
    var url : URL?
    var imgUrl : URL?
    var price : String?
    
    init(dict : NSDictionary) {
        
        if let offerId = dict[Offer.offerIdKey] as? String {
            self.offerId = Int(offerId)
        }
        
        if let productId = dict[Offer.productIdKey] as? String {
            self.productId = Int(productId)
        }
        
        if let title = dict[Offer.titleKey] as? String {
            self.title = title
        }
        
        if let productDescription = dict[Offer.productDescriptionKey] as? String {
            self.productDescription = productDescription
        }
        
        if let url = dict[Offer.urlKey] as? String {
            self.url = URL(string: url)
        }
        
        if let imgUrl = dict[Offer.imgUrlKey] as? String {
            self.imgUrl = URL(string: imgUrl)
        }
        
        if let price = dict[Offer.priceKey] as? String {
            self.price = price
        }
    }

}
