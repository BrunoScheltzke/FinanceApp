//
//  NibLoadableView.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 10/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

@IBDesignable
class NibLoadingView: UIView, ReusableView {

    @IBOutlet weak var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {
        backgroundColor = .clear

        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true

        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        return Self.nib.instantiate(withOwner: nil, options: nil).first as? UIView ?? UIView()
    }

}
