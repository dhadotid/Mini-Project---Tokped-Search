//
//  TokpedHeader.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import ObjectMapper

struct TokpedHeader : Mappable {
    var total_data: Int?
    var total_data_no_category: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        total_data <- map["total_data"]
        total_data_no_category <- map["total_data_no_category"]
    }
}
