//
//  FilterCoordinator.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 15/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

class FilterCoordinator: ClosableCoordinator {
    var canClose: Bool
    var detachingHandler: Handler?
    var coordinators: [Coordinator] = []
    weak var navigationController: UINavigationController!
    var rootViewController: UIViewController? {
        return navigationController
    }
    
    init(canClose: Bool = false) {
        self.canClose = canClose
    }
    
    func start(sceneType: SceneType) {
        let filterViewController = makeFilterViewController()
        let navigationController = UINavigationController(rootViewController: filterViewController)
        self.navigationController = navigationController
        navigationController.applyAppStyles()
        launch(target: navigationController, sceneType: sceneType)
    }
}

extension FilterCoordinator {
    private func makeFilterViewController() -> FilterViewController {
        let viewController = R.storyboard.filter.filterViewController()!
//        viewController.delegate = self
//        viewController.canSkip = !canClose
//        let viewModel = PlaylistDetailViewModel(playlist: playlistType?.associatedPlaylist, type: .playlist)
//        playlistDetailViewController.viewModel = viewModel
        return viewController
    }
}
