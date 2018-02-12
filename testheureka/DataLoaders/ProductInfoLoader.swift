//
//  ProductInfoLoader.swift
//  testheureka
//
//  Created by UX Team Prague on 12.02.18.
//  Copyright © 2018 heureka. All rights reserved.
//

import UIKit
import Alamofire

class ProductInfoLoader: NSObject {
    
    var offers : [Offer] = []
    var productInfo : ProductInfo?
    
    func loadProductInfo(completionHandler : @escaping (Bool) -> Void) {
        
        let urlString = ApiConstants.apiUrl + ApiConstants.apiProductInfo + ApiConstants.productId
        
        Alamofire.request(urlString,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { response in
                            switch response.result {
                            case .success:
                                
                                if let productsInfoArray = response.result.value as? [NSDictionary] {
                                    
                                    if productsInfoArray.isEmpty {
                                        completionHandler(false)
                                        return
                                    }
                                    
                                     let productInfoDict = productsInfoArray.first!
                                    
                                    self.productInfo = ProductInfo(dict: productInfoDict)
                                    
                                    completionHandler(true)
                                    
                                } else {
                                    completionHandler(false)
                                }
                                
                                break
                            case .failure(let error):
                                
                                print(error)
                                
                                completionHandler(false)
                            }
        }
    }

}
