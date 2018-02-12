//
//  ViewController.swift
//  testheureka
//
//  Created by UX Team Prague on 12.02.18.
//  Copyright © 2018 heureka. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var preview: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    private var productDescription : String?
    
    private let offersLoader = OffersLoader()
    private var offers : [Offer] = []
    
    private let productInfoLoader = ProductInfoLoader()
    private var productInfo : ProductInfo?
    
    private var itemsToLoad = 2

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        refresh(refreshControl)
    }
    
    //called on load + when pulled to refresh
    @objc func refresh (_ refreshControl: UIRefreshControl) {
        itemsToLoad = 2
        
        //load product info
        productInfoLoader.loadProductInfo() { result in
            if (result) {
                self.productInfo = self.productInfoLoader.productInfo
                
                //set title into navigation bar
                self.title = self.productInfo?.title
            } else {
                self.showAlert()
            }
            
            self.itemsToLoad -= 1
            if (self.itemsToLoad == 0) {
                refreshControl.endRefreshing()
            }
        }
        
        //load all offers
        offersLoader.loadOffers() { result in
            if result {
                self.offers = self.offersLoader.offers
                
                //use first available image as preview
                self.pickFirstImage(offers: self.offers)
                //use first available description as product description
                self.pickFirstDescription(offers: self.offers)
                
                self.tableView.reloadData()
            } else {
                self.showAlert()
            }
            
            self.itemsToLoad -= 1
            if (self.itemsToLoad == 0) {
                refreshControl.endRefreshing()
            }
        }
    }
    
    //use first available image as preview
    func pickFirstImage(offers: [Offer]){
        for offer in offers {
            if let imgUrl = offer.imgUrl {
                
                Alamofire.request(imgUrl).response { response in
                    if let data = response.data {
                        self.preview.image = UIImage(data: data)
                        self.preview.contentMode = .scaleAspectFit
                    } else {
                        print("Could not load image")
                        self.showAlert()
                    }
                }
                
                return
            }
        }
    }
    
    //use first available description as product description
    func pickFirstDescription(offers: [Offer]) {
        for offer in offers {
            if let description = offer.productDescription {
                
                self.productDescription = description
                
                return
            }
        }
    }
    
    //Show alert when anything fails
    func showAlert() {
        let alert = UIAlertController(title: "Download fail", message: "Failed to download data. Try to refresh.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //-----------------------------
    // UITableView protocol methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Use automatic dimensions for description section
        if (indexPath.section == 2) {
            return UITableViewAutomaticDimension
        } else {
            return 50
        }
    }
    
    //1 - Title, 2 - offers, 3 - description
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //when no offers, dont show title and description
        if (offers.isEmpty) {
            return 0
        } else if (section == 0){
            return 1
        } else if (section == 1){
            return offers.count
        } else if (section == 2) {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //title
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")!
            return cell
        }
        
        //description
        if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! ProductDescriptionTableViewCell
            cell.descriptionLabel.text = productDescription
            
            return cell
        }
        
        //offers
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell") as! OfferTableViewCell
        
        cell.setProductName(name: offers[indexPath.row].title)
        cell.setProductPrice(price: offers[indexPath.row].price)
        
        return cell
    }

    //open url on selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (indexPath.section == 1) {
            
            print("Open URL: \(offers[indexPath.row].url?.absoluteString ?? "")")
        }
    }
    
    

}

