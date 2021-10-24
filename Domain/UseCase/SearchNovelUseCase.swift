//
//  SearchNovelUseCase.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import Combine
import Foundation

/// SearchNovelUseCase が外部に公開するインターフェイス
protocol SearchNovelUseCaseProtocol: AnyObject {
    // ワードに応じた小説の取得
    func startSearch(word: String) -> AnyPublisher<[SearchNovelRow], Error>
}

/// 検索結果取得のためのインターフェイスアダプター
protocol SearchNovelGatewayProtocol {
    func fetch(word: String) -> AnyPublisher<[SearchNovelRow], Error>
}

/**
 検索結果表示のための UseCase
 */
final class SearchNovelUseCase: SearchNovelUseCaseProtocol {
    
    let searchNovelGateway: SearchNovelGatewayProtocol
    
    init(searchNovelGateway: SearchNovelGatewayProtocol) {
        self.searchNovelGateway = searchNovelGateway
    }
    
    func startSearch(word: String) -> AnyPublisher<[SearchNovelRow], Error> {
        return searchNovelGateway
            .fetch(word: word)
            .eraseToAnyPublisher()
    }
}
