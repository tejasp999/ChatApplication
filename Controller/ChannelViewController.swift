//
//  ChannelViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var userImage: RoundedImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTableView.delegate = self
        channelTableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.dataChanged(_:)), name: NOTIFY_DATA_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.channelsLoaded(_:)), name: NOTIFY_CHANNELS_LOADED, object: nil)
        SocketService.instance.getChannels { (success) in
            if success{
                self.channelTableView.reloadData()
            }
        }
        SocketService.instance.getChatMessages { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.channelId && AuthService.instance.isLoggedIn{
                    MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.channelTableView.reloadData()
            }
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
            self.channelTableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelData = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channelData
        if MessageService.instance.unreadChannels.count > 0{
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channelData.channelId}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        NotificationCenter.default.post(name: NOTIFY_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    @objc func dataChanged(_ notif : Notification)  {
       setUpUserInfo()
    }
    @objc func channelsLoaded(_ notif : Notification)  {
        channelTableView.reloadData()
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
    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let addChannelVC  = AddChannelViewController()
            addChannelVC.modalPresentationStyle = .custom
            present(addChannelVC, animated: true, completion: nil)
        }
        
    }
}
