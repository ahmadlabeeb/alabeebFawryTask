//
//  UserDefaultsManager.swift
//  Fawry-Task
//
//  Created by Labeeb on 29/11/2021.
//

import Foundation

class UserDefaultsManager {
    
    static let manager = UserDefaultsManager.init()
    
    private let defaults = UserDefaults.standard
    private let kLogin = "isLogged"
    
    func saveLogin(status: Bool) {
        defaults.set(status, forKey: kLogin)
    }
    
    func isLoggedIn() -> Bool {
        if let islogin = defaults.value(forKey: kLogin) as? Bool{
            return islogin
        }
        return false
    }
}
