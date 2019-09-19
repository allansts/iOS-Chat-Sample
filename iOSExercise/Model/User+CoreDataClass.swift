//
//  User+CoreDataClass.swift
//  iOSExercise
//
//  Created by Allan Santos on 15/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

    func addMessages(_ message: Message) {
        messages.insert(message)
    }
    
    func getMessageArray() -> [Message] {
        return messages.sorted {
            $0.date.compare($1.date as Date) == .orderedAscending
        }
    }
}
