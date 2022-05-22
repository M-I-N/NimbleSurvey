//
//  WebService.swift
//  MoviesX
//
//  Created by Mufakkharul Islam Nayem on 12/5/22.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode
    case post
}

enum WebServiceError: Error {
    case sessionFailed(error: HTTPError)
    case decodingFailed(Error)
    case other(Error)
}

protocol WebService {
    var session: URLSession { get }
    func publisher(for request: URLRequest) -> AnyPublisher<Void, WebServiceError>
    func publisher<T: Decodable>(for request: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, WebServiceError>
}

extension WebService {
    func publisher(for request: URLRequest) -> AnyPublisher<Void, WebServiceError> {
        session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard
                    let response = output.response as? HTTPURLResponse,
                    200 ..< 300 ~= response.statusCode
                else {
                    throw HTTPError.statusCode
                }
            }
            .mapError { error in
                switch error {
                case let httpError as HTTPError:
                    return .sessionFailed(error: httpError)
                default:
                    return .other(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func publisher<T: Decodable>(for request: URLRequest, decoder: JSONDecoder = .init()) -> AnyPublisher<T, WebServiceError> {
        session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard
                    let response = output.response as? HTTPURLResponse,
                    200 ..< 300 ~= response.statusCode
                else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return .decodingFailed(error)
                case let httpError as HTTPError:
                    return .sessionFailed(error: httpError)
                default:
                    return .other(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
