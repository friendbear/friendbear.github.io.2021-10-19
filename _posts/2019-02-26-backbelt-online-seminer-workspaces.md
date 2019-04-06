---
layout: post
auther: friendbear
title: AWS Black Belt Online Seminar (Amazon WorkSpaces)
categories: [AWS]
tags: [workspaces]
---

## Amazon Workspaces
* ディスクトップ仮想化
* 概要
* セットアップとディスクトップ利用
* アーキテクチャ
* デザインパターン

### ディスクトップ仮想化(VDI)
* コストや利用までの時間、柔軟性や困難な設計・サイジングに課題
  * 利用者増減、初期投資、利用までの時間、サイジング

### 概要
#### Linux WorkSpaces
* Amazon Linux 2 + Mate

#### セルフサービス管理機能
* WorkSpacesの再起動
* ディスクサイズの増加
* コンピューティングタイプの変更
* 実行モードの切り替え
* WorkSpacesの再構築

#### Windows7/10 BYOL Workspaces
* ライセンスの持ち込み可能
* BYOLの自動化（ライセンス配信）

### セットアップとディスクトップ利用
1. AD選択
1. オプション登録
1. ユーザの作成
1. バンドルの選択
1. ユーザにバンドルを割り当て
1. WorkSpacesの設定(AlwaysOn, AutoStop, 暗号化、タグの管理)
1. レビューと起動
1. ステータス確認


1. メール送信、登録コード
1. WorkSpacesクライアントダウンロード
1. ネットワーク接続性の確認(round trip time 100ms - 250ms)
1. プロキシ設定

利用開始

Web Access for Amazon WorkSpaces
> ブラウザからのアクセス

#### アーキテクチャ
* ログインフロー
* WorkSpaces管理VPCとユーザーVPC
* デスクトップストリーミングプロトコル
  * PCoIPプロトコル
    * TCP/UDP 4172 (TCP通信制御用, UDPでストリーム)
    * 通信は暗号化されている

* WorkSpacesの冗長構成
  * 認証Gateway, Streaming Gateways
  * Directory Service(A/Z)
  * WorkSpaces(A/Z)

  ユーザボリューム24時間毎に自動でバックアップ

* Directory Service
  * AWS Directory Service
  * WorkSpacesはDirectory Service単位で管理される
    * 

* 既存ADドメインとの連携
  * AD Connectorからオンプレミスドメインにアクセス
  * 既存ADドメインをVPCに拡張、AD Connectorで認証をProxy
    * サイト AWS サイトオンプレミス
  * AWS Microsoft ADとオンプレミスADドメインとの双方向の推移的信頼関係
    * 双方向の推移的信頼関係
* トラフィックフローとネットワーク接続
  * ディスクトップストリーム（インターネット経由）
  * ディスクトップストリーム（DX Public接続経由)
    * 専用線経由
    * Direct Connect(Public Connect, Private Connect)
* WorkSpacesからのインターネットアクセス
  * Elastic IP付与
  * NAT Gateway経由
  * オンプレミスProxy経由
    * VPN Gateway - Customer Gateway - Firewall, Proxy - Internet
* ユーザー認証
  * MFA
    * RADIUSと連携
* IPアドレスによるアクセス制御
  * IPアクセスコントロール
* デバイスによるアクセス制御
  * クライアント証明書
* グループポリシーによるポリシー制御

### デザイン
#### シナリオ
* 既存AWS
* オンプレミスとクラウド上のアプリによるハイブリッドアーキテクチャ
* AWS Direct Connectを使用している
* 既存ADの利用

#### AWSアカウントの構造
* 共通サービスアカウント
  * Dev Account
  * Prod Account
  * WorkSpaces専用アカウント
#### VPC、サブネットの設計

#### ディレクトリ展開のコンセプト

#### 最終的なアーキテクチャの構成例


### まとめ
* 公開されているベストプラクティスから学ぶ

## AWS公式Webinar
<https://amzn.to/JPWebinar>

## 過去資料
<https://amzn.to/JPArchive>

## Twitter hashtag
`#awsblackbelt`

## 配信予定/申し込み
<https://amzn.to/JPWebinar>

