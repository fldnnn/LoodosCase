//
//  MovieDetailInteractor.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    weak var output: MovieDetailInteractorOutputProtocol?
    
    func fetchMovieDetail(with imdbID: String) {
        NetworkManager.shared.getMovieDetail(imdbID: imdbID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self.output?.movieDetailFetched(movieDetail)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.movieDetailFetchFailed(error: error)
                }
            }
        }
    }
}
