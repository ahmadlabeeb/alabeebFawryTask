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
    let dbManager = DBManager.init()
    
    func login(with mobile: String, password: String, complesion: LoginCompletionBlock) {
        let items = dbManager.fetch(entityName: "Fawryuser")
        let matchesItems = items.filter { object in
            if let umobile = object.value(forKey: "mobile") as? String, let upassword = object.value(forKey: "password") as? String {
                if ((password == upassword) && (umobile == mobile)) {
                    return true
                }
            }
            return false
        }
        if matchesItems.count > 0 {
            let user = UserModel.init(mobile: mobile, password: password, userName: "")
            complesion(.success(user))
        }else {
            complesion(.failure(.userNotFound))
        }
    }
    
    func registerUser(with mobile: String, password: String, complesion: LoginCompletionBlock) {
        let dic = ["name":"", "mobile": mobile, "password": password]
        let entityName = "Fawryuser"
        dbManager.insertToDatabase(dict: dic, entityName: entityName, completion: { success in
            if success {
                complesion(.success(UserModel.init(mobile: mobile, password: password, userName: "")))
            }else{
                complesion(.failure(FawryError.userNotFound))
            }
        })
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
