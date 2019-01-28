//
//  AppDelegate.swift
//  Wifi
//
//  Created by Sam Greenhill on 1/12/19.
//  Copyright © 2019 simplyAmazingMachines. All rights reserved.
//

import UIKit
import UserNotifications
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalNever)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("Granted: \(granted)")
        }
        application.beginBackgroundTask(withName: "showNotification", expirationHandler: nil)
        
        return true
    }
    
//    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        let reachability = Reachability()
//        reachability?.whenReachable = { reachability in
//            if reachability.connection == .wifi {
//                print("WIFI")
//            } else {
//                print("Cellular")
//            }
//        }
//        reachability?.whenUnreachable = { _ in
//            print("Not Reachable")
//        }
//        do {
//            try reachability?.startNotifier()
//        } catch {
//            print("Unable to start notifier")
//        }
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

        print("One")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        let reachability = Reachability()
//        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: Notification.Name.reachabilityChanged, object: reachability)
//        do {
//            try reachability?.startNotifier()
//        } catch {
//            print("Could not start reachability notifier")
//        }
        print("Two")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

        print("Three")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        print("Four")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

        print("Five")
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachability via Wifi")
            notificationData(bodyStr: "Wifi is turned on")
        case .cellular:
            print("Reachability via Cellular")
            notificationData(bodyStr: "Switching to Cellular Data")
        case .none:
            print("Network not reachable")
            notificationData(bodyStr: "There is no Connection")
        default:
            print("Default")
        }
    }
    
    
    func notificationData(bodyStr: String) {
        let content = UNMutableNotificationContent()
        content.title = "Change in Connection"
        content.body = bodyStr
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "category"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        let action = UNNotificationAction(identifier: "ok", title: "Ok", options: .foreground)
        let category = UNNotificationCategory(identifier: "category", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    

}

