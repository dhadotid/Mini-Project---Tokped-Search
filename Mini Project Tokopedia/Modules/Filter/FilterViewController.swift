//
//  FilterViewController.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 15/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FilterViewController: UIViewController {
    
    var canSkip: Bool = false
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.makeTransparentBackground()
    }
}
