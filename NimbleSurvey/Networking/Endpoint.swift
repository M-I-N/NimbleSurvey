//
//  Endpoint.swift
//  MoviesX
//
//  Created by Mufakkharul Islam Nayem on 12/5/22.
//

import Foundation

protocol Endpoint {

    /// The base URL of the resource as String. Don't return any path component after the domain name. Ex. https://baseurl.com
    var base: String { get }

    /// Path of the Endpoint. Ex. /resource/path
    var path: String { get }
    
    /// HTTP method of the Endpoint. Defaults to **GET**.
    var method: HTTPMethod { get }
    
    /// The data sent as the message body of a request, such as for an HTTP POST request. Defaults to `nil`.
    var httpBody: Data? { get }

    /// Array of name-value pair to be used for the query portion of the final Endpoint.
    var queryItems: [URLQueryItem]? { get }
    
    /// Accepted content type of the Endpoint. Ex. `application/json`
    var contentType: String? { get }
}

extension Endpoint {
    
    var method: HTTPMethod {
        return .get
    }
    
    var httpBody: Data? {
        return nil
    }

    private var urlComponents: URLComponents? {
        guard var components = URLComponents(string: base) else { return nil }
        components.path = path
        components.queryItems = queryItems
        return components
    }

    var urlRequest: URLRequest {
        let url = urlComponents?.url ?? URL(string: "\(base)\(path)")!
        var request = URLRequest(url: url)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        return request
    }

}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // ... add more cases when needed
}
