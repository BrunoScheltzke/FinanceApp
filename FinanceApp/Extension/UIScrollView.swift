//
//  UIScrollView.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 14/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

extension UIScrollView {

    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollRectToVisible(frame, animated: animated)
    }
    
}
