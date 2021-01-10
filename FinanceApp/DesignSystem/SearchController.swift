//
//  SearchController.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 24/11/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

class SearchBar : UISearchBar {
    
    var placeholderText: String = "Pesquisar"
    
    override func didMoveToSuperview() {
        tintColor = .mainBlue
        if #available(iOS 13.0, *) {
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor : UIColor.black], for: .normal)
            let placeholderColor = UIColor.black.withAlphaComponent(0.75)
            let placeholderAttributes = [NSAttributedString.Key.foregroundColor : placeholderColor]
            let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
            searchTextField.attributedPlaceholder = attributedPlaceholder
            searchTextField.textColor = .black
            (searchTextField.leftView as? UIImageView)?.tintColor = placeholderColor
            searchTextField.clearButtonMode = .never
            searchTextField.backgroundColor = .appWhite
        } else {
            super.didMoveToSuperview()
        }
        
    }
    
}

class SearchController : UISearchController {
    
    private lazy var customSearchBar = SearchBar()
    override var searchBar: UISearchBar { customSearchBar }
    
}
