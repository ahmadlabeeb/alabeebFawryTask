//
//  LoginViewModel.swift
//  Fawry-Task
//
//  Created by Labeeb on 26/11/2021.
//

import Foundation
import RxSwift

typealias SuccessBlock<T> =  ((T) -> (Void))
typealias FailureBlock<T:Error> =  ((T) -> (Void))

class LoginViewModel {
    
    
    private var loginManager: LoginManager = LoginManager.manager
    var errorMessage: BehaviorSubject<String?>? = BehaviorSubject.init(value: nil)
    
    func login(with mobile: String, password: String, success:SuccessBlock<UserModel>, failure: FailureBlock<FawryError> ) {
        if validation(for: mobile, password: password) {
            loginManager.login(with: mobile, password: password) { result in
                switch result {
                case .success(let user):
                    success(user)
                    saveLoginState()
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
    
    func saveLoginState() {
        let defaults = UserDefaultsManager.manager
        defaults.saveLogin(status: true)
    }
    
    private func validation(for mobile: String, password: String) -> Bool {
        
        var message = ""
        if mobile.isEmpty {
            message = "mobile must not be empty"
            errorMessage?.on(.next(message))
            return false
        }
        if password.isEmpty {
            message = "password must not be empty"
            errorMessage?.on(.next(message))
            return false
        }
        
        if password.count < 8 {
            message = "password must be at least 8 characters"
            errorMessage?.on(.next(message))
            return false
        }
        
        return true
    }
}
