//
//  UICollectionView.swift
//  Mini Project Tokopedia
//
//  Created by yudha on 13/11/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func setupPullToRefresh(target: Any? , action: Selector) {
        let refreshControl = RefreshControl()
        refreshControl.yOffset = 10
        refreshControl.tintColor = .white
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
        contentInsetAdjustmentBehavior = .never
    }
    
    func setupAsCoversCollectionView() {
        register(UINib(resource: R.nib.productItemView), forCellWithReuseIdentifier: R.reuseIdentifier.searchCollectionViewCell.identifier)
//        register(R.nib.noResultsCollectionReusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(UICollectionReusableView.self)")
        
        let flowLayout = UICollectionViewFlowLayout()
        let hPadding: CGFloat = TkpConstant.interitemSpacing
        let numberOfColumns: CGFloat = TkpConstant.playlistCoverColumns
        let coverWidth = (UIScreen.main.bounds.width - (TkpConstant.interitemSpacing * (numberOfColumns + 1)))/numberOfColumns
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = UIDevice.current.isPhone ? CGSize(width: coverWidth, height: coverWidth * TkpConstant.playlistCoverHeightRatio) : TkpConstant.playlistCoverSize
        flowLayout.minimumInteritemSpacing = TkpConstant.interitemSpacing
        flowLayout.minimumLineSpacing = TkpConstant.interitemSpacing
        flowLayout.sectionInset = .init(top: 0, left: hPadding, bottom: 0, right: hPadding)
        alwaysBounceVertical = true
        collectionViewLayout = flowLayout
    }
}
