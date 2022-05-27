//
//  SurveyAPI.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import Foundation
import Combine

class SurveyAPI: WebService {
    private init() { }
    
    static let shared = SurveyAPI()
    
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
    
    func getSurveys(request: SurveyRequest, completion: @escaping (Result<[Survey], Error>) -> Void) {
        publisher(for: request.urlRequest)
            .receive(on: DispatchQueue.main)
            .sink { receiveCompletion in
                switch receiveCompletion {
                case .failure(let error):
                    completion(.failure(error))
                default:
                    break
                }
            } receiveValue: { (surveyResponse: SurveyResponse) in
                completion(.success(surveyResponse.data))
            }
            .store(in: &cancellables)
    }
}

struct SurveyRequest: Endpoint {
    let pageNumber: Int
    let pageSize: Int
    let token: Token
    
    var base: String {
        NimbleEndpoint.DefaultValues.domain.rawValue
    }
    
    var path: String {
        "/api/v1/surveys"
    }
    
    var queryItems: [URLQueryItem]? {
        [.init(name: NimbleEndpoint.Keys.pageNumber.rawValue, value: "\(pageNumber)"),
         .init(name: NimbleEndpoint.Keys.pageSize.rawValue, value: "\(pageSize)")]
    }
    
    var contentType: String? {
        NimbleEndpoint.DefaultValues.contentType.rawValue
    }
    
    var customHeaders: [String : String] {
        [NimbleEndpoint.Keys.authorization.rawValue: "\(token.tokenType) \(token.accessToken)"]
    }
    
}
