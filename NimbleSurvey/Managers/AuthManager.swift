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
    
    private init() { }
    
    static let shared = AuthManager()
    
    private let tokenUserDefaultsKey = "auth-token"
    private(set) var token: Token? {
        set { }
        get { getTokenFromUserDefaults() }
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
