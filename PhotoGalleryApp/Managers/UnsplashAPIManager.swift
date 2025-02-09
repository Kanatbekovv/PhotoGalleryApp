//
//  UnsplashAPIManager.swift
//  PhotoGalleryApp

//

import Foundation
import Alamofire

protocol UnsplashAPIManagerProtocol {
    func getRandomPhotos(completion: @escaping (Result<[PhotoModel], Error>) -> Void)
    func searchPhotos(query: String, completion: @escaping (Result<[PhotoModel], Error>) -> Void)
}

final class UnsplashAPIManager {
    let accessKey = "yuYGF2X2vZ1mPvX04nGkpdycPB4BVCQ63JdcgqgVcgU"
    let baseURL = "https://api.unsplash.com/"
    
    func getRandomPhotos(completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        let url = "\(baseURL)photos/random"
        let parameters: [String: Any] = ["count": 30]
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(accessKey)"
        ]
        
        AF.request(url, parameters: parameters, headers: headers).responseDecodable(of: [PhotoModel].self) { response in
            switch response.result {
            case .success(let photos):
                completion(.success(photos))
            case .failure(let error):
                print("Error fetching random photos: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func searchPhotos(query: String, completion: @escaping (Result<[PhotoModel], Error>) -> Void) {
        let url = "\(baseURL)search/photos"
        let parameters: [String: Any] = ["query": query, "per_page": 30]
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(accessKey)"
        ]
        
        AF.request(url, parameters: parameters, headers: headers).responseDecodable(of: UnsplashSearchResponse.self) { response in
            switch response.result {
            case .success(let searchResponse):
                completion(.success(searchResponse.results))
            case .failure(let error):
                print("Error searching photos: \(error)")
                completion(.failure(error))
            }
        }
    }
}

struct UnsplashSearchResponse: Codable {
    let results: [PhotoModel]
}

extension UnsplashAPIManager: UnsplashAPIManagerProtocol { }
