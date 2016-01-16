//
//  ChatMessageTemplatesPresentationController.swift
//  TestTableViewCustomHeight
//
//  Created by Shannon Wu on 1/15/16.
//  Copyright © 2016 Shannon's Dreamland. All rights reserved.
//

import UIKit

class ChatMessageTemplatesPresentationController: UIPresentationController {
    // MARK: Property
    let dimmingView = UIView()
    
    var presentedViewSize = CGSize.zero
    
    // MARK: Init
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        dimmingView.alpha = 0.0
        let tapGesture = UITapGestureRecognizer(target: self, action: "dimmingViewTapped:")
        dimmingView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Helper
    func dimmingViewTapped(gesture: UITapGestureRecognizer) {
        if  gesture.state == .Recognized {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: Presentation
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        dimmingView.frame = containerView.frame
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, atIndex: 0)
        if let transitionCoordinator = presentedViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition(
                { coordinatorContext in
                    self.dimmingView.alpha = 1.0
                },
                completion:
                { coordinatorContext -> Void in
            })
        } else {
            dimmingView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentedViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition(
                { coordinatorContext in
                    self.dimmingView.alpha = 0.0
                },
                completion:
                { coordinatorContext -> Void in
            })
        } else {
            dimmingView.alpha = 0.0
        }
    }
    
    override func adaptivePresentationStyle() -> UIModalPresentationStyle {
        return .OverFullScreen
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let presentedView = presentedView() {
            presentedViewSize = presentedView.intrinsicContentSize()
        } else {
            presentedViewSize = UIScreen.mainScreen().bounds.size
        }
        return presentedViewSize
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else { return }
        dimmingView.frame = containerView.bounds
        presentedView()?.frame = frameOfPresentedViewInContainerView()
    }
    
    override func shouldPresentInFullscreen() -> Bool {
        return false
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        var presentedViewFrame = CGRectZero
        presentedViewFrame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerView.bounds.size)
        presentedViewFrame.origin.x = (UIScreen.mainScreen().bounds.width - presentedViewFrame.size.width) / 2.0
        presentedViewFrame.origin.y = (UIScreen.mainScreen().bounds.height - presentedViewFrame.size.height) / 2.0

        
        return presentedViewFrame
    }
    
}
