//
//  UIButton.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 09/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

extension UIButton {
    func alignTextBelow(spacing: CGFloat = 6.0) {
        guard let image = self.imageView?.image else {
            return
        }

        guard let titleLabel = self.titleLabel else {
            return
        }

        guard let titleText = titleLabel.text else {
            return
        }

        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font ?? Font.poppins(ofSize: 16)
        ])

        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
        invalidateIntrinsicContentSize()
    }
}
