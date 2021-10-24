//
//  RankingGateway.swift
//  Infrastructure
//
//  Created by Nobuya Inoue on 2021/10/14.
//

import Foundation
import Combine

protocol RankingAPIClientProtocol {
    func fetch(rtype: String) -> AnyPublisher<[RankingResponse], Error>
}

final class RankingGateway: RankingGatewayProtocol {
    let apiClient: RankingAPIClientProtocol
    
    init(apiClient: RankingAPIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetch(type: Ranking.RankingType) -> AnyPublisher<Ranking, Error> {
        // type をパラメータの rtype に変換
        var rtype = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier: "ja_JP")
        
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.dateFormat = "EEEEE"
        weekDayFormatter.locale = Locale(identifier: "ja_JP")

        // 月初を取得
        var components = Calendar.current.dateComponents([.year, .month, .day],from: Date())
        components.day = 1
        let firstDay =  Calendar.current.date(from: components)!
        
        switch type {
        case .Daily:
            // "yyyyMMdd-d" の形に変換
            rtype = dateFormatter.string(from: Date()) + "-d"
            break
        case .Weekly:
            // 火曜日を特定した後、 "yyyyMMdd-w" の形に変換
            var targerDay = Date()
            while weekDayFormatter.string(from: targerDay) != "火" {
                targerDay = Calendar.current.date(byAdding: .day, value: -1, to: targerDay)!
            }
            
            rtype = dateFormatter.string(from: targerDay) + "-w"
            break
        case .Monthly:
            // 月初を特定した後、 "yyyyMMdd-m" の形に変換
            rtype = dateFormatter.string(from: firstDay) + "-m"
            break
        case .Quarter:
            // 月初を特定した後、 "yyyyMMdd-q" の形に変換
            rtype = dateFormatter.string(from: firstDay) + "-q"
            break
        }
        print(rtype)
        
        // レスポンスを Entity に変換し UseCase に返す
        return apiClient.fetch(rtype: rtype)
            .tryMap { response -> Ranking in
                var rankingRows: [RankingRow] = []
                for row in response {
                    rankingRows.append(RankingRow(ncode: row.ncode, pt: row.pt, rank: row.rank, novel: nil))
                }
                return Ranking(rowList: rankingRows)
            }
            .eraseToAnyPublisher()
    }
}
