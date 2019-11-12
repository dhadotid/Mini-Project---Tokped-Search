//
//  SearchViewController.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 08/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol SearchViewControllerDelegate: class {
    func searchController(_ sender: SearchViewController)
}

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel(){
//        disposeBag.insert([
//            viewModel.stateObservable.subscribe(onNext: { [weak self] state in
//                switch state {
//                case .completed(_):
////                    self?
//                }
//            })
//        ])
        viewModel.fetchAllData(isReload: true)
    }
}
