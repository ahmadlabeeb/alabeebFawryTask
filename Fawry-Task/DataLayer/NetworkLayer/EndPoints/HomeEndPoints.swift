//
//  HomeEndPoints.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import Foundation
import Alamofire

enum HomeEndPoints: BaseEndPoint {
    
    case getHomeList(_ page: Int, _ limit: Int)
    
    var baseURL: String {
        return "https://picsum.photos/v2/"
    }
    
    var path: String {
        switch self {
        case .getHomeList(let page, let limit):
            return "list?page=\(page)&limit=\(limit)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]?{
        return [:]
    }
    
    var cachePolicy: ResponseCacher.Behavior {
        return .doNotCache
    }
    
    var headers: [String : String]?{
        return [:]
    }
    
    
}
