//
//  AppDelegate.swift
//  TheBackgrounder
//
//  Created by Ray Fix on 12/9/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: Any]?) -> Bool {

    UIApplication.shared.setMinimumBackgroundFetchInterval(
      UIApplicationBackgroundFetchIntervalMinimum)
    
    return true
  }
  
  // Support for background fetch
  func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    
    if let tabBarController = window?.rootViewController as? UITabBarController,
           let viewControllers = tabBarController.viewControllers
    {
      for viewController in viewControllers {
        if let fetchViewController = viewController as? FetchViewController {
          fetchViewController.fetch {
            fetchViewController.updateUI()
            completionHandler(.newData)
          }
        }
      }
    }
  }
}
