---
layout: post
auther: freindbear
title: AWS Loft Tokyo (amazon pay)
categories: [AWS]
tags: [AWS, amazon pay]
---
## amazon pay
実店舗でも実装可能。Amazon Payで実現するキャッシュレス社会
## Overview

Amazon.co.jp
Active User: 1652, 3558

## 使命
On-Amazon, Off-Amazon

### 導入実績
* 寄付
* EC
* 赤十字など

### 使い方

### 
決済金額のみ、商品情報は利用されない

### 申し込み
公式HPから
IDキーが発行される。

#### 審査あり
* 武器
* マネーロンダリング

### Web
#### API
* 金額確定、取引承認、Authorise

#### Sandbox あり

### 取得情報
* ユニークなユーザID
* 名前
* Eメールアドレス
* 郵便番号

+ アドレス帳から

> コネクテッドコマースの世界

## Alexa
Alexaスキル向けAmazon Payの概要
* Amazonアカウントのデフォルトお届け先住所
*
*

### Connected Commerceについて
#### Voiseコマースは通常の買い物をサポートする。
> PCを開く手間をAlexaで実現したい

* 単純なことはAlexsにお願いする
#### 開発の観点でメリット
* 注文管理の処理がすでに存在する
* 
* レコメンド

### スキル開始するためには
* Amazon開発者アカウント
* Amazon Payの販売者アカウント
* AWSアカウント（Optional) why ? => Lamda

### スキルを作成
* Alexaのインテント、発話、スロット
  * インテント => call lamda
  * スロット => 変数
  *
### API
* Setup API
* Charge API
* 購入者指定のクレジットカードに請求
* 余震確保のみも可能


#### Connectionsの仕組み
user -> Alexa Frame work skill -> 販売者さまのスキル -> user & 販売者のやりとり -> Setup API or Charge API -> Response -> Thanks


<https://pay.amazon.com/jp/developer/documentation>

#### チャネル
#### AutoPay
#### Onetime Pay

## QR Code
### ユーザーエクスペリエンス
* Amazon-Pay server
  * mPOS
  * POS
    * Push Notifications

### Demo
* PC-Smartdevice

### システム構成イメージ
APP API
AMZN API
Payment GW

### Amazon App
Barcode
every 30sec

### API シーケンス

### 


