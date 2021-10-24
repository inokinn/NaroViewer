//
//  RankingRow.swift
//  Domain
//
//  Created by Nobuya Inoue on 2021/10/13.
//

import Foundation

/**
 ランキング1要素を表す構造体
 */
public struct RankingRow {
    /// Nコード
    let ncode: String
    /// ポイント
    let pt: Int
    /// ランキング順位
    let rank: Int
    /// 小説情報
    let novel: RankingNovelRow?
}
