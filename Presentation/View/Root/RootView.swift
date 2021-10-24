//
//  RootView.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/19.
//

import SwiftUI

struct RootView: View {
    let rankingView: RankingView
    let searchView: SearchView
    
    var body: some View {
        ZStack {
            TabView {
                rankingView
                    .tabItem {
                        VStack {
                            Image(systemName: "crown")
                            Text("ランキング")
                        }
                    }
                searchView
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("検索")
                        }
                    }
            }
            
            
            
            if rankingView.viewModel.loading {
                LoadingIndicatorView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(rankingView: RankingView(viewModel: RankingViewModel()),
                 searchView: SearchView(viewModel: SearchViewModel()))
    }
}
