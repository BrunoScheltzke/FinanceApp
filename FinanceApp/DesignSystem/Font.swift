//
//  Font.swift
//
//  Created by Bruno Scheltzke on 08/07/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

struct Font {
    
    static func poppins(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func poppinsBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func navFont() -> UIFont {
        return Font.poppins(ofSize: 17)
    }
    
    static func navLargeTitleFont() -> UIFont {
        let titleSize: CGFloat = UIDevice().isSmall ? 24 : 30
        return Font.poppinsBold(ofSize: titleSize)
    }
    
    static func cellFont() -> UIFont {
        return Font.poppins(ofSize: UIDevice().isSmall ? 15 : 17)
    }
    
    static func emptyStateTitleFont() -> UIFont {
        return Font.poppinsBold(ofSize: UIDevice().isSmall ? 15 : 17)
    }
    
    static func emptyStateDescriptionFont() -> UIFont {
        return Font.poppins(ofSize: UIDevice().isSmall ? 15 : 17)
    }
    
    static func emptyStateButtonFont() -> UIFont {
        return Font.poppinsBold(ofSize: UIDevice().isSmall ? 15 : 17)
    }
    
}
