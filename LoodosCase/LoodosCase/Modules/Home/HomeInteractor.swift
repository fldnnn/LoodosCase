//
//  HomeInteractor.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {
    var output: Home.InteractorToPresenter?

    func fetchMovies(query: String, page: Int) {
        NetworkManager.shared.searchMovies(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searchResponse):
                let movies = searchResponse.search ?? []
                let totalResults = Int(searchResponse.totalResults ?? "0") ?? 0
                DispatchQueue.main.async {
                if movies.isEmpty {
                    self.output?.noMoviesFound()
                } else {
                    self.output?.moviesFetched(movies, totalResults: totalResults)
                }
            }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.moviesFetchFailed(error: error)
                }
            }
        }
    }
}
