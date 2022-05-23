//
//  LoginViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 23/5/22.
//

import UIKit

protocol LoginService {
    func loginWith(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class LoginViewController: UIViewController {
    
    var service: LoginService?
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        service?.loginWith(email: email, password: password) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension LoginViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
