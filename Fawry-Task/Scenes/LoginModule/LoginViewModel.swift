//
//  LoginViewModel.swift
//  Fawry-Task
//
//  Created by Labeeb on 26/11/2021.
//

import Foundation
import RxSwift


class LoginViewModel {
    
    
    var loginModel : BehaviorSubject<UserModel>?
    
    
    func login(with mobile: String, password: String) {
        if validation(for: mobile, password: password) {
            
        }
    }
    
    func validation(for mobile: String, password: String) -> Bool {
        
        return true
    }
}

