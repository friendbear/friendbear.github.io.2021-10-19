---
layout: post
auther: freindbear
title: Database AWS re:Invent 2018 OSAKA
---

## Database
### Quantum Ledger Database
台帳データベース
全てのデータ変更を正確に順序つけられたエントリーとして格納；
内部的には追記のみが行われ、各エントリーは変更不可能

* 変更不可能
* 暗号学に基づいた検証が可能
* 高いスケーラビリティ

ブロックチェーンフレームワーク

UseCase
* ヘルスケア、
* 政府機関
  各種履歴の
* 製造業
  リコールされた製品の製造履歴を追跡
* 人事部門

台帳を実現する際の課題

RDBMでの監査テーブルの場合
* ブロシージャーの作成、管理
* 管理者による変更・削除

ブロックチェーン
* 不必要な複雑さ
* 低いスループット
* 複雑なメンテナンス

上記のような仕組みまで不要ではないかという場合でのQLDB

信頼された中央機関が必要
台帳は信頼された中庸期間が所有

#### 構成要素
L　台帳データベース
J ジャーナル
C|H 現在地|履歴

台帳が構成される {現在地|履歴、ジャーナル}

J (Hash) ->-> H -> C
更新時
J + J (Hash) -> -> C -> H + H

* SQLライク
* ACIDサポート
* 追加できるジャーナルデータ
* 改ざん

### Managed Blockchain
Hyperledger Fabric Ethereumのオープンソースをフルマネージドした

信頼された中央機関が不要
台帳は複数組織で分散管理
ブロックチェーンネットワークを構築


### Timestream

大量に発生する時系列データの追加に特化したデータベース

時系列データの分析に最適化
1日１兆件のInsert

#### 用途
* IoTアプリケーション
* 産業テメレトリ
 　
* DevOps
 
### RDS on VMWare
* VMWare場でAmazonRDS
* 対採用にRDS on VMwareのスタンバイやリードレプリカをAWSに構築するハイブリッドクラウドを構成可能

* Shift Lift オンプレミスデータベースをRDS on VMwareからRDS on VMWareに載せ替える

## 既存アップデート情報

### Aurora MySQL: Global Databases
クロスリージョンリードレプリカが強化されGlobal　Databaseに

ストレージレベルでレプリケーション

>  プライマリは1台
>  セカンダリにできるリージョンは１つ
>  プライマリインスタンスが障害発生した場合はプライマリ側で昇格する
>  
### Amazon Aurora: Custom endpoints
オンライン用のカスタムエンドポイント、分析用のエンドポイント
ユースケースに応じてエンドポイントを複数持てるようになった

### Aurora Serverless: Data API
LambdaやAWS AppSyncからVPCにアクセスすることなく JSONで

### PostgreSQL 10 Compatibility
* ネイティブパーティショニング（宣言的パティーション）が使用可能

### AlwaysOn availability group SQL Server

### DynamoDB: Transactions
複数テーブルに対する読み書きでACIDトランザクションをサポート



