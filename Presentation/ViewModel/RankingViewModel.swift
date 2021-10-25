//
//  RankingViewModel.swift
//  Presentation
//
//  Created by Nobuya Inoue on 2021/10/18.
//

import SwiftUI
import Combine

final class RankingViewModel: ObservableObject, Identifiable {
    
    @Published var ranking: Ranking = Ranking(rowList: [])
    @Published var loading: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    
    // ランキングの取得
    func fetchRanking(type: Ranking.RankingType) {
        self.loading = true
        self.ranking = Ranking(rowList: [])
        AppBuilder.shared.rankingUseCase.startFetch(type: type)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.loading = false
                switch completion {
                case .finished: break
                case .failure(_):
                    // TODO: エラーハンドリング
                    break
                }
            },
            receiveValue: { [weak self] ranking in
                self?.ranking = ranking
            })
            .store(in: &disposables)
    }
}
