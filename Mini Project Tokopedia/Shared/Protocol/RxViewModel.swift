//
//  RxViewModel.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 12/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ViewModelState<T>: Equatable {
    case idle
    case loading(String?)
    case completed(T)
    case error(Error)
}


func ==<T>(lhs: ViewModelState<T>, rhs: ViewModelState<T>) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle): return true
    case (.loading, .loading): return true
    case (.completed, .completed): return true
    case (.error, .error): return true
    default: return false
    }
}

protocol RxViewModel {
    associatedtype DataType
    var stateObservable: BehaviorRelay<ViewModelState<DataType>> { get set }
    func setState(_ newState: ViewModelState<DataType>)
    func handleError<T>(type: T.Type, error: Error) -> Observable<T>
}

extension RxViewModel {
    func setState(_ newState: ViewModelState<DataType>) {
        stateObservable.accept(newState)
    }
    
    func handleError<T>(type: T.Type, error: Error) -> Observable<T> {
        self.setState(.error(error))
        return Observable.empty()
    }
}

