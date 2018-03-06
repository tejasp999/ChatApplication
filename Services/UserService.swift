//
//  UserService.swift
//  SmackApp
//
//  Created by Teja PV on 3/5/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class UserService{
    static let instance = UserService()
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    func setUserData(id : String, color : String, avatarName : String, email : String, name : String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    func setAvatarName(avatarName : String){
        self.avatarName = avatarName
    }
}
