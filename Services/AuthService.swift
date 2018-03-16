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
                print("Inside Register")
                completion(true)
            }else{
                completion(false)
                //debugPrint(response.result.error as? Any)
            }
        }
    }
    func loginUser(email : String, password : String, completion : @escaping CompletionHandler){
        let lowercasedemail = email.lowercased()
        let body : [String: Any] = ["email":lowercasedemail,"password":password]
        Alamofire.request(Login_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil{
                print("Inside login")
                //SwiftyJSON
                guard let data = response.data else { return }
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                completion(true)
            }else{
                completion(false)
               // debugPrint(response.result.error as? Any)
            }
        }
    }
    func createUser(name : String, email : String, avatarName : String, avatarColor : String, completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        //let body : [String: Any] = ["name":name,"email":lowercaseEmail,"avatarName":avatarName,"avatarColor":avatarColor]
        Alamofire.request(Add_User_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                print("Inside createuser")
                guard let data = response.data else {return}
                self.setUserData(data: data)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    func getUserDetails(completion: @escaping CompletionHandler){
        print("the user data is \(USER_DATA_URL)\(userEmail)")
        Alamofire.request("\(USER_DATA_URL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            print("the user data inside is",response)
            if response.result.error == nil{
                guard let data = response.data else {return}
                self.setUserData(data: data)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    func setUserData(data: Data){
        let json = JSON(data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        UserService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
    
}
