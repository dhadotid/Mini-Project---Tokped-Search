//
//  TokpedError.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import ObjectMapper

struct TokpedError: Mappable, LocalizedError {
    var code: Int?
    var message: String?
    
    var httpStatusCode: Int?
    var nsErrorCode: Int?
    
    init() {}
    init?(map: Map) {
        
    }
    
    init(error: Error) {
        httpStatusCode = error.asAFError?.responseCode
        nsErrorCode = (error as NSError).code
    }
    
    mutating func mapping(map: Map) {
        code <- map["error_code"]
        message <- map["message"]
    }
}
