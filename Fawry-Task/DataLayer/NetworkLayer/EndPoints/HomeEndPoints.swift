//
//  HomeEndPoints.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import Foundation
import Alamofire

enum HomeData: BaseEndPoint {
    
    case getHomeList
    
    var baseURL: String {
        return "https://picsum.photos/v2/list?page=1&limit=10"
    }
    
    var path: String {
        return ""
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
