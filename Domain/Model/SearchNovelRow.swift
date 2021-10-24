//
//  SearchNovelRow.swift
//  NaroViewer
//
//  Created by Nobuya Inoue on 2021/10/24.
//

import Foundation

/**
 検索結果の小説リストの1要素を表す構造体
 */
public struct SearchNovelRow {
    
    /// 小説名
    let title: String
    /// Nコード
    let ncode: String
    /// 作者のユーザID (数値)
    let userid: Int
    /// 作者名
    let writer: String
    /// 小説のあらすじ
    let story: String
    /// 大ジャンル
    let biggenre: NovelRow.BigGenre
    /// ジャンル
    let genre: NovelRow.Genre
    /// キーワード
    let keyword: String
    /// 初回掲載日
    let generalFirstup: Date
    /// 最終掲載日
    let generalLastup: Date
    /// 総合評価ポイント
    let globalPoint: Int
    /// ブックマーク数
    let favNovelCnt: Int
    /// レビュー数
    let reviewCnt: Int
    /// 評価ポイント
    let allPoint: Int
    /// 評価者数
    let allHyokaCnt: Int
}
