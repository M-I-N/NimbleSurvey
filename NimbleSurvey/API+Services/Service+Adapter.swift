//
//  Service+Adapter.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import Foundation

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

class LoginAPIServiceAdapter: LoginService {
    let api: LoginAPI
    let loginCompletion: () -> Void
    let authManager: AuthManager
    
    init(api: LoginAPI, authManager: AuthManager, loginCompletion: @escaping () -> Void) {
        self.api = api
        self.authManager = authManager
        self.loginCompletion = loginCompletion
    }
    
    func loginWith(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let loginRequest = LoginRequest(email: email, password: password)
        api.token(request: loginRequest) { [weak self] result in
            switch result {
            case .success(let token):
                print("Login succeeded with token: \(token)")
                self?.authManager.save(token: token)
                completion(.success(()))
                self?.loginCompletion()
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
