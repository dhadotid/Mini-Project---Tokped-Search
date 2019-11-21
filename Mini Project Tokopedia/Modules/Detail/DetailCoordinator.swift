//
//  DetailCoordinator.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 19/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

struct DetailPayload :CoordinatorPayload {
    var selectedProduct: Product
}

class DetailCoordinator: DetachableCoordinator {
    var coordinators: [Coordinator] = []
    var detachingHandler: ((Coordinator) -> Void)?
    
    deinit {
        print("Deinit \(type(of: self))")
    }
    
    func start(sceneType: SceneType, payload: CoordinatorPayload? = nil) {
        var viewController: DetailViewController?
        if let detailPayload = payload as? DetailPayload {
            viewController = makeViewController(for: detailPayload)
        }
        
        guard let detailViewController = viewController else {
            assertionFailure("Invalid player payload")
            return
        }

//        detailViewController.delegate = self
        launch(target: detailViewController, sceneType: sceneType)
    }
    
    func makeViewController(for payload: DetailPayload) -> DetailViewController {
        let detailViewController = R.storyboard.detail.detailViewController()!
        detailViewController.product = payload.selectedProduct
        return detailViewController
    }
}
