//
//  MessageCell.swift
//  SmackApp
//
//  Created by Teja PV on 5/23/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: RoundedImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageBdyLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message : Message){
        messageBdyLbl.text = message.message
        userNameLbl.text = message.userName
        userImage.image = UIImage (named: message.userAvatar)
        userImage.backgroundColor = UserService.instance.getUserColor(components: message.userAvatarColor)
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm:a"
        if let finaldate = chatDate{
            let finaldate = newFormatter.string(from: finaldate)
            timeStampLbl.text = finaldate
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
