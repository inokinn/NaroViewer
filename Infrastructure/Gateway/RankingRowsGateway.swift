//
//  RankingRowsGateway.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/19.
//

import Combine
import Foundation

protocol RankingRowsAPIClientProtocol {
    func fetch(ncode: String) -> AnyPublisher<[RankingRowsResponse], Error>
}

final class RankingRowsGateway: RankingRowsGatewayProtocol {
    let apiClient: RankingRowsAPIClientProtocol
    
    init(apiClient: RankingRowsAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetch(ranking: Ranking) -> AnyPublisher<Ranking, Error> {
        // ランキングからNコードのリクエスト文字列に変換
        var ncode = ""
        for rankingRow in ranking.rowList {
            ncode += rankingRow.ncode + "-"
        }
        
        return apiClient.fetch(ncode: ncode)
            .tryMap {response -> Ranking in
                var newRankingRows: [RankingRow] = []
                
                for rankingRow in ranking.rowList {
                    for responseRow in response {
                        if responseRow.title == nil {
                            continue
                        }
                        
                        if rankingRow.ncode == responseRow.ncode {
                            let novel = RankingNovelRow(
                                title: responseRow.title!,
                                ncode: responseRow.ncode!,
                                userid: responseRow.userid!,
                                writer: responseRow.writer!,
                                story: responseRow.story!,
                                biggenre: NovelRow.bigGenreFromInt(bigGenreInt: responseRow.biggenre!),
                                genre: NovelRow.genreFromInt(genreInt: responseRow.genre!),
                                keyword: responseRow.keyword!,
                                generalFirstup: NovelRow.dateFromString(string: responseRow.generalFirstup!),
                                generalLastup: NovelRow.dateFromString(string: responseRow.generalLastup!),
                                globalPoint: responseRow.globalPoint!,
                                dailyPoint: responseRow.dailyPoint!,
                                weeklyPoint: responseRow.weeklyPoint!,
                                monthlyPoint: responseRow.monthlyPoint!,
                                quarterPoint: responseRow.quarterPoint!,
                                yearlyPoint: responseRow.yearlyPoint!)
                            newRankingRows.append(RankingRow(ncode: rankingRow.ncode, pt: rankingRow.pt, rank: rankingRow.rank, novel: novel))
                        }
                    }
                }
                return Ranking(rowList: newRankingRows)
            }
            .eraseToAnyPublisher()
    }
}
