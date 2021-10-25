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
                    SearchBar(text: $searchWord) {
                        self.loadSearch()
                    }
                    List {
                        if viewModel.searchResults.count > 0 {
                            ForEach(viewModel.searchResults, id: \.ncode) { result in
                                NavigationLink(destination: WebView(targetUrlString: "https://ncode.syosetu.com/" + result.ncode + "/")) {
                                    SearchRowView(searchNovelRow: result)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .navigationBarTitle(Text("検索"), displayMode: .inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
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
