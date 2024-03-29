//
//  AppDelegate.swift
//  iOSExercise
//
//  Created by Allan Santos on 14/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        firstLaunch()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        _ = BaseRepository.shared.saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "iOSExercise")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    fileprivate func simulatedUsers(_ baseRepository: BaseRepository) {
        let user = User(context: baseRepository.context)
        user.name = "Batman"
        user.picture = "batman_hero"
        user.messages = Set<Message>()
        
        _ = baseRepository.saveUser(user)
        
        let grandman = User(context: baseRepository.context)
        grandman.name = "Grandma"
        grandman.picture = "grandma_elderly_nanny"
        grandman.messages = Set<Message>()
        
        _ = baseRepository.saveUser(grandman)
        
        let muslim = User(context: baseRepository.context)
        muslim.name = "Adilah"
        muslim.picture = "muslim_woman"
        muslim.messages = Set<Message>()
        
        _ = baseRepository.saveUser(muslim)
        
        let indian = User(context: baseRepository.context)
        indian.name = "Grandman"
        indian.picture = "indian_woman_hindi"
        indian.messages = Set<Message>()
        
        _ = baseRepository.saveUser(indian)
        
        let pilot = User(context: baseRepository.context)
        pilot.name = "Pilot"
        pilot.picture = "pilot_traveller"
        pilot.messages = Set<Message>()
        
        _ = baseRepository.saveUser(pilot)
    }
    
    fileprivate func firstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let baseRepository = BaseRepository.shared
            simulatedUsers(baseRepository)
        }
    }

}

