---
layout: post
title: AWS Fee structure
categories: [AWS]
tags: [Cost]
---

## リザーブドインスタンス
AURI, PURI, NURI
前払いの額が大きいほど安くなる

ボリュームディスカウント
しようすればするほど安くなる
データの受信は無料
ストレージではパフォーマンスに応じてコスト削減
AWSの料金値下げ
FreeTier　新規ユーザ
## No extra costs
* VPC
* Beanstalk
* CloudFormation
* IAM
* Auto Scaling
* OpsWorks（アプリケーション管理サービス）
## 料金設定に関する設定
https://aws.amazon.com/priceng

## AWSのスケールメリット
事業拡大に伴い値下げしていくこと

# 料金に対する詳細情報
## No charge
Data Transfer in
Data Transfer Between 全リージョンをまたがる

## 検討時間
On-demand, Reserved, Spot　インスタンス

CloudWatch 
No additional cost
Option 7つ

EIPは料金に含まれている

Windowsなどのライセンスはお客様が準備する

## S3
Standard Strage
9.99999999 durability
9.99 availability

IOPSは考慮されない

PUT, COPYで料金が違う

## EBS
ブロックストレージ
General Purpose
Provisioned IOPS
Magnetic

月辺りのギガバイト
IOPS
リクエストの数に応じて課金
Snapshots
GB/月
Data Transfer
着信は無料

## RDS
リソースの実行時間
データベース特性
By the hour
リザーブドインスタンス
月、年
DBストップしてもバックアップストレージの課金が発生
Multiple Availability Zones
Inbound data transfer is free
Outbound data transfer costs are tiered

## CloudFront
Low latency

地理的リージョン、エッジロケーションにより異なる

## AWS ウェブアプリケーションファイアウォール(WAF)
無料枠の対象外

基礎的な見積もりの方法を理解し、AWSに公開されている情報と照らし合わせる

## TCO Calculator
AWS Total Cost of Ownership
https://awstcocalculator.com/


# AWS サポートプランの概要
検討中、クリティカルに使用されている、
## Technical account manager(TAM)
アドバイス、アーキテクチャのレビュー、専任の担当者
## Best practices
Trusted Advisor （オンラインリソース）
## Account assistance
Support Concierge

## Support Plans
Basic
Business
Developer
Enterprise

