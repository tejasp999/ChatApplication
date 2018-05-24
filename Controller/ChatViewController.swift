//
//  ChatViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var messagesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.estimatedRowHeight = 85
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        view.addGestureRecognizer(tap)
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
    
    @objc func handleTap(){
        //Keep in mind this fails some times
        view.endEditing(true)
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
        getMessages()
    }
    
    func onLoginGetMessage(){
        MessageService.instance.getChannels { (success) in
            if success{
                if MessageService.instance.channels.count > 0{
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.channelName.text = "No Channels Available"
                }
                //Do stuff with channels
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.channelId else {return}
        MessageService.instance.findAllMessagesForChannel(channelID: channelId) { (success) in
            if success{
                self.messagesTableView.reloadData()
            }
        }
    }

    @IBAction func sendMessage(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.selectedChannel?.channelId else {return}
            guard let message = messageTextField.text else {return}
            SocketService.instance.addMessage(messageBody: message, userId: UserService.instance.id, channelId: channelId) { (success) in
                if success{
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            cell.configureCell(message: MessageService.instance.messages[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
}
