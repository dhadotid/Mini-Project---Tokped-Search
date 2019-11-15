//
//  Coordinator.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

enum SceneType {
    case root(UIWindow)
    case push(UINavigationController)
    case present(UIViewController)
    case detail(UISplitViewController)
}

protocol CoordinatorPayload { }

protocol Coordinator: class {
    var coordinators: [Coordinator] { get set }
    var rootViewController: UIViewController? { get }
    
    func start(sceneType: SceneType, payload: CoordinatorPayload?)
    func add(_ coordinator: Coordinator)
    func remove(_ coordinator: Coordinator?)
    func removeAllCoordinators()
    func removeCoordinators<T: Coordinator>(type: T.Type)
    func firstChild<T: Coordinator>(of type: T.Type) -> T?
}

extension Coordinator {
    
    //Needed for TabBar type coordinator
    var rootViewController: UIViewController? {
        return nil
    }
    
    func add(_ coordinator: Coordinator) {
        coordinators.append(coordinator)
    }
    
    func remove(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { return }
        coordinators = coordinators.filter { $0 !== coordinator }
    }
    
    func removeAllCoordinators() {
        coordinators.removeAll()
    }
    
    func removeCoordinators<T: Coordinator>(type: T.Type) {
        coordinators = coordinators.filter { !($0.self is T)}
    }
    
    func start(sceneType: SceneType, payload: CoordinatorPayload? = nil) {
        start(sceneType: sceneType, payload: payload)
    }
    
    func firstChild<T: Coordinator>(of type: T.Type) -> T? {
        return coordinators.first(where: { $0 is T }) as? T
    }
    
    func launch(target: UIViewController, sceneType: SceneType) {
        switch sceneType {
        case .present(let viewController):
            if #available(iOS 13, *) {
                /*
                 Some of default modalPresentationStyle on iOS 13 causing layout issues that should be ignored, fallback to .fullScreen style
                 */
                let shouldIgnorePresentationStyles: [UIModalPresentationStyle] = [.pageSheet, .custom]
                if shouldIgnorePresentationStyles.contains(target.modalPresentationStyle) {
                    target.modalPresentationStyle = .fullScreen
                }
            }
            viewController.present(target, animated: true, completion: nil)
        case .push(let navigationController):
            navigationController.pushViewController(target, animated: true)
        case .root(let window):
            window.rootViewController = target
        case .detail(let splitViewController):
            splitViewController.showDetailViewController(target, sender: nil)
        }
    }
}

protocol DetachableCoordinator: Coordinator {
    typealias Handler = ((Coordinator) -> Void)
    
    var detachingHandler: Handler? { get set }
    func notifyCoordinatorDetachment()
}

extension DetachableCoordinator where Self: Coordinator {
    func notifyCoordinatorDetachment() {
        detachingHandler?(self)
    }
}

protocol ClosableCoordinator: DetachableCoordinator {
    var canClose: Bool { get }
}

extension ClosableCoordinator {
    func addCloseButtonIfNeeded(for viewController: UIViewController, selector: Selector) {
        if canClose {
            let closeButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: selector)
            viewController.navigationItem.leftBarButtonItem = closeButtonItem
        }
    }
}
