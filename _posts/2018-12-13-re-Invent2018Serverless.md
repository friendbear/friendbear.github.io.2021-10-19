---
layout: post
auther: freindbear
title: Serverless re:Invent 2018 OSAKA
---

## Serverless
@Keisuke69

### SLAを定義した (99.5)

### WAF(API Gatewayに直接割り当てられられる)
CloudFlont -> Lambda
API Gateway -> Lambda

### SQS FIFO

### HTTP/2サポート
* KDF

### Deep Dive
#### 
Control Plane, DataPlane

Data Plane
* Flont End Invoke
* Syncronus| Async

### Firecracker (マイクロ仮想マシン)
KVMベース
VMあたり5MiB¥
<https://github.com/firecracker-microvm/firecracker>



https://firecracker-microvm.github.io/


```js
def hander(event:, context:)
{ event: JSON.generate(event), context: JSON.generate(context.inspect) }
end

module LambdaFunctions
  class Handler
    def self.process(event:. context)
    }
```
### 任意のランタイムを、Linux互換
Runtime APIによって可能


### Cusom Runtime
* bootstrapと呼ばれる実行ファイルを含める必要がある
* bootstrap

* Layerとして登録すればRuntime管理者とRuntime利用者の責務を分離できる

#### 作り方

##### Initialization Tasks
LAMBDA_TASK_ROOT
AWS_LAMBDA_RUNTIME_API

ファンクションの初期化

エラーハンドリング

##### ProcessingTask
* イベントを取得
* トレーシングヘッダの伝搬
* コンテキストオブジェクトの作成

* ファンクションのハンドラ呼び出し
* レスポンスのハンドリング
* エラーハンドリング
* クリーンアップ

