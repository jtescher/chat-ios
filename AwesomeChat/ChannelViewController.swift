//
//  ChannelViewController.swift
//  AwesomeChat
//
//  Created by Julian Tescher on 2/14/16.
//  Copyright © 2016 Botchi. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    
    
    // MARK: Properties
    @IBOutlet weak var navigation: UINavigationItem!
    var channel: Channel?
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigation.title = channel?.name
    }
    
}
