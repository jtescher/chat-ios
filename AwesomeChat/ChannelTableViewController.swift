//
//  ChannelsTableViewController.swift
//  AwesomeChat
//
//  Created by Julian Tescher on 2/14/16.
//  Copyright © 2016 Botchi. All rights reserved.
//

import UIKit

class ChannelTableViewController: UITableViewController {
    
    
    // MARK: Properties
    let channels = [Channel(name: "Startups"), Channel(name: "Chatbots")]
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ChannelTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ChannelTableViewCell
        
        let channel = channels[indexPath.row]
        cell.nameLabel.text = channel.name
        
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChannelDetails" {
            let channelViewController = segue.destinationViewController as! ChannelViewController
            let channel = channels[self.tableView.indexPathForSelectedRow!.row]
            channelViewController.channel = channel
        }
    }
    
}
