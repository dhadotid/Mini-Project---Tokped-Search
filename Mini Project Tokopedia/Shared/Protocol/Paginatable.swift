//
//  Paginatable.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation

protocol Paginatable {
    var hasMoreData: Bool { get }
    var isLoading: Bool { get set }
    var numberOfItems: Int { get }
    
    func loadMoreAPICall(isReload: Bool)
    func resetNextPage()
    
    // MARK: - Implemented. Just use it in your view controller
    
    var shouldShowLoadingIndicator: Bool { get }
    
    func reload()
    func loadMore()
    func isLoadMoreIndex(_ index: Int) -> Bool
}

// MARK: - Default implemment
extension Paginatable {
    var shouldShowLoadingIndicator: Bool {
        return hasMoreData && numberOfItems > 0
    }
    
    func reload() {
        resetNextPage()
        loadMoreAPICall(isReload: true)
    }
    
    func loadMore() {
        guard isLoading == false else { return }
        
        if hasMoreData {
            loadMoreAPICall(isReload: false)
        }
    }
    
    func isLoadMoreIndex(_ index: Int) -> Bool {
        return index == numberOfItems
    }
}
