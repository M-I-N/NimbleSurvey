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
    let signupCompletion: () -> Void
    
    init(api: SignupAPI, signupCompletion: @escaping () -> Void) {
        self.api = api
        self.signupCompletion = signupCompletion
    }
    
    func signupWith(email: String, password: String, confirmPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let signUpRequest = SignupRequest(email: email, password: password, passwordConfirmation: confirmPassword)
        api.register(request: signUpRequest) { [weak self] result in
            switch result {
            case .success:
                completion(.success(()))
                self?.signupCompletion()
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
