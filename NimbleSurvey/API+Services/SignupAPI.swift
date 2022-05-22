//
//  SignupAPI.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import Foundation
import Combine

class SignupAPI: WebService {
    private init() { }
    
    static let shared = SignupAPI()
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.allowsExpensiveNetworkAccess = false
        config.allowsConstrainedNetworkAccess = false
        config.waitsForConnectivity = true
        return URLSession(configuration: config)
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        session.finishTasksAndInvalidate()
    }
    
    func register(request: SignupRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        publisher(for: request.urlRequest)
            .receive(on: DispatchQueue.main)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    completion(.failure(error))
                default:
                    break
                }
            } receiveValue: {
                completion(.success(true))
            }
            .store(in: &cancellables)
    }
}

struct SignupRequest: Endpoint {
    let email: String
    let password: String
    let confirmPassword: String
    
    var base: String {
        "https://nimble-survey-web-staging.herokuapp.com/"
    }
    
    var path: String {
        "/api/v1/registrations"
    }
    
    var queryItems: [URLQueryItem]? {
        [.init(name: "email", value: email),
         .init(name: "password", value: password),
         .init(name: "confirm_password", value: confirmPassword)]
    }
}
