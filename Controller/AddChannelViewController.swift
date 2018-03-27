//
//  AddChannelViewController.swift
//  SmackApp
//
//  Created by Teja PV on 3/27/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }    
   
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameText.text, nameText.text != "" else { return }
        guard let channelDescription = descriptionText.text, descriptionText.text != "" else { return }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func setUpView(){
        let closeTouch = UITapGestureRecognizer(target: self, action:  #selector(AddChannelViewController.closeKeyBoard(_:)))
        bgView.addGestureRecognizer(closeTouch)
        nameText.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor : placeHolderColor])
        descriptionText.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor : placeHolderColor])
        
    }
    @objc func closeKeyBoard(_ recognizer : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

}
