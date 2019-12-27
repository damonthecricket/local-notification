//
//  MainViewController.swift
//  LocalNotification
//
//  Created by Damon Cricket on 27.12.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController {
    
    @IBOutlet weak var scheduleButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleButton?.layer.cornerRadius = 10.0
        scheduleButton?.layer.borderWidth = 5.0
        scheduleButton?.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func scheduleButtonTap(sender: UIButton) {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {allow, error in
            if !allow {
                print("Uesr has declined notification")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Notification title."
        content.body = "Notification body."
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let date = Date(timeIntervalSinceNow: 60)
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Local Notification", content: content, trigger: trigger)

        notificationCenter.add(request) {error in
            if let error = error {
                print("Error \(error)")
            }
        }
    }
}
