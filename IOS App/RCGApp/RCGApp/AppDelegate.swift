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
        
        //Mark: Регистрация  на пуш-уведомления
        if floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1
        {
            //IOS 7.1 +
                if #available(iOS 8.0, *) {
                    UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Sound, UIUserNotificationType.Badge, UIUserNotificationType.Alert], categories: nil))
                } else {
                    // Fallback on earlier versions
                }
        }
        else
        {
            //IOS 7.1 -
            UIApplication.sharedApplication().registerForRemoteNotificationTypes([UIRemoteNotificationType.Alert, UIRemoteNotificationType.Badge, UIRemoteNotificationType.Sound]);
        }
        
        
        // Override point for customization after application launch.
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true);
        
        //let itemsReceiver = NewsAndVacanciesReceiver()
        //_ = itemsReceiver.newsStack;
        //_ = itemsReceiver.vacStack
        
        
        let navBarFont = UIFont(name: "Roboto-Regular", size: 17.0) ?? UIFont.systemFontOfSize(17.0);
        
        let navBar = UINavigationBar.appearance();
        let tabBar = UITabBar.appearance();
        

        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) //Для iOS 7 и старше
        {
            navBar.barTintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
            tabBar.barTintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
            tabBar.tintColor = UIColor.whiteColor();
            
        }
        else //ниже iOS 7
        {
            navBar.tintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
            tabBar.tintColor = UIColor(red: 194/255, green: 0, blue: 18/255, alpha: 1.0);
        }
        //Стиль заголовка
        navBar.titleTextAttributes = [NSFontAttributeName: navBarFont, NSForegroundColorAttributeName: UIColor.whiteColor()];
        
        //Чтобы избавиться от стандартного выделения выбранного таба, используем такой костыль.
        tabBar.selectionIndicatorImage = UIImage(named: "selectedItemImage");
        
        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("My token is: \(deviceToken)")
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for var i = 0; i < deviceToken.length; i++ {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        if #available(iOS 8.0, *) {
            let request = HTTPTask()
            let requestUrl = "http://agency.cloudapp.net/devices"
            let params: Dictionary<String,AnyObject> = ["token":tokenString];
            
            request.PUT(requestUrl, parameters: params, completionHandler: {(response: HTTPResponse) in
                if let err = response.error {
                    print("error: " + err.localizedDescription)
                }
                else if let _: AnyObject = response.responseObject {
                    print(response.statusCode)
                }
            })
        } else {
            // Fallback on earlier versions
        };
        
    }
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register for notifications: \(error.localizedDescription)")
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

