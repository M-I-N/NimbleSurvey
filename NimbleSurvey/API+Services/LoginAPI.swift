//
//  LoginAPI.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 23/5/22.
//

import Foundation
import Combine

class LoginAPI: WebService {
    private init() { }
    
    static let shared = LoginAPI()
    
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
    
    func token(request: LoginRequest, completion: @escaping (Result<Token, Error>) -> Void) {
        publisher(for: request.urlRequest)
            .receive(on: DispatchQueue.main)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    completion(.failure(error))
                default:
                    break
                }
            } receiveValue: { (authToken: AuthToken) in
                completion(.success(authToken.data.attributes))
            }
            .store(in: &cancellables)
    }
    
    func refreshToken(request: RefreshTokenRequest, completion: @escaping (Result<Token, Error>) -> Void) {
        publisher(for: request.urlRequest)
            .receive(on: DispatchQueue.main)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    completion(.failure(error))
                default:
                    break
                }
            } receiveValue: { (authToken: AuthToken) in
                completion(.success(authToken.data.attributes))
            }
            .store(in: &cancellables)
    }
}

struct LoginRequest: Endpoint {
    let email: String
    let password: String
    
    var base: String {
        NimbleEndpoint.DefaultValues.domain.rawValue
    }
    
    var path: String {
        "/api/v1/oauth/token"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var httpBody: Data? {
        let body = RequestBody(email: email, password: password)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(body)
        return data
    }
    
    var contentType: String? {
        NimbleEndpoint.DefaultValues.contentType.rawValue
    }
    
    struct RequestBody: Encodable {
        let email: String
        let password: String
        let grantType = NimbleEndpoint.DefaultValues.passwordGrantType.rawValue
        let clientId = NimbleEndpoint.DefaultValues.clientId.rawValue
        let clientSecret = NimbleEndpoint.DefaultValues.clientSecret.rawValue
    }
}

struct RefreshTokenRequest: Endpoint {
    let refreshToken: String
    
    var base: String {
        NimbleEndpoint.DefaultValues.domain.rawValue
    }
    
    var path: String {
        "/api/v1/oauth/token"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var httpBody: Data? {
        let body = RequestBody(refreshToken: refreshToken)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(body)
        return data
    }
    
    var contentType: String? {
        NimbleEndpoint.DefaultValues.contentType.rawValue
    }
    
    struct RequestBody: Encodable {
        let refreshToken: String
        let grantType = NimbleEndpoint.DefaultValues.refreshTokenGrantType.rawValue
        let clientId = NimbleEndpoint.DefaultValues.clientId.rawValue
        let clientSecret = NimbleEndpoint.DefaultValues.clientSecret.rawValue
    }
    
}
