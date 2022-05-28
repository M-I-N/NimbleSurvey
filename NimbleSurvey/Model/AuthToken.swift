//
//  AuthToken.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 23/5/22.
//

import Foundation

// MARK: - AuthToken
struct AuthToken: Decodable {
    let data: DataClass
    
    struct DataClass: Decodable {
        let id: String
        let type: String
        let attributes: Token
    }
}

// MARK: - Token
struct Token: Decodable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresIn: Int
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case createdAt = "created_at"
    }
}
