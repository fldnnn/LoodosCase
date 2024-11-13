//
//  HomeContract.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: Home.Presenter? { get set }
    
    func reloadData()
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func updateMovies(_ movies: [Movie])
    func appendMovies(_ movies: [Movie])
    func showNoResultsMessage(_ message: String)
}

protocol HomePresenterProtocol: AnyObject {
    var view: Home.View? { get set }
    var interactor: Home.Interactor? { get set }
    var router: Home.Router? { get set }
    
    func viewDidLoad()
    func searchMovies(with query: String)
    func refreshMovies()
    func loadMoreMovies()
    func didSelectMovie(_ movie: Movie, fromImageView: UIImageView)
}

protocol HomeInteractorProtocol: AnyObject {
    var output: Home.InteractorToPresenter? { get set }
    
    func fetchMovies(query: String, page: Int)
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func moviesFetched(_ movies: [Movie], totalResults: Int)
    func moviesFetchFailed(error: Error)
    func noMoviesFound()
}

protocol HomeRouterProtocol: AnyObject {
    func navigateToMovieDetail(with movieID: String, fromImageView: UIImageView)
}

struct Home {
    typealias View = HomeViewProtocol
    typealias Interactor = HomeInteractorProtocol
    typealias Presenter = HomePresenterProtocol
    typealias Router = HomeRouterProtocol
    typealias InteractorToPresenter = HomeInteractorToPresenterProtocol
}
