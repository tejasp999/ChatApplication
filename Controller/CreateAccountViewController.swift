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
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    //
    var avatarName = "profileDefault"
    var avatarColor = "[0.4,0.4,0.4,1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated : Bool){
        if UserService.instance.avatarName != ""{
            profileImg.image = UIImage(named : UserService.instance.avatarName)
            avatarName = UserService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil{
                self.profileImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinnerView.isHidden = false
        spinnerView.startAnimating()
        guard let name = userNameField.text, userNameField.text != "" else {return}
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let password = passwordField.text, passwordField.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success{
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                self.spinnerView.isHidden = true
                                self.spinnerView.stopAnimating()
                                print(UserService.instance.name,UserService.instance.avatarName)
                                self.performSegue(withIdentifier: UN_WIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIFY_DATA_CHANGE, object: nil)
                            }
                        })
                    }
                })
                print("New user registered")
                
            }
        }
        
    }
    
    @IBAction func chooseAvatar(_ sender: Any) {
        performSegue(withIdentifier: AVATAR_PICKER, sender: nil)
    }
    
    
    @IBAction func generateBGColor(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        avatarColor = "[\(r),\(g),\(b), 1]"
        UIView.animate(withDuration: 0.2){
            self.profileImg.backgroundColor = self.bgColor
        }
        
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UN_WIND, sender: nil)
    }
    
    func setUpView(){
        spinnerView.isHidden = false
        userNameField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor:placeHolderColor])
        emailField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:placeHolderColor])
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:placeHolderColor])
        let tap = UIGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
}
