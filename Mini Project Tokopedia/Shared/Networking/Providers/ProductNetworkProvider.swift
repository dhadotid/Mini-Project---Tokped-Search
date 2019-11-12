//
//  ProductsProvider.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol ProductNetworkProvider {
    func fetchAllData() -> Single<(product: [Product], header: TokpedHeader?)>
}

class ProductNetworkClient: ProductNetworkProvider {
    let networkClient: NetworkProvider
    init(networkProvider: NetworkProvider = NetworkClient()) {
        networkClient = networkProvider
    }
    
    func fetchAllData() -> Single<(product: [Product], header: TokpedHeader?)> {
        let pageUrl = TokpedAPI.search.urlString
        
        return networkClient.get(urlString: pageUrl, queryItems: [:]).map { responseData -> ([Product], TokpedHeader?) in
            let response = try Mapper<TokpedResponse>().tryMap(JSONObject: responseData)
            let product: [Product] = try response.parsedArrayData()
            return (product, response.header)
        }
    }
}
