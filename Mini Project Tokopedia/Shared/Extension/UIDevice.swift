//
//  UIDevice.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 14/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
