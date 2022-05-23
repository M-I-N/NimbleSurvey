//
//  SceneDelegate.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeSignupViewController { [weak self] in
            self?.window?.rootViewController = self?.makeLoginViewController()
            self?.window?.makeKeyAndVisible()
        }
        window?.makeKeyAndVisible()
    }
    
    private func makeSignupViewController(signupCompleted: @escaping () -> Void) -> SignupViewController {
        let singUpVC = SignupViewController.instantiateFromStoryboard()
        
        let service = SignupAPIServiceAdapter(api: .shared, signupCompletion: signupCompleted)
        
        singUpVC.service = service
        return singUpVC
    }
    
    private func makeLoginViewController() -> UIViewController {
        UIViewController()
    }
    
}

