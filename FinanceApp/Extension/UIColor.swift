//
//  UIColor.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 04/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let mainBlue = #colorLiteral(red: 0, green: 0.2239025533, blue: 0.3858552277, alpha: 1)
    static let secondGold = #colorLiteral(red: 0.6223787665, green: 0.5112614036, blue: 0.3800086081, alpha: 1)
    static let terciaryGold = #colorLiteral(red: 0.8473116159, green: 0.6766953468, blue: 0.4685052037, alpha: 1)
    static let mainGreen = #colorLiteral(red: 0.1409275234, green: 0.7909275889, blue: 0.3434121013, alpha: 1)
    static let primaryTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    static let secondaryTextColor = #colorLiteral(red: 0.4979824424, green: 0.498071909, blue: 0.4979767799, alpha: 1)
    static let appWhite = UIColor.white
    static let moneyGreen = #colorLiteral(red: 0.2976710796, green: 0.6878548265, blue: 0.3155451417, alpha: 1)
    
    func toImage(of size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
