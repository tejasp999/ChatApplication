//
//  MessageService.swift
//  SmackApp
//
//  Created by Teja PV on 3/26/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService {
    static let instance = MessageService()
    var channels = [Channel]()
    var selectedChannel : Channel?
    func getChannels(completion : @escaping CompletionHandler){
        Alamofire.request(Get_Channels_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else{ return }
                if let json = try? JSON(data: data).array{
                    for item in json!{
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelName: name, channelDescription: description, channelId: id)
                        self.channels.append(channel)
                    }
                    print("the channels are \(self.channels)")
                    completion(true)
                    NotificationCenter.default.post(name: NOTIFY_CHANNELS_LOADED, object: nil)
                }
                
            }else{
                completion(false)
            }
        }
    }
    
    func clearChannels(){
        channels.removeAll()
    }
}
