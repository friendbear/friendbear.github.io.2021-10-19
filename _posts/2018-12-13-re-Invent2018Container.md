---
layout: post
auther: freindbear
title: Container AWS re:Invent 2018 OSAKA
---

## Container
### AWS Cloud Map
サービスディスカバリー 
LBやALBに対応していないものの対応の必要性 SQS

アクセスすべきリソースの論理名がデプロイメントステージごとに影響を受ける

ARN、IAM、
https://ap-northeast-1.console.aws.amazon.com/cloudmap/home?region=ap-northeast-1#

```shell
aws servicediscovery discover-instances --namespace-name mydata.aws --service-name mydynamodb --query-parameters VERSION=1.0,STAGE=test`
```
1. ネームスペースを定義
2. リソースの登録
3. サービスの属性を登録



### AWS App Mesh

サービスメッシュとは
> Microservices
> * 自律的なチームによる開発・運用
> * Polyglot(-able) サービスの単位
> * 各サービスが独立スケール
> * APIによる外部サービスと連携

Microserviceの課題

Option2 - プロキシへのオフロード

Envoy Proxy(Amazon CloudWatch AWS X-Ray Envoyとの連携可能なサードパーティのモニタリング・トレーシング群)


