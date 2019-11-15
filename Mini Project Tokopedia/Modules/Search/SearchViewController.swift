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
    func searchViewControllerBeginDragging(_ playlistDetailViewController: SearchViewController)
    func searchDidTapFilter(_ searchViewController: SearchViewController)
}

extension SearchViewControllerDelegate {
    func searchController(_ sender: SearchViewController) {}
    func searchViewControllerBeginDragging(_ playlistDetailViewController: SearchViewController) {}
    func searchDidTapFilter(_ searchViewController: SearchViewController) {}
}

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    var disposeBag = DisposeBag()
    
    weak var delegate: SearchViewControllerDelegate?
    
    @IBOutlet weak var productCollectionView: UICollectionView! {
        didSet {
            productCollectionView.setupPullToRefresh(target: self, action: #selector(refreshControlValueChanged(_:)))
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

        ])
        viewModel.fetchAllData(isReload: true)
    }
    
    @objc func refreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        viewModel.fetchAllData(isReload: true)
    }
    
    // MARK: - Action

    @IBAction func onFilterButtonTapped() {
        print("HEHEHE")
        delegate?.searchDidTapFilter(self)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.didScrollToBottom {
            viewModel.loadMore()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.searchViewControllerBeginDragging(self)
    }
}

