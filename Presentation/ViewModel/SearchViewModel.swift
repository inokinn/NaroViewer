//
//  SearchViewModel.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject, Identifiable {
    
    @Published var searchResults: [SearchNovelRow] = []
    var loading: Bool = false
    
    private var disposables = Set<AnyCancellable>()
    
    // 検索結果の取得
    func fetchSearchResult(word: String) {
        self.loading = true
        self.searchResults = []
        AppBuilder.shared.searchNovelUseCase.startSearch(word: word)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("検索成功")
                    self.loading = false
                case .failure(let error):
                    print("検索エラー")
                    print(error)
                    self.loading = false
                }
            },
            receiveValue: { [weak self] results in
                self?.searchResults = results
            })
            .store(in: &disposables)
    }
}
