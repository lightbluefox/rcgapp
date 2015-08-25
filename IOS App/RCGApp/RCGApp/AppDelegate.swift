//
//  AppDelegate.swift
//  RCGApp
//
//  Created by iFoxxy on 12.05.15.
//  Copyright (c) 2015 LightBlueFox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true);
        
        var itemsReceiver = NewsAndVacanciesReceiver()
        //itemsReceiver.getAllNews();
        //itemsReceiver.getAllVacancies();
        var newsStack = itemsReceiver.newsStack;
        var vacStack = itemsReceiver.vacStack
        
        
        let navBarFont = UIFont(name: "Roboto-Regular", size: 17.0) ?? UIFont.systemFontOfSize(17.0);
        
        var navBar = UINavigationBar.appearance();
        var tabBar = UITabBar.appearance();
           
        UITabBar.appearance().backgroundImage = UIImage(named: "selectedItemImage");

        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) //Для iOS 7 и старше
        {
            navBar.barTintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
            tabBar.barTintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
        }
        else //ниже iOS 7
        {
            navBar.tintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
            tabBar.tintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
        }
        //Стиль заголовка
        navBar.titleTextAttributes = [NSFontAttributeName: navBarFont, NSForegroundColorAttributeName: UIColor.whiteColor()];
        tabBar.tintColor = UIColor.whiteColor();
        tabBar.selectionIndicatorImage = UIImage(named: "selectedItemImage");
        
        
        //Mark: Регистрация на пуш-уведомления
        //IOS 7 -
        UIApplication.sharedApplication().registerForRemoteNotificationTypes(UIRemoteNotificationType.Alert | UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound);
        //IOS 8 +
        //UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationType.Sound | UIUserNotificationType.Badge | UIUserNotificationType.Alert);
        //UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings: UIUserNotificationSettings.Sound | UIUserNotificationType.Badge | UIUserNotificationType.Alert)
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

