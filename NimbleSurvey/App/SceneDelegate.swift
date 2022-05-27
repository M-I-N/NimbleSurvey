//
//  SceneDelegate.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let loginAPI = LoginAPI.shared
    private lazy var authManager: AuthManager = {
        let manager = AuthManager(api: loginAPI)
        return manager
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeRootViewController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        authManager.refreshTokenIfNeeded()
    }
    
    private func makeRootViewController() -> UIViewController {
        if let token = authManager.token, authManager.isTokenStillValid {
            return makeHomeViewController(token: token)
        } else {
            return makeLoginViewController { [weak self] token in
                self?.window?.rootViewController = self?.makeHomeViewController(token: token)
                self?.window?.makeKeyAndVisible()
            }
        }
    }
    
    private func makeSignupViewController(signupCompleted: @escaping () -> Void) -> SignupViewController {
        let singUpVC = SignupViewController.instantiateFromStoryboard()
        
        let service = SignupAPIServiceAdapter(api: .shared, signupCompletion: signupCompleted)
        
        singUpVC.service = service
        return singUpVC
    }
    
    private func makeLoginViewController(loginCompletion: @escaping (Token) -> Void) -> LoginViewController {
        let loginVC = LoginViewController.instantiateFromStoryboard()
        
        let service = LoginAPIServiceAdapter(api: loginAPI, authManager: authManager, loginCompletion: loginCompletion)
        
        loginVC.service = service
        return loginVC
    }
    
    private func makeHomeViewController(token: Token) -> UIViewController {
        let home = HomeScreenViewController()
        
        let service = SurveyAPIItemServiceAdapter(api: .shared, token: token)
        home.service = service
        return home
    }
    
}

