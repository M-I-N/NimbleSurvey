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
    let loginCompletion: (Token) -> Void
    let authManager: AuthManager
    
    init(api: LoginAPI, authManager: AuthManager, loginCompletion: @escaping (Token) -> Void) {
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
                self?.loginCompletion(token)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class SurveyAPIItemServiceAdapter: SurveyItemService {
    let api: SurveyAPI
    let token: Token
    let showDetail: (Survey) -> Void
    private var pageNumber = 1
    private var pageSize = 5
    
    
    init(api: SurveyAPI, token: Token, showDetail: @escaping (Survey) -> Void) {
        self.api = api
        self.token = token
        self.showDetail = showDetail
    }
    
    func loadSurveyItems(completion: @escaping (Result<[SurveyItemViewModel], Error>) -> Void) {
        let surveyRequest = SurveyRequest(pageNumber: pageNumber, pageSize: pageSize, token: token)
        api.getSurveys(request: surveyRequest) { [weak self] result in
            switch result {
            case .success(let surveys):
                let surveyItems = surveys.map { survey in
                    return SurveyItemViewModel(survey: survey) {
                        self?.showDetail(survey)
                    }
                }
                completion(.success(surveyItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
