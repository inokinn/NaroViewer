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
    let searchNovelUseCase: SearchNovelUseCaseProtocol
    
    // DI コンテナに Service を登録
    let swinjectContainer = Container() { c in
        // フレームワーク・ドライバ
        c.register(RankingAPIClientProtocol.self) { _ in RankingAPIClient() }
        c.register(RankingRowsAPIClientProtocol.self) { _ in RankingRowsAPIClient() }
        c.register(SearchNovelAPIClientProtocol.self) { _ in SearchNovelAPIClient() }
        // インターフェイスアダプター
        c.register(RankingGatewayProtocol.self) { r in
            RankingGateway(apiClient: r.resolve(RankingAPIClientProtocol.self)!)
        }
        c.register(RankingRowsGatewayProtocol.self) { r in
            RankingRowsGateway(apiClient: r.resolve(RankingRowsAPIClientProtocol.self)!)
        }
        c.register(SearchNovelGatewayProtocol.self) { r in
            SearchNovelGateway(apiClient: r.resolve(SearchNovelAPIClientProtocol.self)!)
        }
        // ユースケース
        c.register(RankingUseCaseProtocol.self) { r in
            RankingUseCase(rankingGateway: r.resolve(RankingGatewayProtocol.self)!,
                           rankingRowsGateway: r.resolve(RankingRowsGatewayProtocol.self)!)
        }
        c.register(SearchNovelUseCaseProtocol.self) { r in
            SearchNovelUseCase(searchNovelGateway: r.resolve(SearchNovelGatewayProtocol.self)!)
        }
    }
    
    private init() {
        // ユースケースの作成
        self.rankingUseCase = self.swinjectContainer.resolve(RankingUseCaseProtocol.self)!
        self.searchNovelUseCase = self.swinjectContainer.resolve(SearchNovelUseCaseProtocol.self)!
    }
}
