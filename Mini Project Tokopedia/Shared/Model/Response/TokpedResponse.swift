//
//  Response.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import ObjectMapper

struct TokpedResponse : Mappable {
    var data: Any?
    var header: TokpedHeader?
    var status: TokpedError?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
        header <- map["header"]
    }
    
    func parsedData<T: BaseMappable>() throws -> T {
        if let data = data {
            return try Mapper<T>().tryMap(JSONObject: data)
        }
        else if let error = status {
            throw error
        }
        
        throw NetworkError.invalidResponse
    }
    
    func parsedArrayData<T: BaseMappable>() throws -> [T] {
        if let data = data {
            return try Mapper<T>().tryMapArray(JSONObject: data)
        }
        else if let error = status {
            throw error
        }
        
        throw NetworkError.invalidResponse
    }
}
