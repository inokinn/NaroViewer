//
//  RankingView.swift
//  Presentation
//
//  Created by Nobuya Inoue on 2021/10/18.
//

import SwiftUI
import Combine

struct RankingView: View {
    @ObservedObject var viewModel: RankingViewModel
    @State var rankingType = Ranking.RankingType.Daily
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Picker(selection: $rankingType, label: Text("選んでね")) {
                        Text(Ranking.RankingType.Daily.rawValue).tag(Ranking.RankingType.Daily)
                        Text(Ranking.RankingType.Weekly.rawValue).tag(Ranking.RankingType.Weekly)
                        Text(Ranking.RankingType.Monthly.rawValue).tag(Ranking.RankingType.Monthly)
                        Text(Ranking.RankingType.Quarter.rawValue).tag(Ranking.RankingType.Quarter)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: rankingType) { tag in
                        self.loadRanking()
                    }
                    
                    List {
                        if viewModel.ranking.rowList.count > 0 {
                            ForEach(viewModel.ranking.rowList, id: \.ncode) { row in
                                //RankingRowView(rankingRow: row)
                                NavigationLink(destination: WebView(targetUrlString: "https://ncode.syosetu.com/" + row.ncode + "/")) {
                                    RankingRowView(rankingRow: row)
                                }
                            }
                        }
                        else {
                            if viewModel.loading {
                                VStack {
                                    Spacer()
                                    Text("読み込み中…")
                                    Spacer()
                                }
                            }
                            else {
                                VStack {
                                    Spacer()
                                    Text("データの取得に失敗しました")
                                    Spacer()
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .navigationBarTitle(Text("ランキング"), displayMode: .inline)
                    .navigationBarItems(
                        trailing: Button(action: {
                            self.loadRanking()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    )
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                if viewModel.ranking.rowList.count == 0 {
                    self.loadRanking()
                }
            }
            
            if self.viewModel.loading {
                LoadingIndicatorView()
            }
        }
    }
    
    func loadRanking() {
        viewModel.fetchRanking(type: self.rankingType)
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RankingViewModel()
        RankingView(viewModel: viewModel)
    }
}
