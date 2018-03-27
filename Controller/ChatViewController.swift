//
//  ChatViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //AuthService.instance.isLoggedIn = false
        if !AuthService.instance.isLoggedIn{
            AuthService.instance.authToken = ""
            AuthService.instance.userEmail = ""
        }
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        if AuthService.instance.isLoggedIn {
            AuthService.instance.getUserDetails(completion: { (success) in
                NotificationCenter.default.post(name: NOTIFY_DATA_CHANGE, object: nil)
            })
        }
        MessageService.instance.getChannels { (success) in
            
        }
    }

}
