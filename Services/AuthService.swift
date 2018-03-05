//
//  AuthService.swift
//  SmackApp
//
//  Created by Teja PV on 2/25/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    var isLoggedIn : Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN)
        }
    }
    var authToken : String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail : String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email : String, password : String, completion : @escaping CompletionHandler){
        let lowercasedemail = email.lowercased()
        
        let body : [String: Any] = ["email":lowercasedemail,"password":password]
        Alamofire.request(Register_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as? Any)
            }
        }
    }
    func loginUser(email : String, password : String, completion : @escaping CompletionHandler){
        let lowercasedemail = email.lowercased()
        let body : [String: Any] = ["email":lowercasedemail,"password":password]
        Alamofire.request(Login_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                //                if let json = response.result.value as? Dictionary<String,Any>{
                //                    if let email = json["user"] as? String{
                //                        self.userEmail = email
                //                    }
                //                    if let token = json["token"] as? String{
                //                        self.authToken = token
                //                    }
                //                }
                //                completion(true)
                //SwiftyJSON
                guard let data = response.data else { return }
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as? Any)
            }
        }
    }
    
}
