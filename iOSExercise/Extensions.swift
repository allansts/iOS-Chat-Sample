//
//  Extensions.swift
//  iOSExercise
//
//  Created by Allan Santos on 14/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class Extensions {}

extension String {
    
    var isSingleEmoji: Bool {
        return self.count == 1 && containsEmoji
    }
    
    var isOnlyEmoji: Bool {
        return !isEmpty && !unicodeScalars.contains { !$0.isEmoji }
    }
    
    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }
}

extension UnicodeScalar {
    /// Note: This method is part of Swift 5, so you can omit this.
    /// See: https://developer.apple.com/documentation/swift/unicode/scalar
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        0x1F018...0x1F270, // Various asian characters
        0x238C...0x2454, // Misc items
        0x20D0...0x20FF: // Combining Diacritical Marks for Symbols
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}

extension UIImage {
    
    func resizableBubbleImage() -> UIImage {
        return self.resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                             resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
    }
    
}

extension UITableView {
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            
            if self.numberOfSections == 0 { return }
            
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension Date {
    
    func isMoreThanAnHour(date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.dateComponents([.hour], from: date, to: self).hour! >= 1
    }
    
    func isMoreThan20Seconds(date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.dateComponents([.second], from: date, to: self).second! >= 20
    }
    
    func isRecent(compareTo date: Date) -> Bool {
        return self.compare(date) == .orderedDescending || self.compare(date) == .orderedSame
    }
    
    func sectionDateFormat() -> NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let stringDate = NSAttributedString(string: dateFormatter.string(from: self), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .semibold)])
        
        let stringTime = NSAttributedString(string: " \(timeFormatter.string(from: self))", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .regular)])
        
        let mutable = NSMutableAttributedString()
        mutable.append(stringDate)
        mutable.append(stringTime)
        
        return mutable
    }
}
