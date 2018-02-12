//
//  Offers.swift
//  testheureka
//
//  Created by UX Team Prague on 12.02.18.
//  Copyright © 2018 heureka. All rights reserved.
//

import UIKit
import Alamofire

class OffersLoader: NSObject {
    
    var offers : [Offer] = []
    
    func loadOffers(completionHandler : @escaping (Bool) -> Void) {
        
        let urlString = ApiConstants.apiUrl + ApiConstants.apiOffers + ApiConstants.productId
        
        Alamofire.request(urlString,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { response in
                            
                            self.offers.removeAll()
                            
                            switch response.result {
                            case .success:
                                
                                if let offersArray = response.result.value as? [NSDictionary] {
                                    
                                    for offerDict in offersArray {
                                        let offer = Offer(dict: offerDict)
                                        
                                        self.offers.append(offer)
                                    }
                                    
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
