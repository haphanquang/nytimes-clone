//
//  SearchTermsViewModel.swift
//  NYTimesClone
//
//  Created by QH on 7/8/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

class SearchHistoriesViewModel : BasicViewModel {
    var onStateReloaded: (() -> ())?
    var onStartWaiting: (() -> ())?
    var onFinishWaiting: (() -> ())?
    
    private var localRepo: LocalDataRespository?
    
    init() {
        localRepo = LocalDataRespository()
    }
    
    var keywords: [String] = [] {
        didSet {
            onStateReloaded?()
        }
    }
    
    func loadKeywords() {
        localRepo?.getRecentKeywords(completion: { [weak self] keywords in
            guard let `self` = self else {return}
            self.keywords = keywords
        })
    }
    
}
