---
layout: post
title:  Black Belt Online Seminar Amazon Simple Notification Service (SNS)
author: friendbear
---

## SNS
### 概要
* 独立分散型 + ポーリング
* 独立分散型 + ファンアウト(fan out)

* Publisher - SNS - Subscriber
  * MessageやTopicの設定、操作、及び送信ができる
  * pub-subは定期的なポーリングを行う必要のないpush通知メカニズムを使ってfan outできる
  * HTTP/S や絵メールなどの複数のプロトコルに対応

Topic Owner(所有者)

Publisher -> Topic -> Filter policy -> Subscriber

#### Publicher
* TopicにMessageを送信
* Subscriberの購読プロトコルごとに、messageをカスタマイズして発行できる
* PublicherとしてAWS Step FunctionsやCloudWatch Eventsなども指定できる

#### 配信プロトコル

#### API
* Topic Owner
  * CreateTopic
  * DeleteTopic
  * ListTopics

* Subscriber
  * Subscribe
  * ConfirmSubscription
  * Unsubscibe

* Publisher
  * Publish


### 始め方(Email)

#### Topicのアクセスコントロール
* Topic OwnerはAccess policyを通じて誰がTopicにアクセスしているのかコントロール

#### SubscriberによるFilter Policy

#### Filter Policyの設定

* MessageAttributesを指定し発行
*

#### row messageの配信
* Subscriberは、SQS及びHTTP/Sへの配信時に、raw形式、つまりPublishされた通りにmessageが配信されるようにオプトインすることができる。
*
#### SNS のRetry Policy
* すべてのメッセージは直ちに配信
* ４段階のRetry Policy
* Retry Policyはエンドポイントによって、異なる。
* 発行messageの信頼性を高めたい場合、SQSにも配信されるように設計する。


...
### Mobile通知
#### SNS Mobile PushとAmazon Pinpointとの使い分け
* デバイストークンの管理
* 分析、セグメント


