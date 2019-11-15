//
//  UINavigationController.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 15/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit

extension UINavigationController {
    func applyAppStyles() {
        navigationBar.tintColor = R.color.white()
        navigationBar.barTintColor = R.color.blackBackground()
        navigationBar.titleTextAttributes = [.foregroundColor: R.color.white() as Any]
        navigationBar.isTranslucent = false
    }
    
    func makeTransparentBackground() {
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
