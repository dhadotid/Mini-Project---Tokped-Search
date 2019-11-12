//
//  ProductItemView.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 08/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

struct ProductItem {
    var product: Product
}

protocol ProductItemViewDelegate: class {
    func didSelectItem(_ item: ProductItem)
}

class ProductItemView: UIView {
    
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet var contentView: UIView!
    
    weak var delegate: ProductItemViewDelegate?
    
    var productItem: ProductItem? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.configure()
            }
        }
    }
    
    convenience init(_ productItem: ProductItem? = nil){
        self.init(frame: .zero)
        self.productItem = productItem
        configure()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        if let productItem = productItem {
            self.lblProductName.text = productItem.product.name
            self.lblPrice.text = productItem.product.price
        }
    }
}
