//
//  SignupViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 22/5/22.
//

import UIKit

protocol SignupService {
    func signup(completion: @escaping (Result<Bool, Error>) -> Void)
}

class SignupViewController: UIViewController {
    
    var service: SignupService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SignupViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
