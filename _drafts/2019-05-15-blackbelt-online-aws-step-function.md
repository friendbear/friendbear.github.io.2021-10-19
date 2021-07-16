---
layout: post
title: AWS Blackbelt online AWS Step Functions
author: friendbear
category: [lambda]
tags: [aws, lambda, step-functions]
---


## AWS Step Functions (60m)


### 概要

Twelve-Factor App モダンなアプリ開発のベストプラクティス
* プロセス

オーケストレータとして機能する。

* ステートマシンと呼ばれる仕組みでオーケストレート
* AWSコンソールからワークフロー可視化
* ロギング

### ステートマシーン

日常のステートマシンの例：自動販売機の例
* 3つのプロセス
  * 入金待ち
  * ジュースの選択
  * ジュースの払い出し、釣り銭の払い出し

#### ステートマシンの作成
ASL(Amazon States Language)と呼ばれるJSON形式での言語でワークフローを定義

#### ASLのチェックツール
[awslabs/statelint](https://github.com/awslabs/statelint)

### Step Functionsにおけるステートマシンの例
* メタデータの抽出
* 画像フォーマットの検証
* メタデータの保存
* 画像解析とサムネイル
* タグの付与

### ステートマシンの実行方法（呼び出し元）

* CloudWath Events
* API Gateway
* Management Console
* CLI
*

### ステートマシンから呼び出し可能なAWSのサービス
* Batch
* Lambda
* DynamoDB

* Activity()
### Activity

サーバーやコンテナ等に実装したアプリケーションからポーリングすることで独自定義の処理を実行する仕組み

### データの入出力

#### データの入力
* InputPath
  * 渡された入力のうち、何をState内で使用するかを指定
* Parameters
  * キーと値のペアを生成してStateに渡す

#### 処理結果の受け取り
* ResultPath
* OutputPath

### Stateの記述
<https://docs.aws.aws.amazon.com/ja_jp/step-functions/latest/dg/amazon-states-language-state-machine-structure.html>

#### State Type
<https://docs.aws.aws.amazon.com/ja_jp/step-functions/latest/dg/amazon-states-language-state-machine-task-state.html>
* Task
* Wait
* Pass
* Parallel
* Choice
* Fail
* Succeed

### ステートマシンの実行

State 

### 
CloudWatch Eventsでルールを作成


### AWS Step Functions Local
ローカルで動作検証が可能

Jarパッケージ、Dockerで動作

### 制限事項

