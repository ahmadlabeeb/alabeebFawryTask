//
//  NetworkManager.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import Foundation
import Alamofire

typealias NetworkCompletionBlock<M> = (Result<M,Error>) -> Void
typealias ImageCompletionBlock = (Result<Data,Error>) -> Void

class NetworkManager<T: BaseEndPoint> {
    
    private let timeInterval = TimeInterval(60)
    
    func fetchRequest<M: Codable>(request: T, completion: @escaping NetworkCompletionBlock<M>){
        guard let url = URL.init(string: request.baseURL + request.path) else {
            return
        }
        let cacher = ResponseCacher(behavior: .doNotCache)
        AF.request(url, method:.get, parameters:[:], encoding:URLEncoding.default, headers: [:])
            .cacheResponse(using: cacher)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let model = try? JSONDecoder().decode(M.self, from: data)
                    if let model = model {
                        completion(.success(model))
                    }else {
                        completion(.failure(FawryError.parseError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
    
    
    func fetchImage(url: String, completion: @escaping ImageCompletionBlock) {
        
        let cacher = ResponseCacher(behavior: .cache)
        AF.request(url)
            .cacheResponse(using: cacher)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
}


