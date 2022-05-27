//
//  SurveyItemViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import UIKit
import Kingfisher

class SurveyItemViewController: UIViewController {
    
    var surveyItemViewModel: SurveyItemViewModel!
    
    @IBOutlet private weak var surveyCoverImageView: UIImageView!
    @IBOutlet private weak var surveyTitle: UILabel!
    @IBOutlet private weak var surveyDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshDataBinding()
    }
    
    private func refreshDataBinding() {
        surveyCoverImageView.kf.setImage(with: surveyItemViewModel.coverImageURL)
        surveyTitle.text = surveyItemViewModel.name
        surveyDescription.text = surveyItemViewModel.description
    }
    
    @IBAction private func gotoDetailsButtonTapped(_ sender: UIButton) {
        
    }
}

extension SurveyItemViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
