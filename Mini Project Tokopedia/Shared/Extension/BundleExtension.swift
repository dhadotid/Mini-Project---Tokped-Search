//
//  BundleExtension.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation

extension Bundle {
    static func userDefined(key: String) -> String? {
        guard let infoDictionary = main.infoDictionary?["UserDefined"] as? [String: Any] else { return nil }
        return infoDictionary[key] as? String
    }
}
