//
//  String.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 05/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

extension String {
    
    func toDouble() -> Double {
        return Double(self.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: " ", with: "")) ?? 0.0
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    var htmlStripped: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string

        return decoded ?? self
    }
    
}

extension StringProtocol {
    
    var isValidCNPJ: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(12).digitoCNPJ == numbers[12] &&
               numbers.prefix(13).digitoCNPJ == numbers[13]
    }
    
    var isValidCPF: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(9).digitoCPF == numbers[9] &&
               numbers.prefix(10).digitoCPF == numbers[10]
    }
    
}
