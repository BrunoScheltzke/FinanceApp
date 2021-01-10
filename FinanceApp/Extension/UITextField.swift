//
//  UITextField.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 23/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
