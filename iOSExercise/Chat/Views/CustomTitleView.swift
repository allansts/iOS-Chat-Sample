//
//  CustomTitleView.swift
//  iOSExercise
//
//  Created by Allan Santos on 17/09/19.
//  Copyright © 2019 Allan Santos. All rights reserved.
//

import UIKit

class CustomTitleView: UIView {
    
    let nibName = "CustomTitleView"

    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
