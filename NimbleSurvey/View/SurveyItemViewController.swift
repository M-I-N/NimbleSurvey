//
//  SurveyItemViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import UIKit
import Kingfisher
import SkeletonView

class SurveyItemViewController: UIViewController {
    
    var surveyItemViewModel: SurveyItemViewModel!
    var isLoading = false
    
    @IBOutlet private weak var surveyCoverImageView: UIImageView!
    @IBOutlet private weak var surveyTitle: UILabel!
    @IBOutlet private weak var surveyDescription: UILabel!
    @IBOutlet private weak var gotoDetailsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoading {
            startLoadingAnimation()
        } else {
            refreshDataBinding()
        }
    }
    
    private func refreshDataBinding() {
        surveyCoverImageView.kf.setImage(with: surveyItemViewModel.coverImageURL)
        surveyTitle.text = surveyItemViewModel.name
        surveyDescription.text = surveyItemViewModel.description
    }
    
    private func startLoadingAnimation() {
        surveyTitle.showAnimatedGradientSkeleton()
        surveyDescription.showAnimatedGradientSkeleton()
        gotoDetailsButton.isHidden = true
    }
    
    @IBAction private func gotoDetailsButtonTapped(_ sender: UIButton) {
        surveyItemViewModel.showDetail()
    }
}

extension SurveyItemViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
