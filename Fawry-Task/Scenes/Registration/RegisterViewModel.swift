//
//  RegisterViewModel.swift
//  Fawry-Task
//
//  Created by Labeeb on 26/11/2021.
//

import Foundation
import RxSwift

class RegisterViewModel {
    
    
    private var loginManager: LoginManager = LoginManager.manager
    var errorMessage: BehaviorSubject<String?>? = BehaviorSubject.init(value: nil)
    
    func register(with mobile: String, password: String, confirmPassword: String, success:SuccessBlock<UserModel>, failure: FailureBlock<FawryError> ) {
        if validation(for: mobile, password: password, confirmPassword: confirmPassword) {
            loginManager.registerUser(with: mobile, password: password) { result in
                switch result {
                case .success(let user):
                    success(user)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
    
    private func validation(for mobile: String, password: String, confirmPassword: String) -> Bool {
        
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
        
        if password != confirmPassword {
            message = "confirm password field does not match password field"
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
