//
//  Article.swift
//  NYTimesClone
//
//  Created by QH on 7/4/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

struct Legacy : Codable {
    let widewidth: Int?
    let wideheight: Int?
    let wide: String?
}

struct Multimedia : Codable {
    let rank: Int?
    let subtype: String?
    let caption: String?
    let type: String?
    let url: String?
    let height: Int?
    let width: Int?
    let legacy: Legacy?
    let subType: String?
    let crop_name: String?
}

struct Headline: Codable {
    let main: String?
    let kicker: String?
    let content_kicker: String?
    let print_headline: String?
    let name: String?
    let seo: String?
    let sub: String?
}

struct Keyword : Codable {
    let name: String?
    let value: String?
    let rank: Int?
    let major: String?
}

struct Article : Codable {
    let web_url: String?
    let snippet: String?
    let lead_paragraph: String?
    let abstract: String?
    let print_page: String?
//    let blog: String?
    let source: String?
    let multimedia: [Multimedia]?
    let headline: Headline?
    let keywords: [Keyword]?
    let pub_date: String?
    let document_type: String?
    let news_desk: String?
    let section_name: String?
//    var byline: ByLine
    let type_of_material: String?
    let _id: String?
    let word_count: Int?
    let uri: String?
}
