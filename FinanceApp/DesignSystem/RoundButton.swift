//
//  RoundButton.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 04/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let titleSize: CGFloat = 18
        titleLabel?.font = Font.poppins(ofSize: titleSize)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setup()
    }
    
    override var intrinsicContentSize: CGSize {
        let height: CGFloat = UIDevice().isSmall ? 50 : 50
        var width: CGFloat = UIDevice().isSmall ? 80 : 100
        let padding: CGFloat = UIDevice().isSmall ? 110 : 130
        
        if let font = self.titleLabel?.font,
            let calculatedWidth = titleLabel?.text?.width(withConstrainedHeight: height, font: font),
            calculatedWidth != 0 {
            width = calculatedWidth + padding
        }
        return CGSize(width: width, height: height)
    }
    
}

@IBDesignable
class LightButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setTitleColor(.darkGray, for: .normal)
        backgroundColor = .clear
        let titleSize: CGFloat = 17
        titleLabel?.font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class RoundButton: BaseButton {
    
    override func setup() {
        super.setup()
        cornerRadius = 6
        tintColor = .appWhite
        backgroundColor = .mainBlue
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
    }
    
}

@IBDesignable
class PrimaryGradientButton: RoundButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.terciaryGold.cgColor, UIColor.secondGold.cgColor]
        l.startPoint = CGPoint(x: 0.5, y: 0.0)
        l.endPoint = CGPoint(x: 0.5, y: 1)
        l.cornerRadius = cornerRadius
        layer.insertSublayer(l, at: 0)
        return l
    }()
    
}

@IBDesignable
class PrimaryRoundButton: RoundButton {
    
    override func setup() {
        super.setup()
        backgroundColor = .mainBlue
    }
    
}

@IBDesignable
class SecondaryRoundButton: RoundButton {
    
    override func setup() {
        super.setup()
        backgroundColor = .appWhite
        setTitleColor(.mainBlue, for: .normal)
    }
    
}

@IBDesignable
class TerciaryRoundButton: RoundButton {
    
    override func setup() {
        super.setup()
        borderColor = .mainBlue
        borderWidth = 2
        tintColor = .mainBlue
        backgroundColor = .appWhite
    }
    
}

@IBDesignable
class QuarternaryButton: BaseButton {
    
    override func setup() {
        super.setup()
        backgroundColor = .appWhite
        tintColor = .secondaryTextColor
    }
    
}

@IBDesignable
class QuintenaryButton: BaseButton {
    
    override func setup() {
        super.setup()
        backgroundColor = #colorLiteral(red: 0.001877858071, green: 0.574170053, blue: 0.5429900289, alpha: 1)
    }
    
}
