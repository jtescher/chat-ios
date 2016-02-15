//
//  ChannelViewController.swift
//  AwesomeChat
//
//  Created by Julian Tescher on 2/14/16.
//  Copyright © 2016 Botchi. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: Properties
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var messagesTableView: UITableView!
    var channel: Channel?
    let messages = [
        Message(body: "Message 1", channelName: "startups", createdTime: "2016.02.14 07:26:34"),
        Message(body: "Message 2", channelName: "startups", createdTime: "2016.02.14 07:27:23"),
        Message(body: "Message 3", channelName: "startups", createdTime: "2016.02.14 07:27:23"),
        Message(body: "Message 4", channelName: "startups", createdTime: "2016.02.14 07:27:23")
    ]
    let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!)
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        
        let channelName = channel!.name
        navigation.title = channelName.capitalizedString
        
        addHandlers(channelName)
        socket.connect()
    }
    
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ChannelMessageCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let channel = messages[indexPath.row]
        cell.textLabel!.text = channel.body
        
        return cell
    }
    
    
    // MARK: - Socket.io event handlers
    func addHandlers(channelName: String) {
//        socket.onAny {print("Got event: \($0.event), with items: \($0.items)")}
        
        // First join channel and get history
        socket.on("connect") { data, ack in
            self.socket.emit("join_channel", channelName)
            self.socket.emit("get_channel_history", channelName)
        }
        
        // Populate old chat history
        socket.on("chat_history") { data, ack in
//            print("Got data: \(data)")
        }
    }
    
}
