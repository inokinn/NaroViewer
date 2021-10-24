//
//  RootView.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/19.
//

import SwiftUI

struct RootView: View {
    let rankingView: RankingView
    
    var body: some View {
        TabView {
            rankingView
                .tabItem {
                    VStack {
                        Image(systemName: "crown")
                        Text("ランキング")
                    }
                }
            Text("検索画面")
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("検索")
                    }
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(rankingView: RankingView(viewModel: RankingViewModel()))
    }
}
