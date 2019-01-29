---
layout: post
auther: friendbear
title: AWS Black Belt Online Seminar (IAM Part1)
categories: [AWS]
tags: [IAM]
---

## Identity and Access Managemet

* AWS IAMの概要
  * プリンシパル
    * ユーザー
    *
  * 認証
  * リクエスト
  * 認可
  * アクション/オペレーション
  * AWSリソース

* IDと認証認可
### IDと認証情報の管理
* ROOT ACCOUNTのアクセスキーをロックする
* IAM ユーザー
* ユーザーの強力なパスワードポリシーを設定
* アクセスキーを共有しない
* 特権ユーザーに対してMFAを有効化する
  - <https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/id_credentials_mfa.html>

### アクセス権の管理
* AWS管理ポリシーを利用したアクセス許可の使用開始
  * ポリシー
    * アイデンティティベースのポリシー
      * AWS管理ポリシー
      * カスタマー管理ポリシー　
    * インラインポリシー
  * リソースベースのポリシー
  * パーミッションバウンダリー
  * ACL
* インラインポリシーではなくカスタマー管理ポリシーを利用する
* ポリシードキュメントの主な要素
  * ポリシードキュメントの主な要素
    * Principal要素
    * Action要素
    * Resource要素
    * Condition要素
  * IAMポリシー評価ツール

* 最小権限を付与する
  * AWS Organization サービスコントロールポリシー(SCP)

* IAMグループ
  * IAMユーザーの集合
  * ポリシーの関連付けを簡単にするためにIAMグループを利用する

### 権限の委任

### IDと権限のライフサイクル管理
