//
//  UserTableViewCell.swift
//  iOSExercise
//
//  Created by Allan Santos on 15/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let cellId = "userCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    func configure(user: User) {
        setupPictureImage()
        
        nameLabel.text = user.name
        guard let picture = user.picture else {
            pictureImageView.image = #imageLiteral(resourceName: "batman_hero")
            return
        }
        pictureImageView.image = UIImage(named: picture)
    }
    
    fileprivate func setupPictureImage() {
        pictureImageView.layer.cornerRadius = pictureImageView.frame.height/2
        pictureImageView.layer.masksToBounds = true
    }

}
