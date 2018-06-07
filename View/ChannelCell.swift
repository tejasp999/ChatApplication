//
//  ChannelCell.swift
//  SmackApp
//
//  Created by Teja PV on 3/27/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    func configureCell(channel: Channel){
        let title = channel.channelName
        channelName.text = "#\(String(describing: title))"
        channelName.font = UIFont(name: "Avenir", size: 17)
        for id in MessageService.instance.unreadChannels{
            if id = channel.channelId{
                channelName.font = UIFont(name: "Avenir-Heavy", size: 22)
            }
        }
    }

}
