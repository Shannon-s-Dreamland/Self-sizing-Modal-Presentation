//
//  ChatMessageTemplatesViewController.swift
//  TestTableViewCustomHeight
//
//  Created by Shannon Wu on 1/15/16.
//  Copyright © 2016 Shannon's Dreamland. All rights reserved.
//

import UIKit

class ChatMessageTemplatesCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
}

class ChatMessageTemplatesTableView: UITableView {
    override func intrinsicContentSize() -> CGSize {
        layoutSubviews()
        
        let width = min(UIScreen.mainScreen().bounds.width * 4 / 5, contentSize.width)
        let height = min(UIScreen.mainScreen().bounds.height * 4 / 5, contentSize.height)
        return CGSize(width: width, height: height)
    }
}

class ChatMessageTemplatesViewController: UITableViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        modalPresentationStyle = .Custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView()
    }
    
    var messages = [String]()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ChatMessageTemplatesCell
        cell.messageLabel.text = NSLocalizedString(messages[indexPath.row], comment: "")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(messages[indexPath.row])
    }

}

extension ChatMessageTemplatesViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ChatMessageTemplatesPresentationAnimator()
        animator.isPresentation = true
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ChatMessageTemplatesPresentationAnimator()
        animator.isPresentation = false
        return animator
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return ChatMessageTemplatesPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}
