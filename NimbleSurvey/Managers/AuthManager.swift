//
//  AuthManager.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 26/5/22.
//

import Foundation

class AuthManager {
    // for demonstratio purpose, using UserDefaults for storing the auth token.
    // Keychain should be the choice here
    
    let api: LoginAPI
    
    init(api: LoginAPI) {
        self.api = api
    }
    
    private let tokenUserDefaultsKey = "auth-token"
    private(set) var token: Token? {
        set { }
        get { getTokenFromUserDefaults() }
    }
    
    var isTokenStillValid: Bool {
        guard let token = token else { return false }
        let expireTimeStamp = token.createdAt + token.expiresIn
        let expireDate = Date(timeIntervalSince1970: TimeInterval(expireTimeStamp))
        return expireDate > Date()
    }
    
    func save(token: Token) {
        self.token = token
        do {
            let encodedToken = try JSONEncoder().encode(token)
            UserDefaults.standard.set(encodedToken, forKey: tokenUserDefaultsKey)
        } catch {
            print(error)
        }
    }
    
    // there might be better way of taking this decision of whether or not to refresh token so often
    // FIXME: consider revisiting this implementation
    func refreshTokenIfNeeded() {
        guard let token = token, isTokenStillValid else {
            // logout should be performed and user needs to be taken to login screen
            return
        }
        let refreshTokenRequest = RefreshTokenRequest(refreshToken: token.refreshToken)
        api.refreshToken(request: refreshTokenRequest) { [weak self] result in
            switch result {
            case .success(let newToken):
                print("Token refreshed")
                self?.save(token: newToken)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getTokenFromUserDefaults() -> Token? {
        guard let data = UserDefaults.standard.data(forKey: tokenUserDefaultsKey) else { return nil }
        do {
            return try JSONDecoder().decode(Token.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
