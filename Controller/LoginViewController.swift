//
//  LoginViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/15/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any){
        performSegue(withIdentifier: CREATE_ACCOUNT, sender: nil)
    }
    
    
}
