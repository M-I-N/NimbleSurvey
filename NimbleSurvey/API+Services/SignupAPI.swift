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
    
    func register(request: SignupRequest, completion: @escaping (Result<Void, Error>) -> Void) {
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
                completion(.success(()))
            }
            .store(in: &cancellables)
    }
}

struct SignupRequest: Endpoint {
    let email: String
    let password: String
    let passwordConfirmation: String
    
    var base: String {
        NimbleEndpoint.DefaultValues.domain.rawValue
    }
    
    var path: String {
        "/api/v1/registrations"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var httpBody: Data? {
        let body = RequestBody(user: RequestBody.User(email: email, password: password, passwordConfirmation: passwordConfirmation))
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(body)
        return data
    }
    
    var contentType: String? {
        NimbleEndpoint.DefaultValues.contentType.rawValue
    }
    
    struct RequestBody: Encodable {
        struct User: Encodable {
            let email: String
            let password: String
            let passwordConfirmation: String
        }
        
        let user: User
        let clientId = NimbleEndpoint.DefaultValues.clientId.rawValue
        let clientSecret = NimbleEndpoint.DefaultValues.clientSecret.rawValue
    }
}
