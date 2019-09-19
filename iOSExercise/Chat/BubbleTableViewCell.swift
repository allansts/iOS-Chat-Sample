//
//  BubbleTableViewCell.swift
//  iOSExercise
//
//  Created by Allan Santos on 14/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class BubbleTableViewCell: UITableViewCell {
    
    static let cellId = "bubble"
    static let nibName = "BubbleTableViewCell"
    
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var bubbleImgTrailing: NSLayoutConstraint!
    @IBOutlet weak var bubbleImgLeading: NSLayoutConstraint!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTrailing: NSLayoutConstraint!
    @IBOutlet weak var messageLeading: NSLayoutConstraint!
    
    @IBOutlet weak var readLabel: UILabel!
    
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    
    fileprivate var viewModel: BubbleCellModelView! {
        didSet {
            messageLabel.text = viewModel.message.text
            messageLabel.textColor = viewModel.message.isIncoming ? .black : .white
        }
    }
    
    func bindViewModel(_ viewModel: BubbleCellModelView) {
        self.viewModel = viewModel
    
        viewModel.checkEmoji(messageLabel, bubbleImageView)
        let isIncoming = viewModel.message.isIncoming
        setupBubbleMessagePosition(isIncoming)
        
        if viewModel.message.tail {
            viewModel.setupBubbleImageWithTail(bubbleImageView, isIncoming)
        } else {
            viewModel.setupBubbleImage(bubbleImageView, isIncoming)
        }
        
        setMessageConstraint(isIncoming, isIncoming)
        setBubbleConstraint(isIncoming, isIncoming)
    }
    
    fileprivate func setupBubbleMessagePosition(_ isIncoming: Bool) {
        if isIncoming {
            viewLeading.priority = UILayoutPriority.defaultHigh
            viewTrailing.priority = UILayoutPriority.defaultLow
        } else {
            viewLeading.priority = UILayoutPriority.defaultLow
            viewTrailing.priority = UILayoutPriority.defaultHigh
        }
    }
    
    fileprivate func setMessageConstraint(_ isIncoming: Bool, _ tailEnable: Bool) {
        if !tailEnable {
            messageLeading.constant = 10
            messageTrailing.constant = -10
            return
        }
        
        if isIncoming {
            messageLeading.constant = 15
            messageTrailing.constant = -10
        } else {
            messageLeading.constant = 10
            messageTrailing.constant = -15
        }
    }
    
    fileprivate func setBubbleConstraint(_ isIncoming: Bool, _ tailEnable: Bool) {
        if tailEnable {
            bubbleImgLeading.constant = 5
            bubbleImgTrailing.constant = 5
            return
        }
        
        if isIncoming {
            bubbleImgLeading.constant = 10
        } else {
            bubbleImgTrailing.constant = 10
        }
    }

}
