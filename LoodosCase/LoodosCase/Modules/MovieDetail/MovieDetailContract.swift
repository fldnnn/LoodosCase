//
//  MovieDetailContract.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import Foundation
import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol? { get set }
    func showMovieDetail(_ movieDetail: MovieDetail)
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

protocol MovieDetailPresenterProtocol: AnyObject {
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    func viewDidLoad()
}

protocol MovieDetailInteractorProtocol: AnyObject {
    var output: MovieDetailInteractorOutputProtocol? { get set }
    func fetchMovieDetail(with imdbID: String)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func movieDetailFetched(_ movieDetail: MovieDetail)
    func movieDetailFetchFailed(error: Error)
}

protocol MovieDetailRouterProtocol: AnyObject {
    static func createModule(with imdbID: String, image: UIImage?) -> MovieDetailViewController
}
