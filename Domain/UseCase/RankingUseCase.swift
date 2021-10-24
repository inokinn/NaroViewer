//
//  RankingUseCase.swift
//  Domain
//
//  Created by Nobuya Inoue on 2021/10/13.
//

import Combine
import Foundation

/// RankingUseCase が外部に公開するインターフェイス
protocol RankingUseCaseProtocol: AnyObject {
    // 期間・offsetに応じたランキング取得
    func startFetch(type: Ranking.RankingType) -> AnyPublisher<Ranking, Error>
}

///// RankingUseCase の Output
//protocol RankingUseCaseOutput {
//    // TODO (Combineを使うので要らないかも)
//}

/// ランキング取得のためのインターフェイスアダプター
protocol RankingGatewayProtocol {
    func fetch(type: Ranking.RankingType) -> AnyPublisher<Ranking, Error>
}

/// ランキング内の小説情報取得のためのインターフェイスアダプター
protocol RankingRowsGatewayProtocol {
    func fetch(ranking: Ranking) -> AnyPublisher<Ranking, Error>
}

/**
 ランキング表示のための UseCase
 */
final class RankingUseCase: RankingUseCaseProtocol {
    
    let rankingGateway: RankingGatewayProtocol
    let rankingRowsGateway: RankingRowsGatewayProtocol
    
    init(rankingGateway: RankingGatewayProtocol, rankingRowsGateway: RankingRowsGatewayProtocol) {
        self.rankingGateway = rankingGateway
        self.rankingRowsGateway = rankingRowsGateway
    }
    
    func startFetch(type: Ranking.RankingType) -> AnyPublisher<Ranking, Error> {        
        return rankingGateway
            .fetch(type: type)
            .flatMap { [weak self] ranking -> AnyPublisher<Ranking, Error> in
                return (self?.rankingRowsGateway.fetch(ranking: ranking))!
            }
            .eraseToAnyPublisher()
    }
}
