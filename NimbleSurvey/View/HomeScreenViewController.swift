//
//  HomeScreenViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import UIKit

protocol SurveyItemService {
    func loadSurveyItems(completion: @escaping (Result<[SurveyItemViewModel], Error>) -> Void)
}

class HomeScreenViewController: UIViewController {
    
    var service: SurveyItemService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSurveyItems()
    }
    
    private func loadSurveyItems() {
        // show a loader maybe?
        service?.loadSurveyItems { result in
            switch result {
            case .success(let surveyItems):
                print(surveyItems)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension HomeScreenViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
