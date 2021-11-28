//
//  LoginManager.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import Foundation

typealias LoginCompletionBlock = (Result<UserModel,FawryError>) -> Void

class LoginManager {
    
    static let manager = LoginManager.init()
    
    func login(with mobile: String, password: String, complesion: LoginCompletionBlock) {
        let user = UserModel.init(mobile: "", password: "", userName: "")
        complesion(.success(user))
    }
}


enum FawryError:Error {
    case userNotFound
    case PasswordIncorrect
    case parseError
    func description() -> String {
        switch self {
        case .PasswordIncorrect:
            return "Incorrect Password"
        case .userNotFound:
            return "this user is not exist"
        case .parseError:
            return "Error in parsing json"
        }
    }
}
