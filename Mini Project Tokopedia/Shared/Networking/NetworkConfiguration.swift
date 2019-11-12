//
//  NetworkConfiguration.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation

enum TokpedAPI {
    
    case search
    
    var apiString: String {
        switch self {
        case .search:
            return "search/v2.5/product?q=samsung&pmin=10000&pmax=100000&wholesale=true&official=true&fshop=2&start=0&rows=10"
        }
    }
    
    var urlString: String {
        return NetworkConfiguration.fullApiUrl(api: self)
    }
}

struct NetworkConfiguration {
    static let baseUrlString: String = Bundle.userDefined(key: "API_ENDPOINT")!
    static let apiPath: String = Bundle.userDefined(key: "API_PATH")!
    static let fullBaseUrl: String = "\(baseUrlString)" + (!apiPath.isEmpty ? "/\(apiPath)" : "")
    
    static func fullApiUrl(api: TokpedAPI) -> String {
        return "\(fullBaseUrl)/\(api.apiString)"
    }
}
