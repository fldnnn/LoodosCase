//
//  SplashRouter.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import UIKit

class SplashRouter {
    static func createModule() -> SplashViewController {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {
            fatalError("SplashViewController could not be found in Splash.storyboard")
        }
        
        let presenter = SplashPresenter()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        return viewController
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigateToHomeView(from view: UIViewController) {
        if let viewController = view as? UIViewController {
//            let homeVC = HomeRouter.createModule()
//            viewController.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
}
