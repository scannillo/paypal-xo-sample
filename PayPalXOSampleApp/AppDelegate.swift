//
//  AppDelegate.swift
//  PayPalXOSampleApp
//
//  Created by Samantha Cannillo on 4/5/23.
//

import UIKit
import PayPalCheckout

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = CheckoutConfig(
            clientID: "AUiHPkr1LO7TzZH0Q5_aE8aGNmTiXZh6kKErYFrtXNYSDv13FrN2NElXabVV4fNrZol7LAaVb1gJj9lr",
            environment: .sandbox
        )

        Checkout.set(config: config)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

