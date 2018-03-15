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
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.dataChanged(notif:)), name: NOTIFY_DATA_CHANGE, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func dataChanged(notif : Notification)  {
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
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "loginController", sender: nil)
    }
}
