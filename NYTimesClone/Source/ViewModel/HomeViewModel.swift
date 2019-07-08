//
//  HomeViewModel.swift
//  NYTimesClone
//
//  Created by QH on 7/4/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

protocol Pagingable {
    var hasNextPage: Bool {get set}
    var currentPage: Int {get set}
}

protocol BasicViewModel {
//    var localRepo: LocalDataRespository? {get set}
//    var networkRepo: NetworkRepository? {get set}
//    var fastAccessRepo: FastAccessRepository? {get set}
    
    var onStateReloaded: (() -> ())? {get set}
    var onStartWaiting: (() -> ())? {get set}
    var onFinishWaiting: (() -> ())? {get set}
}

class HomeViewModel: BasicViewModel, Pagingable {
    var localRepo: LocalDataRespository?
    var networkRepo: NetworkRepository?
    var fastAccessRepo: FastAccessRepository?
    
    var hasNextPage: Bool = false
    var currentPage: Int = 0
    
    private var currentKeyword: String? = nil
    
    var onStateReloaded: (() -> ())?
    var onStartWaiting: (() -> ())?
    var onFinishWaiting: (() -> ())?
    
    init() {
        localRepo = LocalDataRespository()
        fastAccessRepo = FastAccessRepository()
        networkRepo = NetworkRepository()
        
        dateFormatter.dateStyle = .full
        
    }
    
    //MARK: Output
    var articles: [Article] = [] {
        didSet {
            onStateReloaded?()
        }
    }
    
    var searchTerms: [String] = [] {
        didSet {
            onStateReloaded?()
        }
    }
    
    var isSearching: Bool = false {
        didSet {
            onStateReloaded?()
        }
    }
    
    var statusText: String = "Loading...".localized
    
    //Mark: Input
    func requestGetInitData() {
        currentPage = 0
        requestGetArticles(filterKeyword: nil)
    }
    
    func requestGetArticles(filterKeyword: String?) {
        statusText = "Loading...".localized
        onStartWaiting?()
        currentKeyword = filterKeyword
        
        networkRepo?.doRequest(NYTimesRequest.search(filterKeyword, currentPage), completion: { [weak self] (message: String?, data: NYSearchResult?) in
            guard let `self` = self else {return}
            
            self.statusText = "Updated ".localized + dateFormatter.string(from: Date())
            self.onFinishWaiting?()
            
            guard let data = data else { return }
            
            self.articles.append(contentsOf: data.response?.docs ?? [])
            self.hasNextPage = true
        })
    }
    
    func requestGetNextArticles() {
        guard hasNextPage else { return }
        guard statusText != "Loading...".localized else { return } //cheating
        
        currentPage += 1
        requestGetArticles(filterKeyword: currentKeyword)
    }
    
    
    func addToHistory(_ keyword: String) {
        
    }
}
