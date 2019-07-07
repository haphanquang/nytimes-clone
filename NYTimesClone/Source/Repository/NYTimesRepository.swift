//
//  NYRepository.swift
//  NYTimesClone
//
//  Created by QH on 7/4/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

enum NYTimesRequest : NetworkRequest {
    
    case search(String?, Int)
    
    private var defaultParams: Parameters {
        return ["api-key": "5763846de30d489aa867f0711e2b031c"]
    }
    
    var baseURL: String {
        return "https://api.nytimes.com/svc/search/v2"
    }
    
    var method: HTTPMethod {
        switch self {
        case .search(_, _):
            return .get
        }
    }
    
    var params: Parameters? {
        switch self {
        case .search(let query, let page):
            var params = defaultParams
            params["query"] = query ?? ""
            params["page"] = "\(page)"
            return params
        }
    }
    
    var path : String {
        switch self {
        case .search(_, _):
            return "/articlesearch.json"
        }
    }
    
    var asURLRequest: URLRequest? {
        guard let url = URL(string: baseURL) else {
            return nil
        }
        
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = params {
            URLEncoding.default.encode(&urlRequest, with: parameters)
        }
        
        print(">> \(urlRequest)")
        
        return urlRequest
    }
}

