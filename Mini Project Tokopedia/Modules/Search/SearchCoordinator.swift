//
//  SearchCoordinator.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

protocol SearchCoordinatorDelegate: class {
    func searchCoordinator(coordinator: SearchCoordinator)
}

class SearchCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    weak var delegate: SearchCoordinatorDelegate?
    
    deinit {
        print("Deinit \(type(of: self))")
    }
    
    func start(sceneType: SceneType) {
        let searchScreenViewController = makeViewController()
        launch(target: searchScreenViewController, sceneType: sceneType)
    }
    
    func makeViewController() -> SearchViewController {
        let viewController = R.storyboard.search.searchViewController()!
        viewController.viewModel = SearchViewModel()
        viewController.delegate = self
        return viewController
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func searchController(_ sender: SearchViewController) {
        delegate?.searchCoordinator(coordinator: self)
    }
}
