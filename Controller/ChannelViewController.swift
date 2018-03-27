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
        SocketService.instance.getChannels { (success) in
            if success{
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
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
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
        let addChannelVC  = AddChannelViewController()
        addChannelVC.modalPresentationStyle = .custom
        present(addChannelVC, animated: true, completion: nil)
    }
}
