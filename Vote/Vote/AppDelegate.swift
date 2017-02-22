//
//  AppDelegate.swift
//  Vote
//
//  Created by C4Q on 2/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var starField: UIView?
    var coloredField: UIView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        StyleManager.styler.prettify()
        window?.backgroundColor = UIColor.hackathonCream
        
        if let window = self.window {
            print("!!!!!!!!!!")
            self.coloredField = UIView(frame: .zero)
            self.coloredField?.backgroundColor = UIColor.hackathonBlue
            self.starField = UIView(frame: .zero)
            self.starField?.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "star"))
            
            self.window?.addSubview(self.coloredField!)
            self.window?.bringSubview(toFront: self.coloredField!)
            self.window?.addSubview(self.starField!)
            self.window?.bringSubview(toFront: self.starField!)
            
            self.coloredField?.snp.makeConstraints{ (view) in
                view.size.equalToSuperview()
                view.bottom.top.leading.bottom.equalToSuperview()
            }
            
            self.starField?.snp.makeConstraints{ (view) in
                view.size.equalTo(coloredField!).multipliedBy(10)
                view.bottom.trailing.equalToSuperview()
            }
            
            if self.starField != nil {
                print(".......")
            }
            
            if self.coloredField != nil {
                print("??????????")
            }
            
            UIView.animate(withDuration: 4, animations: { 
                self.starField?.transform = CGAffineTransform(translationX: 375, y: 375)
                self.coloredField?.alpha = 0

            }, completion: { (bool) in
                
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let defaults = UserDefaults.standard
                if defaults.value(forKey: "walkthrough") as? Bool != true {
                    let pvc = storyboard.instantiateViewController(withIdentifier: "Introduction")
                    if let navVC = window.rootViewController as? UINavigationController {
                        navVC.pushViewController(pvc, animated: true)
                    }
                    
                } else if let zip = defaults.value(forKey: "zipcode") as? String {
                    let dvc = storyboard.instantiateViewController(withIdentifier: "rtvc") as! RepresentativeTableViewController
                    let delegate = storyboard.instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
                    dvc.getReps(from: zip)
                    dvc.delegate = delegate
                    if let navVC = window.rootViewController as? UINavigationController {
                        navVC.pushViewController(dvc, animated: true)
                    }

                }
            })
            
            UIView.animate(withDuration: 4, animations: {
//                self.coloredField?.alpha = 0
//                self.starField?.alpha = 0
            })
            
//            _ = [
//                self.coloredField,
//                self.starField
//                ].map { $0?.removeFromSuperview() }

        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
