//
//  MessageSection.swift
//  iOSExercise
//
//  Created by Allan Santos on 16/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//
import Foundation

struct MessageSection {

    var date: Date
    var messages: [Message]
    
    init(date: Date, messages: [Message]) {
        self.date = date
        self.messages = messages
    }
}
