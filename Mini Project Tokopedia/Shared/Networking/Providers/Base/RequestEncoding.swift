//
//  RequestEncoding.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import Alamofire

struct RequestEncoding: ParameterEncoding {
    private let queries: Parameters?
    private let body: Parameters?
//    private let headers: HTTPHeaders?
    
    init(queries: Parameters? = nil, body: Parameters? = nil) {
        self.queries = queries
        self.body = body
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        let originRequest = try urlRequest.asURLRequest()
        
        // Queries
        var request = try URLEncoding.init(destination: .queryString, arrayEncoding: .brackets, boolEncoding: .literal).encode(originRequest, with: queries)
        
        // Body
        request = try JSONEncoding().encode(request, with: body)
        
        return request
    }
}
