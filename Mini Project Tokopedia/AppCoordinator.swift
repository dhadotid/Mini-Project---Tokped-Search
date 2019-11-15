//
//  AppCoordinator.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator {
    var coordinators: [Coordinator] = []
    var window: UIWindow?
    
    func start(sceneType: SceneType) {
        if case .root(let window) = sceneType {
            self.window = window
            openHomeScreen()
        } else {
            fatalError("AppCoordinator must be root type")
        }
    }
}


// Navigating
extension AppCoordinator {
    func openHomeScreen() {
        if let window = window {
            let homeCoordinator = SearchCoordinator()
            add(homeCoordinator)
            homeCoordinator.delegate = self
            homeCoordinator.start(sceneType: .root(window))
        }
    }
}


// HomeCoordinator
extension AppCoordinator: SearchCoordinatorDelegate {
    
    func searchCoordinator(coordinator: SearchCoordinator) {
        remove(coordinator)
        openHomeScreen()
    }
}
