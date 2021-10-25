//
//  RankingRowView.swift
//  Presentation
//
//  Created by Nobuya Inoue on 2021/10/10.
//

import SwiftUI

struct RankingRowView: View {
    let rankingRow: RankingRow
    
    var body: some View {
        HStack {
            Text(String(rankingRow.rank))
                .font(.title2)
                .italic()
                .frame(width: 52, height: 48, alignment: .trailing)
            VStack(alignment: .leading) {
                Text(rankingRow.novel!.title)
                    .lineLimit(2)
                    .font(.caption)
                    .padding(.top, 4)
                Spacer()
                HStack {
                    Text("作者:")
                        .font(.caption2)
                        .padding(.bottom, 4)
                    Text(rankingRow.novel!.writer)
                        .font(.caption2)
                        .padding(.bottom, 4)
                    Spacer()
                }
            }
        }
    }
}

struct RankingRowView_Previews: PreviewProvider {
    static var previews: some View {
        let rankingRow = RankingRow(
            ncode: "xxx",
            pt: 123,
            rank: 300,
            novel: RankingNovelRow(
                title: "俺の妹がこんなに可愛いわけがない",
                ncode: "xxx",
                userid: 1234,
                writer: "島津豊久",
                story:  "ある日、森の中、くまさんに、出会った。",
                biggenre: .Love,
                genre: .Genjitsu,
                keyword: "異世界転生",
                generalFirstup: Date(),
                generalLastup: Date(),
                globalPoint: 111,
                dailyPoint: 222,
                weeklyPoint: 333,
                monthlyPoint: 444,
                quarterPoint: 555,
                yearlyPoint: 666
            )
        )
        RankingRowView(rankingRow: rankingRow)
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
