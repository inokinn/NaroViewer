//
//  RankingAPIClient.swift
//  Infrastructure
//
//  Created by Nobuya Inoue on 2021/10/16.
//

import Alamofire
import Combine

final class RankingAPIClient: RankingAPIClientProtocol {
    
    func fetch(rtype: String) -> AnyPublisher<[RankingResponse], Error> {
        let request = RankingRequest()
        request.rtype = rtype
        request.out = "json"
        return APIAccessPublisher.publish(request).eraseToAnyPublisher()
    }
}
