//
//  HomeRouter.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit

class HomeRouter {
    weak var view: UIViewController?
    private var transitionManager: TransitionManager?
    
    static func createModule() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            fatalError("SplashViewController could not be found in Splash.storyboard")
        }
        
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        viewController.presenter = presenter
        
        router.view = viewController
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        return viewController
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigateToMovieDetail(with movieID: String, fromImageView: UIImageView) {
        let movieDetailVC = MovieDetailRouter.createModule(with: movieID, image: fromImageView.image)
        if let navigationController = view?.navigationController,
           let destinationViewController = movieDetailVC as? MovieDetailViewController {
            _ = destinationViewController.view
            transitionManager = TransitionManager()
            transitionManager?.originImageView = fromImageView
            transitionManager?.destinationImageView = fromImageView
            navigationController.delegate = transitionManager
            
            navigationController.pushViewController(movieDetailVC, animated: true)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                navigationController.delegate = nil
                self.transitionManager = nil
            }
        }
    }
}
