//
//  SocketService.swift
//  SmackApp
//
//  Created by Teja PV on 3/27/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance  = SocketService()
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    lazy var socket:SocketIOClient = manager.defaultSocket
    override init() {
        super.init()
    }
    func establishConnection(){
        socket.connect()
    }
    func closeConnection(){
        socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    func getChannels(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            let newChannel = Channel(channelName: channelName, channelDescription: channelDescription, channelId: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
}
