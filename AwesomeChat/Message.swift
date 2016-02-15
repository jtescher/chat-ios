//
//  Message.swift
//  AwesomeChat
//
//  Created by Julian Tescher on 2/14/16.
//  Copyright © 2016 Botchi. All rights reserved.
//

import UIKit

class Message {
    
    // MARK: Proprties
    var body: String
    var channelName: String
    var createdTime: String
    
    // MARK: Initialization
    init(body: String, channelName: String, createdTime: String) {
        self.body = body
        self.channelName = channelName
        self.createdTime = createdTime
    }
    
}
