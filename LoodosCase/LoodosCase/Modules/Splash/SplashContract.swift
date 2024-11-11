//
//  SplashContract.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import Foundation

protocol SplashViewProtocol: AnyObject {
    var presenter: Splash.Presenter? { get set }
}

protocol SplashPresenterProtocol: AnyObject {
    var view: Splash.View? { get set }
    var interactor: Splash.Interactor? { get set }
    var router: Splash.Router? { get set }
    
    func viewDidLoad()
}

protocol SplashInteractorProtocol: AnyObject {
    var presenter: Splash.InteractorToPresenter? { get set }
}

protocol SplashInteractorToPresenterProtocol: AnyObject {
    
}

protocol SplashRouterProtocol: AnyObject {
    
}

struct Splash {
    typealias View = SplashViewProtocol
    typealias Interactor = SplashInteractorProtocol
    typealias Presenter = SplashPresenterProtocol
    typealias Router = SplashRouterProtocol
    typealias InteractorToPresenter = SplashInteractorToPresenterProtocol
}
