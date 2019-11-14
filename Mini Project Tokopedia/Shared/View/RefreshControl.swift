//
//  RefreshControl.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 13/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit

class RefreshControl: UIRefreshControl {
    
    var yOffset: CGFloat = 0

    override func layoutSubviews() {
        var newFrame = frame
        if (superview as? UIScrollView) != nil {
            newFrame.origin.y = newFrame.origin.y + yOffset
            frame = newFrame
        }
        
        super.layoutSubviews()
    }
}
