//
//  NetworkReachability.swift
//  LoodosCase
//
//  Created by fulden onan on 11.11.2024.
//

import Foundation
import Alamofire

class NetworkReachability {
    static let shared = NetworkReachability()
    private let reachabilityManager = NetworkReachabilityManager()
    
    var isConnected: Bool {
        return reachabilityManager?.isReachable ?? false
    }
}
