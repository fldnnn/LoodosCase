//
//  NetworkManager.swift
//  LoodosCase
//
//  Created by fulden onan on 12.11.2024.
//

import Foundation
import Alamofire

//class NetworkManager {
//    static let shared = NetworkManager()
//    private let apiKey = "40fa665a"
//    private let baseURL = "http://www.omdbapi.com/"
//
//    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
//        let parameters: Parameters = [
//            "s": query,
//            "apikey": apiKey
//        ]
//
//        AF.request(baseURL, parameters: parameters).responseDecodable(of: SearchResponse.self) { response in
//            switch response.result {
//            case .success(let searchResponse):
//                completion(.success(searchResponse.search!))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "40fa665a"
    private let baseURL = "http://www.omdbapi.com/"

    func searchMovies(query: String, page: Int, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        let parameters: Parameters = [
            "s": query,
            "page": page,
            "apikey": apiKey
        ]

        AF.request(baseURL, parameters: parameters).responseDecodable(of: SearchResponse.self) { response in
            switch response.result {
            case .success(let searchResponse):
                completion(.success(searchResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let parameters: Parameters = [
            "i": imdbID,
            "apikey": apiKey
        ]

        AF.request(baseURL, parameters: parameters).responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case .success(let movieDetail):
                completion(.success(movieDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
