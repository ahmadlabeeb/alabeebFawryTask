//
//  BaseEndPoint.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import Foundation
import Alamofire

public protocol BaseEndPoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var cachePolicy: ResponseCacher.Behavior { get }
    var headers: [String: String]? { get }
}
