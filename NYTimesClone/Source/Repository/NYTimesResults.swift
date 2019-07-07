//
//  NYTimesResults.swift
//  NYTimesClone
//
//  Created by QH on 7/5/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

struct Meta : Codable {
    let hit: Int?
    let offset: Int?
    let time: Int?
}

struct NYSearchResponse : Codable {
    let docs: [Article]?
    let meta: Meta?
}

struct NYSearchResult: NetworkResult {
    let status: String?
    let copyright: String?
    let response: NYSearchResponse?
    
}
