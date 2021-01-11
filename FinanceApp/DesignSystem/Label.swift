//
//  Label.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 05/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        textColor = .secondaryTextColor
        let titleSize: CGFloat =  17
        font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class PrimaryLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .secondaryTextColor
    }
    
}

@IBDesignable
class SecondaryLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
}

@IBDesignable
class PrimarySmallLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .primaryTextColor
        let titleSize: CGFloat = UIDevice().isSmall ? 12 : 14
        font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class SecondarySmallLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .secondaryTextColor
        let titleSize: CGFloat = UIDevice().isSmall ? 12 : 14
        font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class TerciarySmallLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .appWhite
        let titleSize: CGFloat = UIDevice().isSmall ? 12 : 14
        font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class QuarternarySmallLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .black
        let titleSize: CGFloat = UIDevice().isSmall ? 12 : 14
        font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class MoneyLabel: BaseLabel {

    override func setup() {
        super.setup()
        textColor = .moneyGreen
    }
    
}

@IBDesignable
class MoneySmallLabel: BaseLabel {

    override func setup() {
        super.setup()
        textColor = .moneyGreen
        let titleSize: CGFloat = UIDevice().isSmall ? 12 : 14
        font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class TerciaryLabel: BaseLabel {

    override func setup() {
        super.setup()
        textColor = .appWhite
    }
    
}

@IBDesignable
class QuartenaryLabel: BaseLabel {

    override func setup() {
        super.setup()
        textColor = .mainBlue
    }
    
}


@IBDesignable
class QuinteraryLabel: BaseLabel {
    
    override func setup() {
        super.setup()
        textColor = .black
    }
    
}

@IBDesignable
class HeaderLabel: BaseLabel {

    override func setup() {
        textColor = .mainBlue
        let titleSize: CGFloat = UIDevice().isSmall ? 16 : 18
        font = Font.poppinsBold(ofSize: titleSize)
    }
    
}

@IBDesignable
class SecondaryHeaderLabel: BaseLabel {

    override func setup() {
        textColor = .black
        let titleSize: CGFloat = UIDevice().isSmall ? 16 : 18
        font = Font.poppinsBold(ofSize: titleSize)
    }
    
}

@IBDesignable
class TerciaryHeaderLabel: BaseLabel {

    override func setup() {
        textColor = .appWhite
        let titleSize: CGFloat = UIDevice().isSmall ? 16 : 18
        font = Font.poppinsBold(ofSize: titleSize)
    }
    
}

@IBDesignable
class QuartenaryHeaderLabel: BaseLabel {

    override func setup() {
        textColor = .appWhite
        let titleSize: CGFloat = UIDevice().isSmall ? 16 : 18
        font = Font.poppinsBold(ofSize: titleSize)
    }
    
}

@IBDesignable
class LargeTitleLabel: BaseLabel {

    override func setup() {
        textColor = .black
        let titleSize: CGFloat = UIDevice().isSmall ? 24 : 26
        font = Font.poppinsBold(ofSize: titleSize)
    }
    
}

@IBDesignable
class SecondaryLargeTitleLabel: BaseLabel {

    override func setup() {
        textColor = .appWhite
        let titleSize: CGFloat = UIDevice().isSmall ? 24 : 26
        font = Font.poppinsBold(ofSize: titleSize)
    }
    
}

@IBDesignable
class TerciaryLargeTitleLabel: BaseLabel {

    override func setup() {
        textColor = .appWhite
        let titleSize: CGFloat = UIDevice().isSmall ? 24 : 26
        font = Font.poppinsBold(ofSize: titleSize)
    }
    
}

@IBDesignable
class TitleLabel: BaseLabel {

    override func setup() {
        textColor = .mainBlue
        let titleSize: CGFloat = UIDevice().isSmall ? 16 : 18
        font = Font.poppins(ofSize: titleSize)
    }
    
}

@IBDesignable
class SmallTitleLabel: BaseLabel {

    override func setup() {
        textColor = .black
        font = Font.poppinsBold(ofSize: 16)
    }
    
}

@IBDesignable
class SecondaryTitleLabel: TitleLabel {

    override func setup() {
        super.setup()
        textColor = .appWhite
    }
    
}

@IBDesignable
class BackgroundLabel: BaseLabel {

    override func setup() {
        super.setup()
        textColor = .appWhite
        backgroundColor = .mainBlue
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        super.drawText(in: rect.inset(by: insets))
    }
    
}

@IBDesignable
class PrimaryTinyBoldLabel: BaseLabel {

    override func setup() {
        textColor = #colorLiteral(red: 0.431372549, green: 0.4549019608, blue: 0.537254902, alpha: 1)
        font = Font.poppinsBold(ofSize: 11)
    }
    
}

@IBDesignable
class PrimaryTinyLabel: BaseLabel {

    override func setup() {
        textColor = #colorLiteral(red: 0.431372549, green: 0.4549019608, blue: 0.537254902, alpha: 1)
        font = Font.poppins(ofSize: 11)
    }
    
}

@IBDesignable
class SecondaryTinyLabel: BaseLabel {

    override func setup() {
        textColor = .appWhite
        font = Font.poppins(ofSize: 11)
    }
    
}
