//
//  UIScrollView.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 13/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit

extension UIScrollView {
    private static var lastCacheOffset: UInt8 = 0
    private(set) var cachedOffset: CGPoint? {
        get {
            guard let value = objc_getAssociatedObject(self, &UIScrollView.lastCacheOffset) as? CGPoint else {
                return nil
            }
            return value
        }
        
        set {
            objc_setAssociatedObject(self, &UIScrollView.lastCacheOffset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func cacheCurrentOffset() {
        cachedOffset = contentOffset
    }
    
    func restoreLastCachedOffset(_ animated: Bool = false) {
        if let validOffset = cachedOffset {
            setContentOffset(validOffset, animated: animated)
            cachedOffset = nil
        }
    }
    
    var didScrollToBottom: Bool {
        let bottomEdge = contentOffset.y + frame.size.height
        if bottomEdge >= contentSize.height - frame.size.height {
            return true
        }
        return false
    }
}
