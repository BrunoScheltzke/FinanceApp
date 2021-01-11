//
//  AppDelegate.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        setupNavBar()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.makeKeyAndVisible()
        let vc = StockListViewController(viewModel: StockListViewModel(provider: YFinanceAPIProvider()))
        let nav = BaseNavigationController(rootViewController: vc)
        window.rootViewController = nav
        return true
    }
    
    func setupNavBar() {
        UINavigationBar.appearance().backgroundColor = .appWhite
        UINavigationBar.appearance().barTintColor = .appWhite
        UINavigationBar.appearance().tintColor = .appWhite
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.font: Font.navLargeTitleFont(),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.appWhite]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: Font.navFont(),
                                                            NSAttributedString.Key.foregroundColor: UIColor.appWhite]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }

}
