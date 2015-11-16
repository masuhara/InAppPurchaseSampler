//
//  ViewController.swift
//  InAppPurchasesSampler
//
//  Created by Masuhara on 2015/11/14.
//  Copyright © 2015年 Daisuke Masuhara. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var number: Int!
    
    let bundleId = "net.masuhara.BaseballQuiz"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        number = 0
        label.text = String(number)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func retriveProducts(productId: String) {
        SwiftyStoreKit.retrieveProductInfo(bundleId + ".timePremium." + productId) { result in
            switch result {
            case .Success(let product):
                let priceString = NSNumberFormatter.localizedStringFromNumber(product.price, numberStyle: .CurrencyStyle)
                print("Product: \(product.localizedDescription), price: \(priceString)")
                break
            case .Error(let error):
                print("Error: \(error)")
                break
            }
        }
    }
    
    func purchaseProduct(productId: String) {
        SwiftyStoreKit.purchaseProduct(bundleId + ".timePremium." + productId) { result in
            switch result {
            case .Success(let productId):
                print("Purchase Success: \(productId)")
                
                self.number = self.number + 10
                self.label.text = String(self.number)
                
                break
            case .Error(let error):
                if case ResponseError.RequestFailed(let internalError) = error where internalError.domain == SKErrorDomain {
                    print("Internet connection error")
                }else if (error as NSError).domain == SKErrorDomain {
                    print("purchase failed")
                }else {
                    print("unknown error")
                }
                break
            }
        }
    }
    
    func restorePreviousPurchases() {
        SwiftyStoreKit.restorePurchases() { result in
            switch result {
            case .Success(let productId):
                print("Restore Success: \(productId)")
                break
            case .NothingToRestore:
                print("Nothing to Restore")
                break
            case .Error(let error):
                print("Restore Failed: \(error)")
                break
            }
        }
    }
    
    
    
    // MARK: - Purchase
    @IBAction func purchaseItem() {
        // self.retriveProducts("life")
        self.purchaseProduct("life")
    }
    
    @IBAction func purchase_1month() {
        // self.retriveProducts("1month")
        self.purchaseProduct("1month")
    }

    @IBAction func purchase_3months() {
        // self.retriveProducts("3month")
        self.purchaseProduct("3month")
    }

    @IBAction func purchase_6months() {
        // self.retriveProducts("6month")
        self.purchaseProduct("6month")
    }

}

