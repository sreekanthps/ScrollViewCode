//
//  AppDelegate.swift
//  ScrollViewCode
//
//  Created by sreekanth Pulicherla on 27/10/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



        var window: UIWindow?
        var navigationController: UINavigationController?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            self.setupHomeViewController(launchOptions)
            return true
        }
        
        // MARK: Setup Splash Scereen
        private func setupHomeViewController(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                if let window = window {
                    let mainVC =  CreateAccountViewController()//PinnedScrollViewControllerNew()// PinnedScrollViewController()//UpdateUserDetails()//StickyFooterFormViewController() //UpdateUserDetails() //UpdateUserDetails() //ExampleViewController() //
                    navigationController = UINavigationController(rootViewController: mainVC)
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
        }

    


}

