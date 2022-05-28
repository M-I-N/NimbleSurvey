//
//  SurveyDetailsViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 28/5/22.
//

import UIKit

class SurveyDetailsViewController: UIViewController {
    
    // typically this should be passed to the adapter of this class
    var survey: Survey?
    
    @IBOutlet weak var surveyTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTitleLabel.text = survey?.attributes.title
    }
    
}

extension SurveyDetailsViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
