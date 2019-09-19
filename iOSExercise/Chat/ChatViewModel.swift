//
//  ChatViewModel.swift
//  iOSExercise
//
//  Created by Allan Santos on 15/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class ChatViewModel: BaseChatViewModel {

    var repository: BaseRepository!
    var user: User! {
        didSet {
            getMessages()
        }
    }
    
    var sections = [MessageSection]()
    var recentIncommingMsg: Message?
    var recentMsg: Message?
    
    override init() {
        super.init()
        self.repository = BaseRepository.shared
    }
    
    func enableTail(msg: Message) -> Bool {
        let date = msg.date as Date
        
        if msg.isIncoming {
            return validateRecentMsg(recentIncommingMsg?.date, date: date)
        }
        
        return validateRecentMsg(recentMsg?.date, date: date)
    }
    
    func addNewMessage(_ text: String, _ incoming: Bool = false) -> Bool {
        let message = Message(context: repository.context)
        message.text = text
        message.date = NSDate()
        message.isIncoming = incoming
        message.isRead = false
        let count = user.messages.count
        message.user = user
        message.tail = enableTail(msg: message)
        if count == user.messages.count { return false }
        createSectionableMessage(user.getMessageArray())
        return true
    }
    
    func getLastIndexPath() -> IndexPath {
        let section = sections.count - 1
        let row = sections[section].messages.count - 1
        return IndexPath(row: row, section: section)
    }
    
    func getLastMessage() -> Message {
        let section = sections.count - 1
        let row = sections[section].messages.count - 1
        return sections[section].messages[row]
    }
    
    func getMessages() {
        let messages = repository.retriveMessages(user)
        createSectionableMessage(messages)
    }
    
    fileprivate func createSectionableMessage(_ messages: [Message]) {
        sections.removeAll()
        let groups = Dictionary(grouping: messages) {
            $0.date as Date
            }.sorted { $0.key.compare($1.key) == .orderedAscending }
        
        var tempDate: Date?
        var index: Int = 0
        
        for (keyDate, values) in groups {
            if tempDate == nil || keyDate.isMoreThanAnHour(date: tempDate!) {
                tempDate = keyDate
                sections.append(MessageSection(date: keyDate, messages: values))
                index = sections.count - 1
            } else  {
                sections[index].messages.append(contentsOf: values)
                tempDate = keyDate
            }
        }
        setRecentsMsgs(messages)
    }
    
    fileprivate func setRecentsMsgs(_ messages: [Message]) {
        if messages.isEmpty { return }
        
        let incommingMsgs = messages.filter({ $0.isIncoming && $0.tail }).sorted { $0.date.compare($1.date as Date) == .orderedAscending }
        let msgs = messages.filter({ !$0.isIncoming && $0.tail }).sorted { $0.date.compare($1.date as Date) == .orderedAscending }
        
        recentIncommingMsg = incommingMsgs.last
        recentMsg = msgs.last
    }
    
    fileprivate func validateRecentMsg(_ tailedDate: NSDate?, date: Date) -> Bool {
        guard let tailedDate = tailedDate else { return true }
        
        return date.isMoreThan20Seconds(date: tailedDate as Date)
    }
}
