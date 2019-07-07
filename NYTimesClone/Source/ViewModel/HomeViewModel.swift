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
    }
    
    
    
    //MARK: Output
    var articles: [Article] = [] {
        didSet {
            onStateReloaded?()
        }
    }
    
    var searchTerms: [Term] = [] {
        didSet {
            onStateReloaded?()
        }
    }
    
    var isSearching: Bool = false {
        didSet {
            onStateReloaded?()
        }
    }
    
    var updatedDate: Date = Date() {
        didSet {
            onStateReloaded?()
        }
    }
    
    //Mark: Input
    func requestGetInitData() {
        currentPage = 0
        requestGetArticles(filterKeyword: nil)
    }
    
    func requestGetArticles(filterKeyword: String?) {
        onStartWaiting?()
        
        currentKeyword = filterKeyword
        networkRepo?.doRequest(NYTimesRequest.search(filterKeyword, currentPage), completion: { [weak self] (message: String?, data: NYSearchResult?) in
            guard let `self` = self else {return}
            self.onFinishWaiting?()
            
            guard let data = data else {
                print(message)
                return
            }
            
            self.articles.append(contentsOf: data.response?.docs ?? [])
            
            print(self.articles.count)
        })
    }
    
    func requestGetNextArticles() {
        guard hasNextPage else { return }
        
        currentPage += 1
        requestGetArticles(filterKeyword: currentKeyword)
    }
    
    func requestGetSavedSearchTerms() {
        
    }
}
