//
//  BaseRequest.swift
//  Infrastructure
//
//  Created by Nobuya Inoue on 2021/10/16.
//

import Alamofire
import Foundation

protocol BaseRequest: URLRequestConvertible {
    associatedtype ResponseType
    
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers:[String: String]? { get }
    var timeoutInterval: TimeInterval { get }
    var allowConstrainedNetworkAccess: Bool { get }
    var parameters: Parameters? { get }
    var encoding: URLEncoding { get }
}

extension BaseRequest {
    
    var baseURL: URL {
        return try! "https://api.syosetu.com/".asURL()
    }
    
    var headers:[String: String]? {
        return nil
    }
    
    var timeoutInterval: TimeInterval {
        return TimeInterval(30)
    }
    
    var allowConstrainedNetworkAccess: Bool {
        return true
    }
    
    var encoding: URLEncoding {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(self.path))
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.timeoutInterval = self.timeoutInterval
        urlRequest.allowsConstrainedNetworkAccess = self.allowConstrainedNetworkAccess
        
        if let parameters = self.parameters {
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
