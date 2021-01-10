//
//  UITableView.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 07/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String {get}
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle.main)
    }
    
}

extension UITableViewCell: ReusableView {}

extension UITableView {
    
    func register<T: UITableViewCell>(type: T.Type) {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(type: T.Type) {
        self.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
    
}

extension UITableView {
    
    func scrollToTop() {
        guard self.numberOfSections > 0,
            self.numberOfRows(inSection: 0) > 0
            else { return }
        
        DispatchQueue.main.async {
            let indexPath = IndexPath( row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToBottom() {
        guard self.numberOfSections > 0
            else { return }
        
        var lastSection: Int?
        
        for section in (0 ..< self.numberOfSections).reversed() {
            if numberOfRows(inSection: section) > 0 {
                lastSection = section
                break
            }
        }
        
        guard let sectionToScroll = lastSection else {
            return
        }
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection: sectionToScroll) - 1,
                section: sectionToScroll)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
