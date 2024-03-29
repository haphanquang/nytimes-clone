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

    private let searchController = UISearchController(searchResultsController: nil)
    private let searchTerm = Route.createSearchTerm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        viewModel.requestGetInitData()
        
       
    }
    
    override func setupUI() {
        collectionView.collectionViewLayout = HomeArticlesFlowLayout()
        collectionView.backgroundColor = Color.darkWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        
        title = "The New York Times".localized
        
        self.view.addSubview(searchTerm.view)
        searchTerm.view.isHidden = true
        
        searchTerm.onSelectedKeyword = { [weak self] keyword in
            self?.viewModel.requestGetArticles(filterKeyword: keyword)
        }
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        
        viewModel.onStateReloaded = { [weak self] in
            guard let `self` = self else { return }
            if (self.viewModel.isSearching) {
                self.displaySearchedHistory()
            }else {
                self.displayArticles()
            }
        }
        
    }
    
    
    //MARK: indicator
    override func beginLoading() {
        self.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    override func finishLoading() {
        self.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    func displaySearchedHistory() {
        //TODO: Search frame
        searchTerm.viewModel.loadKeywords()
        searchTerm.view.frame = CGRect(x: 0, y: 110, width: collectionView.frame.width, height: collectionView.frame.height)
        self.view.bringSubviewToFront(searchTerm.view)
        searchTerm.view.isHidden = false
    }
    
    func displayArticles() {
        searchTerm.view.isHidden = true
        self.collectionView.reloadData()
    }
    
    private func setupSearchController() {
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "enter keyword".localized
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpdatingCell.identifier, for: indexPath) as! UpdatingCell
            cell.lblUpdate.text = viewModel.statusText
            return cell
        }
        
        if indexPath.row == viewModel!.articles.count + 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadMoreCell.identifier, for: indexPath) as! LoadMoreCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        cell.viewModel = ArticleCellViewModel(article: viewModel.articles[indexPath.row - 1])
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var rowCount =  viewModel!.articles.count + 1
        if viewModel!.hasNextPage {
            rowCount = rowCount + 1
        }
        return rowCount
    }
}

extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]
        Route.showArticleDetail(from: self, article: article)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.articles.count > 0 {
            print(indexPath.row)
            if indexPath.row == viewModel.articles.count + 1 {
//                (cell as? LoadMoreCell)?.indicator.startAnimating()
//                viewModel.requestGetNextArticles()
            }
        }
    }

}

extension HomeViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

extension HomeViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.isSearching = true
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search please")
        viewModel.isSearching = false
        viewModel.requestGetArticles(filterKeyword: searchBar.text)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.isSearching = false
    }
}

