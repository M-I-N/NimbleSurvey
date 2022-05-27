//
//  SurveyItemViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import UIKit

class SurveyItemViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SurveyItemViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
