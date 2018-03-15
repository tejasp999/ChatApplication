//
//  RoundedImage.swift
//  SmackApp
//
//  Created by Teja PV on 3/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImage: UIImageView {
    override func awakeFromNib() {
        setUpView()
    }
    func setUpView(){
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
}
