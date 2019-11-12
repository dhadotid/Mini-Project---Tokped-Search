//
//  MapperExtension.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import ObjectMapper

extension Mapper {
    func tryMap(JSONObject: Any?, keyPath: String? = nil) throws -> N {
        var dataObject: Any? = JSONObject
        
        if let keyPath = keyPath, let JSONObject = JSONObject as? [String: Any] {
            dataObject = JSONObject[keyPath]
        }
        
        guard let object = map(JSONObject: dataObject) else {
            throw NetworkError.parseDataError
        }
        
        return object
    }
    
    func tryMapArray(JSONObject: Any?, keyPath: String? = nil) throws -> [N] {
        var dataObject: Any? = JSONObject
        
        if let keyPath = keyPath, let JSONObject = JSONObject as? [String: Any] {
            dataObject = JSONObject[keyPath]
        }
        
        guard let objectArray = mapArray(JSONObject: dataObject) else {
            throw NetworkError.parseDataError
        }
        
        return objectArray
    }
}
