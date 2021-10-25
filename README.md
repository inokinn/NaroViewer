# About NaroViewer
「小説家になろう」のビューワーアプリです。

# アーキテクチャ構成

MVVM + Clean Architecture

![なろうアーキテクチャ](https://user-images.githubusercontent.com/834569/138636515-d5f9bc1c-e270-4612-8f05-89ec6aae93d1.png)

## ルール

- レイヤー間の依存は下位 -> 上位に限定します
- レイヤーは `Domain` 、 `Presentation` 、 `Infrastructure` の 3 層構成にしていますが<br>Clean Architecture の同心円状の分割方式にも準拠しています<br>( `Entity` 、 `UseCase` 、 `Interface Adapter` 、 `Framework & Driver` )
  - これについても、依存の方向は下位 -> 上位のみとします
- データの受け取りは Combine を用いたデータバインディングにて行います

## Module 解説

### Domain

ドメインロジックを集約したレイヤー。

| 名前 | 分類 | 概要 |
|----|----|----|
|Model | Entity | 他のレイヤーには一切依存しない、データ構造。 |
|UseCaseProtocol | UseCase | 下位レイヤーに公開する、ビジネスロジックのインターフェース。 |
|UseCase | UseCase | ビジネスロジックの実装。 |
|GatewayProtocol | UseCase | 下位レイヤーである Gateway を参照するためのインターフェース。 |

### Presentation

View およびプレゼンテーションロジックを集約したレイヤー。

| 名前 | 分類 | 概要 |
|----|----|----|
|ViewModel | Interface Adapter | ビューモデル。 View は ViewModel のデータをバインディングする。 |
|View | Framework & Driver | SwiftUI View 。 |

### Infrastructure

外部との通信やデータの永続化を行うレイヤー。<br>
（データの永続化は未実装だが）

| 名前 | 分類 | 概要 |
|----|----|----|
|Gateway | Interface Adapter | UseCase と Framework & Driver の橋渡し役を担う。<br>UseCase から渡された入力を API のリクエストに変換したり、APIResponse を Model に変換したりする。 |
|APIResponse | Interface Adapter | API が受け取る結果を表すデータ構造。 |
|APIClientProtocol | Interface Adapter | 下位レイヤーである APIClient を参照するためのインターフェース。 |
|APIRequest | Framework & Driver | API へのリクエスト内容を保持するクラス。 |
|APIClient | Framework & Driver | APIRequest を作成して、 APIAccessPublisher に通信を依頼する。 |
|APIAccessPublisher | Framework & Driver | Alamofire を用いて、実際に API 通信を行う。<br>通信が終了したら、 Combine によって結果を Publish する。 |

# ビルド方法

clone したら、下記のコマンドを実行します。

```
// 環境構築
make bootstrap
```

```
// .xcodeproj 作成
make project
```
