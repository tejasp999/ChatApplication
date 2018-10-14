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
    var messages = [Message]()
    var unreadChannels = [String]()
    var selectedChannel : Channel?
    func getChannels(completion : @escaping CompletionHandler){
        Alamofire.request(Get_Channels_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            if response.result.error == nil{
                self.clearChannels()
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
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func findAllMessagesForChannel(channelID : String, completion : @escaping CompletionHandler){
        Alamofire.request("\(Get_Messages_URL)\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            if response.result.error == nil{
                self.clearMessages()
                guard let data = response.data else {return}
                if let json = try? JSON(data: data).array{
                    print("Inside the message retrieval")
                    for item in json!{
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    print(self.messages)
                    completion(true)
                }
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
}
