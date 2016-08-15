//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

enum CurrencyEnum : String {
    case GBP
    case EUR
    case JPY
    case BRL
}

class Currency {
    var keyName : String?
    var rate : Double?
    
    init(keyName: String?, rate: Double?) {
        self.keyName = keyName
        self.rate = rate
    }
    
    func getCurrencyConversion(value: Int?) -> String {
        
        if let rate = self.rate {
           return FormatHelper.formattedCurrency(rate * Double(value ?? 0), symbol: symbol())
        }
        return "$0"
    }
    
    func symbol() -> String {
        
        guard let keyName = self.keyName else {
            return "$"
        }
        
        switch keyName {
        case CurrencyEnum.GBP.rawValue: return "£"
        case CurrencyEnum.EUR.rawValue: return "€"
        case CurrencyEnum.JPY.rawValue: return "¥"
        case CurrencyEnum.BRL.rawValue: return "R$"
        default : return "$"
        }
    }
    
}