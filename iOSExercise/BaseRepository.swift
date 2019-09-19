//
//  BaseRepository.swift
//  iOSExercise
//
//  Created by Allan Santos on 15/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit
import CoreData

class BaseRepository {

    static let shared = BaseRepository()
    
    let persistentContainer = NSPersistentContainer(name: "ChatDataModel")
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    private init() {
        initalizeStack()
    }
    
    func initalizeStack() {
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Could not load store \(error.localizedDescription)")
            }
        }
    }
    
    func saveUser(_ user: User) -> Bool {
        do {
            context.insert(user)
            try context.save()
        } catch {
            return false
        }
        return true
    }
    
    func fechtUser(_ user: User) -> User {
        do {
            let request = NSFetchRequest<User>(entityName: "User")
            request.predicate = NSPredicate(format: "name == %@", user.name)
            let fechtUser = try self.context.fetch(request)[0]
            return fechtUser
        } catch {
            fatalError(" fechtUser - Error to fetch the user ")
        }
    }
    
    func fechtUsers() -> [User] {
        do {
            return try context.fetch(User.fetchRequest() as NSFetchRequest<User>)
        } catch {
            return []
        }
    }
    
    func deleteAll() -> Bool {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(request)
        } catch {
            return false
        }
        return true
    }
    
    func saveData() -> Bool {
        do {
            try context.save()
        } catch {
            return false
        }
        return true
    }
    
    func retriveMessages(_ user: User) -> [Message] {
        let request = NSFetchRequest<Message>(entityName: "Message")
        request.predicate = NSPredicate(format: "user.name == %@", user.name)
        
        do {
            var messages = try context.fetch(request)
            
            messages.sort {
                $0.date.compare($1.date as Date) == .orderedAscending
            }
            
            return messages
        } catch {
            return []
        }
    }
    
    func getRandomQuote() -> String {
        let quotes = [
            "Hi",
            "Hello",
            "How are you?",
            "Thank you!",
            "Welcome",
            "c'est la vie",
            "Why do we fall? So that we can learn to pick ourselves back up. - Batman",
            "You either die a hero, or live long enough to see yourself become a villain. - Batman",
            "If you’re good at something, never do it for free. -The Joker",
            "Your anger gives you great power. But if you let it, it will destroy you… - Batman",
            "The best thing about a boolean is even if you are wrong, you are only off by a bit. - Anonymous",
            "In order to understand recursion, one must first understand recursion. - Anonymous",
            "Don’t worry if it doesn’t work right. If everything did, you’d be out of a job. - Mosher’s Law of Software Engineering"
        ]
        
        return quotes[Int.random(in: 0...quotes.count-1)]
    }
    
}

