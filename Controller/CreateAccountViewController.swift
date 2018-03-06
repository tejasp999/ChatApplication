//
//  CreateAccountViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/24/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    
    //
    var avatarName = "profileDefault"
    var avatarColor = "[0.4,0.4,0.4,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = userNameField.text, userNameField.text != "" else {return}
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let password = passwordField.text, passwordField.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success{
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                print(UserService.instance.name,UserService.instance.avatarName)
                                self.performSegue(withIdentifier: UN_WIND, sender: nil)
                            }
                        })
                    }
                })
                print("New user registered")
            }
        }
        
    }
    
    @IBAction func chooseAvatar(_ sender: Any) {
    }
    
    
    @IBAction func generateBGColor(_ sender: Any) {
        
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UN_WIND, sender: nil)
    }
}
