//
//  CurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class CurrencyRepository: ICurrencyRepository {
    
    static let sharedInstance = CurrencyRepository()
    
    class var sharedDispatchInstance: CurrencyRepository {
        
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: CurrencyRepository? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = CurrencyRepository()
        }
        
        return Stactic.instance!
    }
    
    func findCurrencies(completion: (success: [Currency]!, fail: NSError?) -> Void) {
        
    }
}