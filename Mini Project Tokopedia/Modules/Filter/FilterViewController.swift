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

protocol FilterViewControllerDelegate: class {
    func filterDidClose(_ sender: FilterViewController)
}

class FilterViewController: UIViewController {
    
    var canSkip: Bool = false
    let disposeBag = DisposeBag()
    
    weak var delegate: FilterViewController?
    
    @IBAction func filterCloseButton(_ sender: Any) {
        delegate?.filterCloseButton(self)
    }
    //    @IBOutlet weak var rangeSlider: RangeSlider!
    let rangeSlider = RangeSlider(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.makeTransparentBackground()
        
        view.addSubview(rangeSlider)
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
            width: width, height: 31.0)
    }
    
    @objc func rangeSliderValueChanged(rangeSlider: RangeSlider) {
//        print("Range slider value changed: (\(rangeSlider.lowerValue) \(rangeSlider.upperValue))")
    }
}
