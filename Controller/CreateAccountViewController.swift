//
//  CreateAccountViewController.swift
//  SmackApp
//
//  Created by Teja PV on 2/24/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UN_WIND, sender: nil)
    }
}
