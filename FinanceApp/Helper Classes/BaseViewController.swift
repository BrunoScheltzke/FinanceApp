//
//  BaseViewController.swift
//  KickSoccer
//
//  Created by Bruno Scheltzke on 10/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var statusViewColor: UIColor { return .mainBlue }
    var navBarColor: UIColor { return .mainBlue }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {}
    
    func setupLocalize() {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.backgroundColor = navBarColor
        setupLocalize()
        if #available(iOS 13.0, *) {
            //        let app = UIApplication.shared
            //        let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            //
            //        let statusbarView = UIView()
            //        statusbarView.backgroundColor = statusViewColor
            //        view.addSubview(statusbarView)
            //
            //        statusbarView.translatesAutoresizingMaskIntoConstraints = false
            //        statusbarView.heightAnchor
            //          .constraint(equalToConstant: statusBarHeight).isActive = true
            //        statusbarView.widthAnchor
            //          .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            //        statusbarView.topAnchor
            //          .constraint(equalTo: view.topAnchor).isActive = true
            //        statusbarView.centerXAnchor
            //          .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            UIApplication.shared.statusBarView?.backgroundColor = statusViewColor
        }
    }
    
}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = .mainBlue
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            UIApplication.shared.statusBarView?.backgroundColor = .mainBlue
        }
    }
    
}
