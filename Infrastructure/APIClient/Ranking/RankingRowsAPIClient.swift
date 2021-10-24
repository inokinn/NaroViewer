//
//  RankingRowsAPIClient.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/24.
//

import Alamofire
import Combine

final class RankingRowsAPIClient: RankingRowsAPIClientProtocol {
    
    func fetch(ncode: String) -> AnyPublisher<[RankingRowsResponse], Error> {
        let request = RankingRowsRequest()
        request.ncode = ncode
        request.out = "json"
        return APIAccessPublisher.publish(request).eraseToAnyPublisher()
    }
}
