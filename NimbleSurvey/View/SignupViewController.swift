//
//  SignupViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import UIKit

protocol SignupService {
    func signup(completion: @escaping (Result<Void, Error>) -> Void)
}

class SignupViewController: UIViewController {
    
    var service: SignupAPIServiceAdapter?
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        service?.email = emailTextField.text
        service?.password = passwordTextField.text
        service?.confirmPassword = confirmPasswordTextField.text
        
        service?.signup { result in
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
