//
//  SearchNovelGateway.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import Foundation
import Combine

protocol SearchNovelAPIClientProtocol {
    func fetch(word: String) -> AnyPublisher<[SearchNovelRowResponse], Error>
}

final class SearchNovelGateway: SearchNovelGatewayProtocol {
    let apiClient: SearchNovelAPIClientProtocol
    
    init(apiClient: SearchNovelAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetch(word: String) -> AnyPublisher<[SearchNovelRow], Error> {
        // レスポンスを Entity に変換し UseCase に返す
        return apiClient.fetch(word: word)
            .tryMap { response -> [SearchNovelRow] in
                var searchNovelRows: [SearchNovelRow] = []
                for row in response {
                    if row.title == nil {
                        continue
                    }
                    searchNovelRows.append(SearchNovelRow(title: row.title!,
                                                          ncode: row.ncode!,
                                                          userid: row.userid!,
                                                          writer: row.writer!,
                                                          story: row.story!,
                                                          biggenre: NovelRow.bigGenreFromInt(bigGenreInt: row.biggenre!),
                                                          genre: NovelRow.genreFromInt(genreInt: row.genre!),
                                                          keyword: row.keyword!,
                                                          generalFirstup: NovelRow.dateFromString(string: row.generalFirstup!),
                                                          generalLastup: NovelRow.dateFromString(string: row.generalLastup!),
                                                          globalPoint: row.globalPoint!,
                                                          favNovelCnt: row.favNovelCnt!,
                                                          reviewCnt: row.reviewCnt!,
                                                          allPoint: row.allPoint!,
                                                          allHyokaCnt: row.allHyokaCnt!)
                    )
                }
                return searchNovelRows
            }
            .eraseToAnyPublisher()
    }
}
