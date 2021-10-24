//
//  SearchNovelAPIClient.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import Alamofire
import Combine

final class SearchNovelAPIClient: SearchNovelAPIClientProtocol {
    
    func fetch(word: String) -> AnyPublisher<[SearchNovelRowResponse], Error> {
        let request = SearchNovelRequest()
        request.word = word
        request.out = "json"
        return APIAccessPublisher.publish(request).eraseToAnyPublisher()
    }
}
