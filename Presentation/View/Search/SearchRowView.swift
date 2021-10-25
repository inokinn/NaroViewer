//
//  SearchRowView.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/24.
//

import SwiftUI

struct SearchRowView: View {
    let searchNovelRow: SearchNovelRow
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(searchNovelRow.title)
                    .lineLimit(2)
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.top, 4)
                Spacer()
                HStack {
                    Text("作者:")
                        .font(.caption2)
                        .padding(.bottom, 4)
                    Text(searchNovelRow.writer)
                        .font(.caption2)
                        .padding(.bottom, 4)
                    Spacer()
                }
                Text(searchNovelRow.story)
                    .lineLimit(3)
                    .font(.caption2)
                Spacer()
                HStack {
                    Text("最終更新日: " + self.stringFromDate(date: searchNovelRow.generalLastup))
                        .font(.caption2)
                        .padding(.bottom, 4)
                    Text("レビュー数: " + String(searchNovelRow.reviewCnt))
                        .font(.caption2)
                        .padding(.bottom, 4)
                }
                HStack {
                    VStack {
                        Text("総合pt")
                            .font(.caption2)
                            .bold()
                            .foregroundColor(.red)
                        Text(String(searchNovelRow.globalPoint) + "pt")
                            .font(.caption2)
                            .bold()
                            .padding(.bottom, 4)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    VStack {
                        Text("ブックマーク")
                            .font(.caption2)
                        Text(String(searchNovelRow.favNovelCnt) + "件")
                            .font(.caption2)
                            .padding(.bottom, 4)
                    }
                    Spacer()
                    VStack {
                        Text("評価人数")
                            .font(.caption2)
                        Text(String(searchNovelRow.allHyokaCnt) + "人")
                            .font(.caption2)
                            .padding(.bottom, 4)
                    }
                    Spacer()
                    VStack {
                        Text("評価pt")
                            .font(.caption2)
                        Text(String(searchNovelRow.allPoint) + "pt")
                            .font(.caption2)
                            .padding(.bottom, 4)
                    }
                }
            }
        }
    }
    
    func stringFromDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}

struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        let searchNovelRow = SearchNovelRow(title: "俺の妹がこんなに可愛いわけがない",
                                            ncode: "123456789",
                                            userid: 123456789,
                                            writer: "田所浩二",
                                            story: "試合を終えて家路へ向かうサッカー部員達。疲れからか、不幸にも黒塗りの高級車に追突してしまう。後輩をかばいすべての責任を負った三浦に対し、車の主、暴力団員谷岡が言い渡した示談の条件とは…。",
                                            biggenre: .Love,
                                            genre: .Genjitsu,
                                            keyword: "BL",
                                            generalFirstup: Date(),
                                            generalLastup: Date(),
                                            globalPoint: 8765,
                                            favNovelCnt: 123,
                                            reviewCnt: 456,
                                            allPoint: 789,
                                            allHyokaCnt: 9999)
        SearchRowView(searchNovelRow: searchNovelRow).previewLayout(.fixed(width: 400, height: 200))
    }
}
