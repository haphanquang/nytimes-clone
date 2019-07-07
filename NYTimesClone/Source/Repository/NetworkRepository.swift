//
//  NetworkRepository.swift
//  NYTimesClone
//
//  Created by QH on 7/4/19.
//  Copyright © 2019 soyo. All rights reserved.
//

import Foundation

enum HTTPMethod : String {
    case delete  = "DELETE"
    case get     = "GET"
    case head    = "HEAD"
    case patch   = "PATCH"
    case post    = "POST"
    case put     = "PUT"
}

typealias Parameters = [String : String]

protocol NetworkRequest {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    
    var asURLRequest: URLRequest? { get }
}

protocol ParameterEncoding {
    @discardableResult
    func encode(_ urlRequest: inout URLRequest, with parameters: Parameters) -> URLRequest?
}


struct URLEncoding: ParameterEncoding {
    static var `default`: URLEncoding { return URLEncoding() }
    
    @discardableResult
    func encode(_ urlRequest: inout URLRequest, with parameters: Parameters) -> URLRequest? {
        guard let url = urlRequest.url else {
            return nil
        }
        
        //add params to url if need (reference alamofire)
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            var components: [(String, String)] = []
            
            for (key, value) in parameters {
                components.append((key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))
            }
            
            let query = components.map { "\($0)=\($1)" }.joined(separator: "&")
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query
            
            urlComponents.percentEncodedQuery = percentEncodedQuery
            urlRequest.url = urlComponents.url
            
        }

        return urlRequest
    }
}

struct JSONEncoding: ParameterEncoding {
    @discardableResult
    func encode(_ urlRequest: inout URLRequest, with parameters: Parameters) -> URLRequest? {
        return nil
    }
}

protocol NetworkResult : Codable {
    
}

struct NetworkRepository: DataRepo {
    func doRequest<T: Codable>(_ req: NetworkRequest, completion: ((_ msg: String?, _ result: T?) -> ())?) {
        guard let request = req.asURLRequest else {
            completion?("Unexpected error", nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion?(error?.localizedDescription, nil)
                }
                return
            }
            
            debugPrint(String(data: data, encoding: .utf8))
            debugPrint(T.self)
            
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion?(nil, result)
                }
                
            } catch (let error) {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion?("invalid data response".localized, nil)
                }
            }
            
        }.resume()
        
    }
}
