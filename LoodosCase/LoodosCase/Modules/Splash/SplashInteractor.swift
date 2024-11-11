//
//  SplashInteractor.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import Foundation
import FirebaseRemoteConfig

class SplashInteractor: SplashInteractorProtocol {
    var output: Splash.InteractorToPresenter?
    let remoteConfig = RemoteConfig.remoteConfig()
    
    func fetchRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { [weak self] (status, error) in
            if status == .success {
                self?.remoteConfig.activate { _, _ in
                    let title = self?.remoteConfig.configValue(forKey: "SplashText").stringValue ?? ""
                    self?.output?.remoteConfigFetched(title: title)
                }
            } else {
                self?.output?.remoteConfigFetchFailed(error: error ?? NSError(domain: "RemoteConfig", code: -1, userInfo: nil))
            }
        }
    }
}
