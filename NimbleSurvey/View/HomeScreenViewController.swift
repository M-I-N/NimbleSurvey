//
//  HomeScreenViewController.swift
//  NimbleSurvey
//
//  Created by Mufakkharul Islam Nayem on 27/5/22.
//

import UIKit
import Pageboy

protocol SurveyItemService {
    func loadSurveyItems(completion: @escaping (Result<[SurveyItemViewModel], Error>) -> Void)
}

class HomeScreenViewController: PageboyViewController {
    
    var service: SurveyItemService?
    
    private var items = [SurveyItemViewModel]() {
        didSet {
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataSource = self
        loadSurveyItems()
    }
    
    private func loadSurveyItems() {
        // show a loader maybe?
        service?.loadSurveyItems { [weak self] result in
            switch result {
            case .success(let surveyItems):
                self?.items = surveyItems
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension HomeScreenViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        items.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        let surveyItemViewController = SurveyItemViewController.instantiateFromStoryboard()
        return surveyItemViewController
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}
