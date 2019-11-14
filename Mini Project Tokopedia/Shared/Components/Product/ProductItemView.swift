//
//  ProductItemView.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 08/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit
import Kingfisher

class ProductItemView: UICollectionViewCell {
    
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with product: Product){
        self.lblProductName.text = product.name
        self.lblPrice.text = product.price
        self.ivProduct.setImage(with: product.image)
    }
}
