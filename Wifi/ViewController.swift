//
//  ViewController.swift
//  Wifi
//
//  Created by Sam Greenhill on 1/12/19.
//  Copyright © 2019 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Reachability
import UserNotifications



class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    
    @IBOutlet weak var wifiLabel: UILabel!
    var testingBool: Bool = false
    let reachability = Reachability()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
    }

    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    
    func checkingConnection() {
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("WIFI")
            } else {
                print("Cellular")
            }
        }
        reachability?.whenUnreachable = { _ in
            print("Not Reachable")
        }
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachability via Wifi")
            self.wifiLabel.text = "WIFI"
            notificationData(bodyStr: "Wifi is turned on")
        case .cellular:
            print("Reachability via Cellular")
            self.wifiLabel.text = "Cellular"
            notificationData(bodyStr: "Switching to Cellular Data")
        case .none:
            print("Network not reachable")
            self.wifiLabel.text = "No Wifi"
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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        let action = UNNotificationAction(identifier: "ok", title: "Ok", options: .foreground)
        let category = UNNotificationCategory(identifier: "category", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
}

