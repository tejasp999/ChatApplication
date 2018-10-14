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
    func getUserColor(components : String) -> UIColor{
        let scanner = Scanner(string : components)
        let skip = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skip
        var r, g, b, a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        let defaultColor = UIColor.lightGray
        guard let rUnWrapped = r else {return defaultColor}
        guard let gUnWrapped = g else {return defaultColor}
        guard let bUnWrapped = b else {return defaultColor}
        guard let aUnWrapped = a else {return defaultColor}
        let rFloat = CGFloat(rUnWrapped.doubleValue)
        let gFloat = CGFloat(gUnWrapped.doubleValue)
        let bFloat = CGFloat(bUnWrapped.doubleValue)
        let aFloat = CGFloat(aUnWrapped.doubleValue)
        let color = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        return color
    }
    func logOutUser(){
        self.id = ""
        self.avatarColor = ""
        self.avatarName = ""
        self.email = ""
        self.name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
}
