//
//  AppBuilder.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/18.
//

import Swinject

final class AppBuilder {
    
    static let shared = AppBuilder()
    let rankingUseCase: RankingUseCaseProtocol
    
    // DI コンテナに Service を登録
    let swinjectContainer = Container() { c in
        // フレームワーク・ドライバ
        c.register(RankingAPIClientProtocol.self) { _ in RankingAPIClient() }
        c.register(RankingRowsAPIClientProtocol.self) { _ in RankingRowsAPIClient() }
        // インターフェイスアダプター
        c.register(RankingGatewayProtocol.self) { r in
            RankingGateway(apiClient: r.resolve(RankingAPIClientProtocol.self)!)
        }
        c.register(RankingRowsGatewayProtocol.self) { r in
            RankingRowsGateway(apiClient: r.resolve(RankingRowsAPIClientProtocol.self)!)
        }
        // ユースケース
        c.register(RankingUseCaseProtocol.self) { r in
            RankingUseCase(rankingGateway: r.resolve(RankingGatewayProtocol.self)!,
                           rankingRowsGateway: r.resolve(RankingRowsGatewayProtocol.self)!)
        }
    }
    
    private init() {
        // ユースケースの作成
        self.rankingUseCase = self.swinjectContainer.resolve(RankingUseCaseProtocol.self)!
    }
}
