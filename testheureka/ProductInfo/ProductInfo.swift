//
//  ProductInfo.swift
//  testheureka
//
//  Created by UX Team Prague on 12.02.18.
//  Copyright © 2018 heureka. All rights reserved.
//

import UIKit

class ProductInfo : NSObject{
    
    static let productIdKey = "productId"
    static let titleKey = "title"
    static let categoryId = "categoryId"
    
    var productId : Int?
    var title : String?
    var categoryId : Int?
    
    init(dict : NSDictionary) {
        
        if let productId = dict[ProductInfo.productIdKey] as? String {
            self.productId = Int(productId)
        }
        
        if let title = dict[ProductInfo.titleKey] as? String {
            self.title = title
        }
        
        if let categoryId = dict[ProductInfo.categoryId] as? String {
            self.categoryId = Int(categoryId)
        }
        
    }
}
