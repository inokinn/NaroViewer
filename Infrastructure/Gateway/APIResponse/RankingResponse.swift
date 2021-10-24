//
//  RankingResponse.swift
//  Infrastructure
//
//  Created by Nobuya Inoue on 2021/10/16.
//

struct RankingResponse: Codable {
    /// Nコード
    let ncode: String
    /// ポイント
    let pt: Int
    /// ランキング順位
    let rank: Int
}
