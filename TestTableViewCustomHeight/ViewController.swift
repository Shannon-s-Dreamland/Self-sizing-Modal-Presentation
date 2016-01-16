//
//  ViewController.swift
//  TestTableViewCustomHeight
//
//  Created by Shannon Wu on 1/15/16.
//  Copyright © 2016 Shannon's Dreamland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var messagesCountStepper: UIStepper!
    
    @IBOutlet weak var messagesCountLabel: UILabel!
    @IBAction func changeMessagesCount(sender: UIStepper) {
        messagesCountLabel.text = "\(Int(sender.value))"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? ChatMessageTemplatesViewController {
            var messages: [String] = []
            for _ in 0..<Int(messagesCountStepper.value) {
                messages.append(String.arbitrary())
            }
            des.messages = messages
        }
    }
}

