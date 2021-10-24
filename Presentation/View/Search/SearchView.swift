//
//  SearchView.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/25.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var searchWord = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack {
                        TextField("検索ワードを入力してね", text: $searchWord)
                        Button(action: {
                            self.loadSearch()
                        }) {
                            Image(systemName: "arrow.turn.down.left")
                        }
                    }
                    List {
                        if viewModel.searchResults.count > 0 {
                            ForEach(0..<viewModel.searchResults.count) { num in
                                SearchRowView(searchNovelRow: viewModel.searchResults[num])
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
                .navigationBarTitle(Text("検索"), displayMode: .inline)
                    .navigationBarItems(
                        trailing: Button(action: {
                            self.loadSearch()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    )
            }
            
            if self.viewModel.loading {
                LoadingIndicatorView()
            }
        }
    }
    
    func loadSearch() {
        viewModel.fetchSearchResult(word: self.searchWord)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchViewModel()
        SearchView(viewModel: viewModel)
    }
}
