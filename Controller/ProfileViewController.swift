//
//  ProfileViewController.swift
//  SmackApp
//
//  Created by Teja PV on 3/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.closeTap(_:)))
        backgroundView.addGestureRecognizer(tap)
    }
    @objc func closeTap(_ recognizer : UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    func setUpView(){
        userName.text = UserService.instance.name
        userEmail.text = UserService.instance.email
        profileImg.image = UIImage(named: UserService.instance.avatarName)
        profileImg.backgroundColor = UserService.instance.getUserColor(components: UserService.instance.avatarColor)
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserService.instance.logOutUser()
        NotificationCenter.default.post(name: NOTIFY_DATA_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}
