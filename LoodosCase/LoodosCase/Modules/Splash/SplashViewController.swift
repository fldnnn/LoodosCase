//
//  SplashViewController.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import UIKit
import Lottie

class SplashViewController: UIViewController, SplashViewProtocol {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var animationContainerView: UIView!
    var presenter: Splash.Presenter?
    var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(title: "Hata", message: "İnternet bağlantısı yok.", preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    func displayTitle(_ text: String) {
        DispatchQueue.main.async {
            self.titleLbl.text = text
        }
    }
    
    func showLoadingAnimation() {
        animationView = .init(name: "loading")
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        if let animationView = animationView {
            animationContainerView.addSubview(animationView)
            animationView.play()
        }
    }
    
    func hideLoadingAnimation() {
        DispatchQueue.main.async {
            self.animationView?.stop()
            self.animationView?.removeFromSuperview()
        }
    }
}
