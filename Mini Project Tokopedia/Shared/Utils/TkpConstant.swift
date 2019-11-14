//
//  TkpConstant.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 14/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

struct TkpConstant {
    static let playlistHeight: CGFloat = UIDevice.current.isPhone ? 330 : 385
    static let playlistCoverSize: CGSize = CGSize(width: 234, height: 246)
    static let playlistCoverHeightRatio: CGFloat = 1.78
    static let interitemSpacing: CGFloat = UIDevice.current.isPhone ? 12 : 30
    static let playlistCoverColumns: CGFloat = 2.0
}
