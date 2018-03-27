//
//  ChannelViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet weak var userImage: RoundedImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.dataChanged(_:)), name: NOTIFY_DATA_CHANGE, object: nil)
        MessageService.instance.getChannels { (success) in
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
    }
    
    func setUpUserInfo(){
        //let savedScore = AuthService.instance.isLoggedIn ?? false
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserService.instance.avatarName)
            userImage.backgroundColor = UserService.instance.getUserColor(components: UserService.instance.avatarColor)
        } else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
    
    @objc func dataChanged(_ notif : Notification)  {
       setUpUserInfo()
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profileVC  = ProfileViewController()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }else{
            AuthService.instance.isLoggedIn = false
            performSegue(withIdentifier: "loginController", sender: nil)
        }
    }
}
