---
layout: post
auther: freindbear
title: Computing AWS re:Invent 2018 OSAKA
---

## Computing
### CPU４種類の比較
A1 (ARMベース) Graviton 45の削減可能性

* A1 WebServer, キャッシュサーバ, 開発、コンテナマイクロサービス
* M3 バランス
* T3 急激なトラフィック向け

ワークロード用のアクセラレータ
* Elastic Graphics
* Elastic Internence


C5n(100GBPS) nネットワークが太い C5との比較
* データ転送が間に合わないなどの用途
* ネットワークキューが８から３２

ネットワーク帯域についての注意点
* シングルフロー 最大10GBPS
* マルチフロー  最大100Gbps

P3DN (GPU搭載) 3.1G Brodwall


ノード間のオーバーヘッドのため、OSレベルのパケット処理でレイテンシーが出ない問題
* EFA(デバイス 最下層) 

### Outposts(前哨基地)
通信企業はレガシーシステム連携、金融サービスやコンテンツ開発、ゲームなどはレイテンシーを上げるシステムに対して
* AWSを格納するサービス。低遅延な連携を実現するため

## ネットワーキング
### １つのIPアドレスでRegionごとフェールオーバした場合でも切り替えたいなどの要望
AWS Global Accelerator （パケット経路最適化、TCP/UDPが使える）
IPエニーキャストを用いてエッジロケーションに同じIPアドレスを振る

* マルチリージョン
* 世界中からのアクセス

アクセラレータIPの払い出し->リスナー->エンドポイントグループ

### AWS Transit Gateway
VPCピアリングしなければならなかった -> Transit Gatewayでどことどこを繋ぐかを設定できる

VPC
VPN
AWS Direct Connect
- Transit Gateway

AWS Private Link (1..n)
AWS Transit Gateway (n..n)

### VPC Sharing
* VPCの統合
AWS Organaizationの考え方が必須




