//
//  BubbleCellModelView.swift
//  iOSExercise
//
//  Created by Allan Santos on 14/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import Foundation
import UIKit

class BubbleCellModelView: BaseChatViewModel {

    var message: Message!
    
    init(_ message: Message) {
        self.message = message
    }
    
}
