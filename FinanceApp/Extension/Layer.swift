//
//  Layer.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 04/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow(with color: UIColor,
                   alpha: Float = 1.0,
                   xOffset: CGFloat = 0,
                   yOffset: CGFloat = 0,
                   blur: CGFloat = 0,
                   spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOffset = CGSize(width: xOffset, height: yOffset)
        shadowRadius = blur / 2.0
        shadowOpacity = alpha
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        }
    }
}
