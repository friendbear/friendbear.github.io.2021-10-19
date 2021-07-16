---
layout: post
auther: friendbear
title: AWS Black Belt Online Seminar (s3)
categories: [AWS]
tags: [S3, S3 Glacier]
---

## S3
* データストア
  * ストレージ（ブロック、ファイル、オブジェクト）
    * ブロック(put get http/https)

### 概要
* リージョン、AZ
  * 少なくとも3つのデータセンタ
* 用語
  * バケット
  * オブジェクト
  * キー(バケット＋キー＋バージョン)
  * メタデータ
  * リージョン(ロケーション)
* ネーミングスキーマ
  * s3://バケット名/プレフィックス/オブジェクト名
  * Data  Consistencyモデル
    * 結果整合性
  * ストレージクラス
    * STANDARD
    * STANDARD-IA
    * INTELIGENT_TIERING
    * ONEZONE_IA
    * S3 Glacier
* 操作
  * GET,PUT,LIST,COPY,DELETE,HEAD,RESTORE,SELECT
* アクセス方法
  * SDK, CLI, MC, 

### アクセス管理
* オブジェクトへのアクセスポリシー
  * IAM（ユーザポリシー)
  * 誰がアクセスできるのか(バケットポリシー)
  * ACL()
* 意図せずバケットがパブリックアクセスになるのを抑制する
  * S3 Block Public Access => default on
    * アカウントレベル、バケットレベルであらかじめ意図せずバケットがパブリックアクセスになるのを抑制する
      * BlockPublicAcls, IgnorePublicAcls, BlockPublicPolicy, RestrictPublicBuckets
* VPC Endpoint
  * VPC内のPrivateSubnetで稼働するサービスからNATGatewayを経由せずS3に
* Pre-signed Object URL(署名つきURL)
  * 一定時間のアクセスを許可
    * ExpiredIn
* Webサイトホスティング
  * リダイレクト
  * CORS
  * CloudFrontとの併用（HTTP/HTTPS）
    * Origin Access 

### 暗号化によるデータ保護
* サーバサイド暗号化
  * デフォルト暗号化
* クライアントサイド暗号化

* バージョン管理機能(Versioning)
  * バケットに対して(Enable/Disable)
* S3 Object Lock(WORM機能)
  * 一定期間の上書き、または削除ができないようにロックする
  * Retention Mode
    * コンプライアンスモード
    * ガバナンスモード(練習期間)
  * Retention Period
  * バージョニングを併用するので、見た目上の削除や上書きの動きは妨げられない

### データ管理
* ストレージクラス
  * ライフサイクル管理（オブジェクトに対してストレージクラスの変更や、削除処理に対する自動化）
* アーカイブ
  * S3 Glacierに移動（アーカイブ後、マスターはS3Glacierとなる）
* S3 Glacierへのストレージクラス間のオブジェクトの移動
* S3 Analytics
  * S3 AnalyticsをQuickSightで見る
* S3インベントリ
  * S3に入っているオブジェクトのリストをCSV,ORC（列志向）でみる
* S3バッチオペレーション<preview>
* S3イベント通知
  * S3からの実行権限の付与
  * Lamda
* CloudWatchによるメトリクス管理
* CloudTrailによるAPI管理
* Logging
* Tag
### パフォーマンスの最適化
* 大きなサイズのファイルを快適にダウンロード、アップロード
* マルチパートアップロード
* S3 Transfer Acceleration
* S3とDirect Connect
  * EC2(Proxy)->S3 VPC Endpoint
  *
* S3 Select
* リクエストレート

### 料金
* 容量の課金
* リクエストの課金
  * 細かい多数のファイルのリクエスト回数に注意


## AWS公式Webinar
<https://amzn.to/JPWebinar>

## 過去資料
<https://amzn.to/JPArchive>

## Twitter hashtag
`#awsblackbelt`

## 配信予定/申し込み
<https://amzn.to/JPWebinar>

