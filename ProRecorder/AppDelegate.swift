//
//  AppDelegate.swift
//  ProRecorder
//
//  Created by Nikolay Pochekuev on 14.01.2020.
//  Copyright © 2020 Nikolay Pochekuev. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          
           print(Realm.Configuration.defaultConfiguration.fileURL)
          
          do {
              let realm = try Realm()
          } catch {
              print("Error initialising new realm, \(error)")
          }

          return true
      }


}

