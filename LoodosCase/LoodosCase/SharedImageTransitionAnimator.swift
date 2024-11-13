//
//  SharedImageTransitionAnimator.swift
//  LoodosCase
//
//  Created by fulden onan on 13.11.2024.
//

import UIKit

class SharedImageTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.5
    var originImageView: UIImageView
    var destinationImageView: UIImageView
    
    init(originImageView: UIImageView, destinationImageView: UIImageView) {
        self.originImageView = originImageView
        self.destinationImageView = destinationImageView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let snapshot = originImageView.snapshotView(afterScreenUpdates: false)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        containerView.addSubview(toVC.view)
        toVC.view.alpha = 0
        
        // Add snapshot
        snapshot.frame = containerView.convert(originImageView.frame, from: originImageView.superview)
        containerView.addSubview(snapshot)
        originImageView.isHidden = true
        destinationImageView.isHidden = true
        
        destinationImageView.layoutIfNeeded()
        let destinationFrame = containerView.convert(destinationImageView.frame, from: destinationImageView.superview)

        UIView.animate(withDuration: duration, animations: {
            snapshot.frame = destinationFrame
            toVC.view.alpha = 1
        }, completion: { _ in
            self.destinationImageView.isHidden = false
            self.originImageView.isHidden = false
            snapshot.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
