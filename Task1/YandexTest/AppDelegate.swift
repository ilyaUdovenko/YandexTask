//
//  AppDelegate.swift
//  YandexTest
//
//  Created by Ilya Udovenko on 19/05/2019.
//  Copyright © 2019 Ilya Udovenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    let beautifulCardVC = BeautifulCardViewController()
    let root = ViewController(beautifulCardViewController: beautifulCardVC)
    root.add(beautifulCardVC)
    window?.rootViewController = UINavigationController(rootViewController: root)
    return true
  }
}

