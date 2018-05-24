//
//  ChatViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var channelName: UILabel!
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
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.dataChanged(_:)), name: NOTIFY_DATA_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(_:)), name: NOTIFY_CHANNEL_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.getUserDetails(completion: { (success) in
                NotificationCenter.default.post(name: NOTIFY_DATA_CHANGE, object: nil)
            })
        }
        MessageService.instance.getChannels { (success) in
            
        }
    }
    @objc func dataChanged(_ notif : Notification)  {
        if AuthService.instance.isLoggedIn{
            onLoginGetMessage()
        }else{
            channelName.text = "Please Login"
        }
    }
    
    @objc func channelSelected(_ notif : Notification)  {
       updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelNm = MessageService.instance.selectedChannel?.channelName ?? ""
        channelName.text = "#\(channelNm)"
    }
    
    func onLoginGetMessage(){
        MessageService.instance.getChannels { (success) in
            if success{
                //Do stuff with channels
            }
        }
    }

}
