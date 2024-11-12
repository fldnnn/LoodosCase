//
//  MovieDetailPresenter.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?
    
    var imdbID: String?

    func viewDidLoad() {
        view?.showLoading()
        if let imdbID = imdbID {
            interactor?.fetchMovieDetail(with: imdbID)
        }
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func movieDetailFetched(_ movieDetail: MovieDetail) {
        view?.hideLoading()
        view?.showMovieDetail(movieDetail)
    }

    func movieDetailFetchFailed(error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}
