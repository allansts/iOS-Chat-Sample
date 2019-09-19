//
//  Message+CoreDataProperties.swift
//  iOSExercise
//
//  Created by Allan Santos on 17/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: NSDate
    @NSManaged public var isIncoming: Bool
    @NSManaged public var isRead: Bool
    @NSManaged public var text: String
    @NSManaged public var tail: Bool
    @NSManaged public var user: User

}
