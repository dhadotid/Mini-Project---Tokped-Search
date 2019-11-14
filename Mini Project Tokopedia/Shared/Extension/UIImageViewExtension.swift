//
//  UIImageViewExtension.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 13/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

enum ImageOrientation {
    case portrait
    case landscape
    
    var placeHolder: UIImage {
        switch self {
        case .portrait:
            return R.image.placeHolderPortrait()!
        case .landscape:
            return R.image.placeHolderLandscape()!
        }
    }
}

extension UIImageView {
    func setImage(with url: URL?, orientation: ImageOrientation = .portrait) {
        kf.setImage(with: url, placeholder: orientation.placeHolder)
    }
}
