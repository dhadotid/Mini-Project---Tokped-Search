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
    func searchViewControllerRequestReload(_ playlistDetailViewController: SearchViewController)
    func searchViewControllerBeginDragging(_ playlistDetailViewController: SearchViewController)
}

extension SearchViewControllerDelegate {
    func searchController(_ sender: SearchViewController) {}
    func searchViewControllerRequestReload(_ playlistDetailViewController: SearchViewController) {}
    func searchViewControllerBeginDragging(_ playlistDetailViewController: SearchViewController) {}
}

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    var disposeBag = DisposeBag()
    
    weak var delegate: SearchViewControllerDelegate?
    
    @IBOutlet weak var productCollectionView: UICollectionView! {
        didSet {
//            productCollectionView.setupPullToRefresh(target: self, action: #selector(refreshControlValueChanged(_:)))
            productCollectionView.setupAsCoversCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel(){
        disposeBag.insert([
            viewModel.stateObservable.subscribe(onNext: { [weak self] state in
                switch state {
                case .completed(_):
                    self?.productCollectionView.reloadData()
                default: break
                }
            }),
//            bindToProgressHUD(with: viewModel, shouldShowLoading: false, shouldShowError: true)
        ])
        viewModel.fetchAllData(isReload: true)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mediaCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.searchCollectionViewCell.identifier, for: indexPath) as! ProductItemView
        if let channel = viewModel.product(at: indexPath.row) {
            mediaCollectionViewCell.configure(with: channel)
        }
        return mediaCollectionViewCell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let selectedChannel = viewModel.channel(at: indexPath.row) {
//           let allChannels = viewModel.channels
//            delegate?.channelsDidTapLiveTVChannel(self, selectedChannel: selectedChannel, allChannels: allChannels)
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize.zero
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.didScrollToBottom {
            delegate?.searchViewControllerRequestReload(self)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.searchViewControllerBeginDragging(self)
    }
}

