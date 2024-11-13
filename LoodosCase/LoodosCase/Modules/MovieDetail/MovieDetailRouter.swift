//
//  MovieDetailRouter.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {
    weak var view: UIViewController?
    
    static func createModule(with imdbID: String, image: UIImage?) -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("MovieDetailView not found in MovieDetail.storyboard")
        }
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        
        viewController.presenter = presenter
        
        router.view = viewController
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.imdbID = imdbID
        
        interactor.output = presenter
        
        if let image = image {
                    viewController.initialImage = image
                }
        
        return viewController
    }
}
