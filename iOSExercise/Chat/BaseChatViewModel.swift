//
//  BaseChatViewModel.swift
//  iOSExercise
//
//  Created by Allan Santos on 17/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class BaseChatViewModel {
    
    func checkEmoji(_ messageLabel: UILabel, _ bubbleImageView: UIImageView) {
        guard let text = messageLabel.text, text.isOnlyEmoji else {
            messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            bubbleImageView.isHidden = false
            bubbleImageView.constraints.forEach { $0.isActive = true }
            return
        }
        
        bubbleImageView.isHidden = true
        bubbleImageView.constraints.forEach { $0.isActive = false }
        messageLabel.font = UIFont.systemFont(ofSize: 35)
        
    }
    
    func setupBubbleImageWithTail(_ bubbleImageView: UIImageView, _ isIncoming: Bool) {
        let tintColor: UIColor = isIncoming ? UIColor.black.withAlphaComponent(0.1) : #colorLiteral(red: 0.9789841771, green: 0.2498675287, blue: 0.4189934731, alpha: 1)
        let image: UIImage = isIncoming ? #imageLiteral(resourceName: "bubble-received") : #imageLiteral(resourceName: "bubble-send")
        bubbleImageView.image = image.resizableBubbleImage()
        bubbleImageView.layer.masksToBounds = false
        bubbleImageView.layer.cornerRadius = 0
        bubbleImageView.backgroundColor = .clear
        bubbleImageView.tintColor = tintColor
    }
    
    func setupBubbleImage(_ bubbleImageView: UIImageView, _ isIncoming: Bool) {
        let tintColor: UIColor = isIncoming ? UIColor.black.withAlphaComponent(0.1) : #colorLiteral(red: 0.9789841771, green: 0.2498675287, blue: 0.4189934731, alpha: 1)
        bubbleImageView.layer.cornerRadius = 0.3 * bubbleImageView.frame.height
        bubbleImageView.layer.masksToBounds = true
        bubbleImageView.image = nil
        bubbleImageView.backgroundColor = tintColor
    }

}
