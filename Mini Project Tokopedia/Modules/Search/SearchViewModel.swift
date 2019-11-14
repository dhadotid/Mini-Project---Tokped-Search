//
//  SearchViewModel.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 08/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel: RxViewModel, Paginatable {
    
    typealias DataType = Event
    enum Event {
        case loadInitialData([Product])
        case loadMore([Product])
    }
    
    var hasMoreData: Bool {
        return nextPage != nil
    }
    
    var isLoading: Bool = false
    
    func resetNextPage() {
        nextPage = 0
    }
    
    var nextPage: Int? = nil
    
    var numberOfItems: Int {
        return products.count
    }
    
    func loadMoreAPICall(isReload: Bool) {
        fetchAllData(isReload: isReload)
    }
    
    var stateObservable = BehaviorRelay<ViewModelState<Event>>(value: .idle)
    var productNetworkProvider: ProductNetworkProvider
    var products: [Product] = []
    var disposeBag = DisposeBag()
    
    init(productNetworkProvider: ProductNetworkProvider = ProductNetworkClient()) {
        self.productNetworkProvider = productNetworkProvider
        self.nextPage = 0
    }
    
    func fetchAllData(isReload: Bool){
        isLoading = true
        setState(.loading(nil))
        nextPage = isReload ? 0 : nextPage
        productNetworkProvider.fetchAllData(page: (nextPage ?? 0), perPage: 10)
        .subscribe(onSuccess: { [weak self] result in
                if isReload {
                    self?.products = result.product
                    self?.setState(.completed(.loadInitialData(result.product)))
                }else {
                    self?.products.append(contentsOf: result.product)
                    self?.setState(.completed(.loadMore(result.product)))
                }
                self?.nextPage = (self?.nextPage ?? 0) + 10
            if (self?.nextPage ?? 0) > (result.header?.total_data ?? 0) {
                    self?.nextPage = nil
                }
                self?.isLoading = false
            }, onError: { [weak self] error in
                self?.setState(.error(error))
        }).disposed(by: disposeBag)
    }
}


extension SearchViewModel {
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func product(at index: Int) -> Product? {
        guard 0..<numberOfProducts() ~= index else {
            return nil
        }
        return products[index]
    }
}
