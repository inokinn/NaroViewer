//
//  Ranking.swift
//  Domain
//
//  Created by Nobuya Inoue on 2021/10/13.
//

import Foundation

/**
 ランキングを表す構造体
 */
public struct Ranking {
    public enum RankingType: String {
        case Daily = "日間"
        case Weekly = "週間"
        case Monthly = "月間"
        case Quarter = "四半期"
    }
    
    private(set) var rowList: [RankingRow]
    
    public init(rowList: [RankingRow]) {
        self.rowList = rowList
    }
}
