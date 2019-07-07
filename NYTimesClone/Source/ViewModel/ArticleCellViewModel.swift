//
//  ArticleCellViewModel.swift
//  NYTimesClone
//
//  Created by QH on 7/7/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

struct ArticleCellViewModel {
    var image: String?
    var title: String?
    var `desription`: String?
    var author: String?
    var time: Date?
    var isFavourited: Bool = false
    
    init(article: Article) {
        self.image = article.multimedia?.first?.url
        self.title = article.headline?.main
        self.desription = article.snippet
        self.author = article.source
        self.time = article.pub_date?.iso8601
    }
}
