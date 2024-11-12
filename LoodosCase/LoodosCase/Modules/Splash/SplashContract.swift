//
//  SplashContract.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import Foundation

protocol SplashViewProtocol: AnyObject {
    var presenter: Splash.Presenter? { get set }
    
    func showNoInternetAlert()
    func displayTitle(_ text: String)
    func showLoadingAnimation()
    func hideLoadingAnimation()
}

protocol SplashPresenterProtocol: AnyObject {
    var view: Splash.View? { get set }
    var interactor: Splash.Interactor? { get set }
    var router: Splash.Router? { get set }
    
    func viewDidLoad()
}

protocol SplashInteractorProtocol: AnyObject {
    var output: Splash.InteractorToPresenter? { get set }
    
    func fetchRemoteConfig()
}

protocol SplashInteractorToPresenterProtocol: AnyObject {
    func remoteConfigFetched(title: String)
    func remoteConfigFetchFailed(error: Error)
}

protocol SplashRouterProtocol: AnyObject {
    func navigateToHomeView()
}

struct Splash {
    typealias View = SplashViewProtocol
    typealias Interactor = SplashInteractorProtocol
    typealias Presenter = SplashPresenterProtocol
    typealias Router = SplashRouterProtocol
    typealias InteractorToPresenter = SplashInteractorToPresenterProtocol
}
