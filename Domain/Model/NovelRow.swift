//
//  NovelRow.swift
//  Domain
//
//  Created by Nobuya Inoue on 2021/10/11.
//

import Foundation

/**
 小説リストの1要素を表す構造体
 */
public struct NovelRow {
    
    /**
     小説の大ジャンル
     */
    enum BigGenre: String {
        case Love = "恋愛"
        case Fantasy = "ファンタジー"
        case Literature = "文芸"
        case SF = "SF"
        case Other = "その他"
        case NonGenre = "ノンジャンル"
    }
    
    /**
     小説のジャンル
     */
    enum Genre: String {
        case Isekai = "異世界（恋愛）"
        case Genjitsu = "現実世界（恋愛）"
        case HighFantasy = "ハイファンタジー（ファンタジー）"
        case LowFantasy = "ローファンタジー（ファンタジー）"
        case Junbungaku = "純文学（文芸）"
        case Human = "ヒューマンドラマ（文芸）"
        case History = "歴史（文芸）"
        case Detective = "推理（文芸）"
        case Horror = "ホラー（文芸）"
        case Action = "アクション（文芸）"
        case Comedy = "コメディー（文芸）"
        case VRGame = "VRゲーム（SF）"
        case Galaxy = "宇宙（SF）"
        case FantasyScience = "空想科学（SF）"
        case Panic = "パニック（SF）"
        case FairyTale = "童話（その他）"
        case Poetry = "詩（その他）"
        case Essay = "エッセイ（その他）"
        case Replay = "リプレイ（その他）"
        case Other = "その他（その他）"
        case NonGenre = "ノンジャンル（ノンジャンル）"
        
    }
    
    /**
     小説タイプ（連載か短編か）
     */
    enum NovelType {
        case Series
        case ShortStory
    }
    
    /// 少説名
    let title: String
    /// Nコード
    let ncode: String
    /// 作者のユーザID(数値)
    let userid: Int
    /// 作者名
    let writer: String
    /// 小説のあらすじ
    let story: String
    /// 大ジャンル
    let biggenre: BigGenre
    /// ジャンル
    let genre: Genre
    /// キーワード
    let keyword: String
    /// 初回掲載日
    let generalFirstup: Date
    /// 最終掲載日
    let generalLastup: Date
    /// ノベルタイプ
    let novelType: NovelType
    /// 終了フラグ
    let End: Bool
    /// 全掲載部分数
    let generalAllNo: Int
    /// 小説文字数
    let length: Int
    /// 読了時間（分単位）
    let time: Int
    /// 長期連載停止フラグ
    let isstop: Bool
    /// R15フラグ
    let isR15: Bool
    /// ボーイズラブフラグ
    let isBL: Bool
    /// ガールズラブフラグ
    let isGL: Bool
    /// 残酷な描写フラグ
    let isZankoku: Bool
    /// 異世界転生フラグ
    let isTensei: Bool
    /// 異世界転移フラグ
    let isTenni: Bool
    /// 総合評価ポイント
    let globalPoint: Int
    /// 日間ポイント
    let dailyPoint: Int
    /// 週間ポイント
    let weeklyPoint: Int
    /// 月間ポイント
    let montylyPoint: Int
    /// 四半期ポイント
    let quarterPoint: Int
    /// 年間ポイント
    let yearlyPoint: Int
    /// ブックマーク数
    let favNovelCnt: Int
    /// 感想数
    let impressionCnt: Int
    /// レビュー数
    let reviewCnt: Int
    /// 評価ポイント
    let allPoint: Int
    /// 評価者数
    let allHyokaCnt: Int
    /// 挿絵の数
    let sasieCnt: Int
    /// 会話率
    let kaiwaRitu: Int
    /// 小説の更新日時
    let novelUpdatedAt: Date
    /// 最終更新日時
    let updatedAt: Date
    
    static func bigGenreFromInt(bigGenreInt: Int) -> BigGenre {
        switch bigGenreInt {
        case 1:
            return .Love
        case 2:
            return .Fantasy
        case 3:
            return .Literature
        case 4:
            return .SF
        case 98:
            return .NonGenre
        default:
            return .Other
        }
    }
    
    static func genreFromInt(genreInt: Int) -> Genre {
        switch genreInt {
        case 101:
            return .Isekai
        case 102:
            return .Genjitsu
        case 201:
            return .HighFantasy
        case 202:
            return .LowFantasy
        case 301:
            return .Junbungaku
        case 302:
            return .Human
        case 303:
            return .History
        case 304:
            return .Detective
        case 305:
            return .Horror
        case 306:
            return .Action
        case 307:
            return .Comedy
        case 401:
            return .VRGame
        case 402:
            return .Galaxy
        case 403:
            return .FantasyScience
        case 404:
            return .Panic
        case 9901:
            return .FairyTale
        case 9902:
            return .Poetry
        case 9903:
            return .Essay
        case 9904:
            return .Replay
        case 9801:
            return .NonGenre
        default:
            return .Other
        }
    }
    
    static func dateFromString(string: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: string)!
    }
}
