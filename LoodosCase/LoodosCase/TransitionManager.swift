//
//  TransitionManager.swift
//  LoodosCase
//
//  Created by fulden onan on 13.11.2024.
//

import UIKit

protocol ImageTransitionable {
    var transitioningImageView: UIImageView? { get }
}

class TransitionManager: NSObject, UINavigationControllerDelegate {
    
    var originImageView: UIImageView?
    var destinationImageView: UIImageView?
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push,
           let fromVC = fromVC as? HomeViewController,
           let toVC = toVC as? MovieDetailViewController,
           let originImageView = fromVC.transitioningImageView,
           let destinationImageView = toVC.transitioningImageView {
            
            return SharedImageTransitionAnimator(originImageView: originImageView, destinationImageView: destinationImageView)
        }
        
        return nil
    }
}
