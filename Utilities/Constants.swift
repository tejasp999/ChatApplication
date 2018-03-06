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

let CREATE_ACCOUNT = "createAccount"
let UN_WIND = "unwindToChannelVC"

//User Defaults Keys
let LOGGED_IN = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"
//Headers
let HEADER = ["Content-Type":"application/json; charset = utf-8"]
