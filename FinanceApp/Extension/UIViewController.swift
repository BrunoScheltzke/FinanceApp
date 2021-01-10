//
//  UIViewController.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 04/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func present(toast: String) {
        UIApplication.shared.windows.first?.rootViewController?.view.makeToast(toast)
    }
    
    func present(message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "FinanceApp", message: message, preferredStyle: .alert)
        alert.view.tintColor = .mainBlue
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentDecision(message: String, yes: ((UIAlertAction) -> Void)? = nil, no: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "FinanceApp", message: message, preferredStyle: .alert)
        alert.view.tintColor = .mainBlue
        let action1 = UIAlertAction(title: "Não", style: .destructive, handler: no)
        alert.addAction(action1)
        let action2 = UIAlertAction(title: "Sim", style: .default, handler: yes)
        alert.addAction(action2)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func present(error: Error) {
        present(message: error.localizedDescription)
    }
    
    func addHideKeyboardOnTouch() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
