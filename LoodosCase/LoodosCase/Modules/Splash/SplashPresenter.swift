//
//  SplashPresenter.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import Foundation

class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashViewProtocol?
    var interactor: SplashInteractorProtocol?
    var router: SplashRouterProtocol?
    
    func viewDidLoad() {
        view?.showLoadingAnimation()
        
        if NetworkReachability.shared.isConnected {
            interactor?.fetchRemoteConfig()
        } else {
            view?.hideLoadingAnimation()
            view?.showNoInternetAlert()
        } 
    }
}

extension SplashPresenter: SplashInteractorToPresenterProtocol {
    func remoteConfigFetched(title: String) {
        view?.hideLoadingAnimation()
        view?.displayTitle(title)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.router?.navigateToHomeView(from: self.view!)
        }
    }
    
    func remoteConfigFetchFailed(error: Error) {
        view?.hideLoadingAnimation()
        //TODO: handle errors
    }
}
