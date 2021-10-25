//
//  APIAccessPublisher.swift
//  Infrastructure
//
//  Created by Nobuya Inoue on 2021/10/16.
//

import Alamofire
import Combine
import Foundation

struct APIAccessPublisher {
    
    private static let contentType = "application/json"
    private static let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static func publish<T, V>(_ request: T) -> Future<V, Error>
    where T: BaseRequest, V: Codable, T.ResponseType == V {
        return Future { promise in
            let api = AF
                .request(request)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        do {
                            if let data = response.data {
                                let json = try self.decoder.decode(V.self, from: data)
                                promise(.success(json))
                            } else {
                                promise(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                            }
                        } catch {
                            promise(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                        }
                    case .failure:
                        promise(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                    }
                }
            api.resume()
        }
    }
}
