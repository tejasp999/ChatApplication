//
//  Constants.swift
//  SmackApp
//
//  Created by Teja PV on 2/24/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success : Bool) -> ()
let BASE_URL = "https://chatappslack.herokuapp.com/v1/"
let Register_URL = "\(BASE_URL)account/register"
let Login_URL = "\(BASE_URL)account/login"
let Add_User_URL = "\(BASE_URL)user/add"
let USER_DATA_URL = "\(BASE_URL)/user/byEmail/"
let Get_Channels_URL = "\(BASE_URL)channel/"
let Get_Messages_URL = "\(BASE_URL)message/byChannel"


let AVATAR_PICKER = "avatarPicker"

//Colors
let placeHolderColor = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 1)

//Notifications
let NOTIFY_DATA_CHANGE = Notification.Name("notifyUserDataChanged")
let NOTIFY_CHANNELS_LOADED = Notification.Name("notifyChannelsLoaded")
let NOTIFY_CHANNEL_SELECTED = Notification.Name("notifyChannelSelected")

//Segue Keys
let CREATE_ACCOUNT = "createAccount"
let UN_WIND = "unwindToChannelVC"

//User Defaults Keys
let LOGGED_IN = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"
//Headers
let HEADER = ["Content-Type":"application/json; charset = utf-8"]
let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
