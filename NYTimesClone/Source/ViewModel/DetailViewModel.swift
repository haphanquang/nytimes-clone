//
//  DetailViewModel.swift
//  NYTimesClone
//
//  Created by QH on 7/7/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

struct DetailViewModel : BasicViewModel {
    var onStateReloaded: (() -> ())?
    var onStartWaiting: (() -> ())?
    var onFinishWaiting: (() -> ())?
    
    var detailArticle: Article!
    
    var sectionCount: Int = 1{
        didSet {
            onStateReloaded?()
        }
    }
    var rowCount: [Int] = [2]{
        didSet {
            onStateReloaded?()
        }
    }
    var title: String = "" {
        didSet {
            onStateReloaded?()
        }
    }
    
    init() {
        
    }
    
    func loadDetail() {
        
    }

}
