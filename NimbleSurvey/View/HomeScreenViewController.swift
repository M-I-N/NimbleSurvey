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
    
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private var items = [SurveyItemViewModel]() {
        didSet {
            pageControl.numberOfPages = items.count
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setupPageControl()
        loadSurveyItems()
    }
    
    private func setupPageControl() {
        if #available(iOS 14.0, *) {
          pageControl.backgroundStyle = .minimal
          pageControl.allowsContinuousInteraction = false
        }
    }
    
    private func loadSurveyItems() {
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
        if items.isEmpty {
            return 1
        } else {
            return items.count
        }
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        let surveyItemViewController = SurveyItemViewController.instantiateFromStoryboard()
        if items.isEmpty {
            surveyItemViewController.isLoading = true
        } else {
            surveyItemViewController.surveyItemViewModel = items[index]
        }
        return surveyItemViewController
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}

extension HomeScreenViewController: PageboyViewControllerDelegate {
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) { }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        pageControl.currentPage = index
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) { }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) { }
}

extension HomeScreenViewController: StoryboardInstantiable {
    static var storyboardName: UIStoryboard.Name {
        .main
    }
}
