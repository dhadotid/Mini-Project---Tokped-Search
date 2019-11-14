//
//  Product.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 08/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import ObjectMapper

struct Product : Mappable {
    var id: Int?
    var name: String?
    var uri: String?
    var image: URL?
    var image700: URL?
    var price: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        uri <- map["uri"]
        image <- (map["image_uri"], URLTransform())
        image700 <- (map["image_uri_700"], URLTransform())
        price <- map["price"]
        
    }
}
