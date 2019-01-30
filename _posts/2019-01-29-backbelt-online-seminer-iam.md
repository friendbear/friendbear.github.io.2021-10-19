---
layout: post
auther: friendbear
title: AWS Black Belt Online Seminar (IAM Part1, Part2)
categories: [AWS]
tags: [IAM]
---

## Identity and Access Managemet(IAM)
* AWS IAMの概要
  * プリンシパル
    * ユーザー
    * ロール
    * アプリケーション
    *
  * 認証
    * Authentication
    * AWS STS
    * MFA token
  * リクエスト
  * 認可
    * IDベースポリシー
  * アクション/オペレーション
  * AWSリソース

* IDと認証認可
*
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
* IAMロール
> AWSサービスやアプリケーション等のエンティティに対してAWSリソースの捜査権限を付与するための仕組み
  * IAMユーザーはグループに紐づかない

* 一時的なセキュリティ認証情報
  * AWS STSが動的に生成　
    * AssumeRole
    * AssumeRoleWithWebIdentity
    * AssumeRoleWithSAML
    * GetSessionToken
    *
* EC2インスタンスで実行するアプリケーションに対しロールを使用する
  * IAMロールがベストプラクティス
* ロールを使用したアクセス許可の委任の例
  * IAMロールによるクロスアカウントアクセス
  * クロスアカウントアクセス　
* IAMロールによるクロスアカウントアクセス
* クロスアカウントアクセスのためのMFA保護
* クロスアカウントアクセスにより権限管理を効率化
* Switch Role
* SAML2.0ベースのID **フェデレーション**
  * AssumeRoleWithSAML -> 一時的な認証情報の受け取り -> 一時的な認証情報の受け取り -> AWS
* SAML2.0ベースのAWSマネジメントコンソールへのSSOの動作
* Amazon Cognitoを用いたモバイルアプリのWeb IDフェデレーション

* ロールを使用したアクセス許可の委任
  * アカウント間でセキュリティ情報を共有しない

### IDと権限のライフサイクル管理

#### AWSアカウントのアクティビティの監視
  * Who, When, Where, What, What, 成功・失敗

#### Monitor Activity in Your AWS Account
  * CloudFront
  * CoudTrail
  * CloudWatch
  * Config
  * S3

#### アクセスレベル
* List, Read, Write, Permissions management
* アクセスアドバイザー
* IAMの最小限の権限に関する設定に利用(IAMエンティティ(ユーザー、グループ、ロール))が、最後にAWSサービスにアクセスした日付と日時を表示
  * Service Last Accessed Dataの利用例
* アクセスレベルを利用して、IAM権限を確認する
  `最小権限になっているか`

  * IAM認証情報レポート(Credential Report)

#### 不要な認証情報を削除する
```shell
$ aws iam generate-credential-report
$ aws iam get-credential-report
```

#### 認証情報の定期的なローテーション
  * IAMユーザーのパスワード
  * アクセスキーのローテーション

### IAM Tips

#### 初期設定
* AllUser 全ユーザを含める
* Adminグループを作り、管理者ユーザのみを含める
* Developer,Manager

  * AllUserにEC2のIPアクセス元を設定

### AWSアカウントのルートユーザパスワード

### MFAの管理
#### MFA 紛失
  <https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/id_credentials_mfa_lost-or-broken.html>

#### IAMポリシーのトラブルシューティング

### IAMアクセス権限分析の自動化の検討
```shell
$ aws iam get-service-accessed-detils --arn arn:aws:iam::xxxxx:user/amplify-user

$ aws iam get-service-last-accessed-detils --job-id `
```

## AWS公式Webinar
<https://amzn.to/JPWebinar>

## 過去資料
<https://amzn.to/JPArchive>

## Twitter hashtag
`#awsblackbelt`

## 配信予定/申し込み
<https://amzn.to/JPWebinar>

