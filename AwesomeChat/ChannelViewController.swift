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
    @IBOutlet weak var bottomStackViewConstraint: NSLayoutConstraint!
    var channel: Channel?
    var messages = [Message]()
    let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!)
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Table view delegate / data source setup
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        
        // view setup
        let channelName = channel!.name
        navigation.title = channelName.capitalizedString
        
        // Keyboard view resizing setup
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        // Socket.IO setup
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
    
    // Mark: - Keyboard events
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.bottomStackViewConstraint.constant = keyboardFrame.size.height + 20
    }

    func keyboardWillHide(notification: NSNotification) {
        self.bottomStackViewConstraint.constant = 20
    }

    
    // MARK: - Socket.io event handlers
    func addHandlers(channelName: String) {
        
        // First join channel and get history
        socket.on("connect") { data, ack in
            self.socket.emit("join_channel", channelName)
            self.socket.emit("get_channel_history", channelName)
        }
        
        // Populate old chat history
        socket.on("chat_history") { data, ack in
            if let rawMessages = data[0] as? [NSDictionary] {
                self.messages += rawMessages.map({rawMessage in
                    Message(body: rawMessage["body"] as! String, channelName: rawMessage["channelName"] as! String, createdTime: rawMessage["createdTime"] as! String)
                })
                self.messagesTableView.reloadData()
            }
        }

    }


    // MARK: Actions
    @IBAction func viewDidTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
