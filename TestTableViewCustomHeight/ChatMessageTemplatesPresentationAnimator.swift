//
//  ChatMessageTemplatesPresentationAnimator.swift
//  TestTableViewCustomHeight
//
//  Created by Shannon Wu on 1/15/16.
//  Copyright © 2016 Shannon's Dreamland. All rights reserved.
//

import UIKit

class ChatMessageTemplatesPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromVC?.view
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else { return }
        let toView = toVC.view
        let containerView = transitionContext.containerView()
        
        if isPresentation {
            containerView?.addSubview(toView)
        }
        
        guard let animatingVC = (isPresentation ? toVC : fromVC) else { return }
        let animatingView = animatingVC.view
        
        let appearedFrame = transitionContext.finalFrameForViewController(animatingVC)
        let dismissedFrame = CGRectMake(UIScreen.mainScreen().bounds.width / 2.0, UIScreen.mainScreen().bounds.height / 2.0, 0, 0)
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame
        let finalFrame = isPresentation ? appearedFrame : dismissedFrame
        
        animatingView?.frame = initialFrame
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.AllowUserInteraction, animations:
            {
                animatingView?.frame = finalFrame
            })
            { finished in
                if !self.isPresentation {
                    fromView?.removeFromSuperview()
                }
                transitionContext.completeTransition(finished)
        }
    }
    
}
