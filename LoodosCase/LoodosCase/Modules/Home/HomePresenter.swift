//
//  HomePresenter.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    private var movies: [Movie] = []
    private var currentPage = 1
    private var totalResults = 0
    private var currentQuery = ""
    private var isFetching = false
    
    func viewDidLoad() {
        
    }
    
    func searchMovies(with query: String) {
        guard !query.isEmpty else { return }
        currentQuery = query
        currentPage = 1
        movies.removeAll()
        view?.showLoading()
        isFetching = true
        interactor?.fetchMovies(query: query, page: currentPage)
    }
    
    func refreshMovies() {
        if !currentQuery.isEmpty {
            searchMovies(with: currentQuery)
        }
    }
    
    func loadMoreMovies() {
        guard !isFetching else { return }
        guard movies.count < totalResults else { return }
        currentPage += 1
        isFetching = true
        interactor?.fetchMovies(query: currentQuery, page: currentPage)
    }
    
    func didSelectMovie(_ movie: Movie, fromImageView: UIImageView) {
        if let id = movie.imdbID {
            router?.navigateToMovieDetail(with: id, fromImageView: fromImageView)
        }
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func moviesFetched(_ movies: [Movie], totalResults: Int) {
        isFetching = false
        view?.hideLoading()
        self.totalResults = totalResults
        if currentPage == 1 {
            self.movies = movies
            view?.updateMovies(movies)
        } else {
            self.movies.append(contentsOf: movies)
            view?.appendMovies(movies)
        }
    }
    
    func moviesFetchFailed(error: Error) {
        isFetching = false
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
    
    func noMoviesFound() {
        isFetching = false
        view?.hideLoading()
        self.movies.removeAll()
        view?.updateMovies([])
        view?.showNoResultsMessage("No movies found matching your criteria.")
    }
}

