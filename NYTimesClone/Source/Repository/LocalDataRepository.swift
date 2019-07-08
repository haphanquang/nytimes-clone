//
//  LocalDataRepository.swift
//  NYTimesClone
//
//  Created by QH on 7/4/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

enum UserReferenceKeys {
    static let keywords = "com.test.keywords"
}

struct LocalDataRespository : DataRepo {
    
    func insertToHistories(keyword: String, _ completion: (Bool) -> ()) {
        var histories = UserDefaults.standard.stringArray(forKey: UserReferenceKeys.keywords) ?? []
        histories.append(keyword)
        UserDefaults.standard.set(histories, forKey: UserReferenceKeys.keywords)
        completion(UserDefaults.standard.synchronize())
    }
    
    func getRecentKeywords(completion: ([String]) -> ()) {
        guard let keywords = UserDefaults.standard.stringArray(forKey: UserReferenceKeys.keywords) else {
            completion([])
            return
        }
        completion(keywords.reversed())
    }
}
