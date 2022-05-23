//
//  Service+Adapter.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import Foundation

enum SignupAdapterError: LocalizedError {
    case noEmail
    case noPassword
    case noConfirmPassword
}

class SignupAPIServiceAdapter: SignupService {
    let api: SignupAPI
    
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    init(api: SignupAPI) {
        self.api = api
    }
    
    func signup(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let email = email else {
            completion(.failure(SignupAdapterError.noEmail))
            return
        }
        guard let password = password else {
            completion(.failure(SignupAdapterError.noPassword))
            return
        }
        guard let confirmPassword = confirmPassword else {
            completion(.failure(SignupAdapterError.noConfirmPassword))
            return
        }
        
        let signUpRequest = SignupRequest(email: email, password: password, passwordConfirmation: confirmPassword)
        api.register(request: signUpRequest, completion: completion)
    }
}
