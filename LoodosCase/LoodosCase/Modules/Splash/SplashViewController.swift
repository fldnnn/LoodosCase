//
//  SplashViewController.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import UIKit
//import Lottie

class SplashViewController: UIViewController, SplashViewProtocol {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var animationContainerView: UIView!
    var presenter: Splash.Presenter?
//    var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        view.applyGradient(colors: [
            UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1),
            UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        ])
    }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(title: "Error", message: "Internet connection is unavailable.", preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Okey", style: .default))
        present(alert, animated: true)
    }
    
    func displayTitle(_ text: String) {
        DispatchQueue.main.async {
            self.titleLbl.text = text
        }
    }
    
    func showLoadingAnimation() {
//        animationView = .init(name: "loading")
//        animationView?.contentMode = .scaleAspectFill
//        animationView?.loopMode = .loop
//        if let animationView = animationView {
//            animationContainerView.addSubview(animationView)
//            animationView.play()
//        }
    }
    
    func hideLoadingAnimation() {
//        DispatchQueue.main.async {
//            self.animationView?.stop()
//            self.animationView?.removeFromSuperview()
//        }
    }
}
