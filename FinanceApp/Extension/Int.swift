//
//  Int.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 30/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import Foundation

extension Int {
    
    var localeCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$ "
        formatter.locale = .current
        return formatter.string(from: Double(self)/100 as NSNumber) ?? "0.00"
    }
    
}

extension Collection where Element == Int {
    
    var digitoCPF: Int {
        var number = count + 2
        let digit = 11 - reduce(into: 0) {
            number -= 1
            $0 += $1 * number
        } % 11
        return digit > 9 ? 0 : digit
    }
    
    var digitoCNPJ: Int {
        var number = 1
        let digit = 11 - reversed().reduce(into: 0) {
            number += 1
            $0 += $1 * number
            if number == 9 { number = 1 }
        } % 11
        return digit > 9 ? 0 : digit
    }
    
}

extension Double {
    
    var localeCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$ "
        formatter.locale = .current
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        formatter.groupingSize = 3
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: self as NSNumber) ?? "0,00"
    }
    
}
