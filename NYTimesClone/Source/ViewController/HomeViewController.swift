//
//  HomeViewController.swift
//  NYTimesClone
//
//  Created by QH on 7/4/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController : BaseViewController <HomeViewModel> {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblUpdated: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestGetInitData()
    }
    
    override func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = HomeArticlesFlowLayout()
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        
        viewModel.onStateReloaded = { [weak self] in
            guard let `self` = self else { return }
            
            if (self.viewModel.isSearching) {
                self.displaySearchedTerm()
            }else {
                self.displayArticles()
                self.collectionView.reloadData()
            }
        }
        
    }
    
    
    //MARK: indicator
    override func beginLoading() {
        lblUpdated.text = "Loading...".localized
    }
    
    override func finishLoading() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        lblUpdated.text = "Updated ".localized + formatter.string(from: viewModel.updatedDate)
    }
    
    func displaySearchedTerm() {
        
    }
    
    func displayArticles() {
        
    }
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == viewModel!.articles.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadMoreCell.identifier, for: indexPath) as! LoadMoreCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        cell.viewModel = ArticleCellViewModel(article: viewModel.articles[indexPath.row])
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rowCount =  viewModel!.articles.count
        if viewModel!.hasNextPage {
            rowCount = rowCount + 1
        }
        return rowCount
    }
}

extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.articles.count {
            (cell as? LoadMoreCell)?.indicator.startAnimating()
            viewModel.requestGetNextArticles()
        }
    }
}

