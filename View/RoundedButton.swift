//
//  RoundedButton.swift
//  SmackApp
//
//  Created by Teja PV on 3/4/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 5.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {
        self.setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }
    func setUpView(){
        self.layer.cornerRadius = cornerRadius
    }

}
