//
//  SignupViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import UIKit

protocol SignupService {
    func signupWith(email: String, password: String, confirmPassword: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class SignupViewController: UIViewController {
    
    var service: SignupService?
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        
        service?.signupWith(email: email, password: password, confirmPassword: confirmPassword) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SignupViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
