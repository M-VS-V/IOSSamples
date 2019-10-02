//
//  AppDelegate.swift
//  SafeAreaTargetContentOffset
//
//  Created by Vsevolod Mashinson on 02/10/2019.
//  Copyright © 2019 MVVM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = MainController()
        controller.modalPresentationStyle = .fullScreen
        window = UIWindow()
        print(UIScreen.main.bounds)
        window!.backgroundColor = UIColor.yellow
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        return true
    }

}

