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

struct CurrencyInfo
{
    var name: String?
    var flag: String?
    var symbol: String?
}

class Currency {
    var keyName : String?
    var rate : Double?
    
    var flag : String?
    var symbolRate : String?
    var name : String?
    
    init(keyName: String?, rate: Double?) {
        self.keyName = keyName
        self.rate = rate
    }
    
    func getCurrencyConversion(value: Int?) -> Currency {
        
        let value = Double(value ?? 0)
        
        if let rate = self.rate {
           let currencyInfo = getCurrencyInfoBy(self.keyName!)
           self.flag = currencyInfo.flag
           self.name = currencyInfo.name
           self.symbolRate = FormatHelper.formattedCurrency(rate * value, symbol: currencyInfo.symbol!)
        }
        
        return self
    }
    
    func getCurrencyInfoBy(key: String) -> CurrencyInfo {
        switch key {
        case CurrencyEnum.GBP.rawValue: return CurrencyInfo(name: "Pound sterling", flag: FormatHelper.emojiFlag(countryCode: "gb"), symbol: "£")
        case CurrencyEnum.EUR.rawValue: return CurrencyInfo(name: "Euro", flag: FormatHelper.emojiFlag(countryCode: "eu"), symbol: "€")
        case CurrencyEnum.JPY.rawValue: return CurrencyInfo(name: "Japanese Yen", flag: FormatHelper.emojiFlag(countryCode: "jp"), symbol: "¥")
        case CurrencyEnum.BRL.rawValue: return CurrencyInfo(name: "Brazilian Real", flag: FormatHelper.emojiFlag(countryCode: "br"), symbol: "R$")
        default : return CurrencyInfo(name: "US Dollar", flag: FormatHelper.emojiFlag(countryCode: "us"), symbol: "$")
        }
    }
    
}