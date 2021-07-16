---
layout: post
auther: friendbear
categoly: [Startup]
title: Startup day follow up session machienelearning
tags: []
---

## Upgrade UX with Data / 機械学習を用いたサービス改善

### Amzon Go
* コンピュータービジョン
* イメージングトラッキング

### 機械学習スタック
* AI SERVICES
* ML SERVICES
* ML FRAMEWORKS & INFRASTRACTURE

### Undifferentiated Heavy Lifting


## クラシルさん事例
* レシピサイト

### 強み
レシピ考案、施策、レシピチェック、写真、投稿

Users <- ユーザー素性(お気に入り/検索回数, ログイン有無)
Media <- マッチングロジック
Item <- アイテム素性



## Dely担当者様
* Personalization(レシピ続映抽出)
  * 人海戦術
  * クラシルシェフ
  * 管理栄養士
    * レシピ属性抽出[^3]
      * 推論
      * HPO活用
      * Search活用
    * ユーザ素性
      * Glue + Athena
      * pyAthena(awsのライブラリ)
        * クラスタリング
        * 強調フィルタリング(ビルドインアルゴリズム)
        * バッチ推論(ファクタリアクティングマシン)
          1. クラスタリングプールをリセットすることでユーザの離れることを防いでいる
* Data-Driven
  * 現状把握
  * 将来の価値

  <https://github.com/delyjp/water-seven.git>
* ETL[^1] Eco System
  * 分析にかける時間を結果的に未来の価値につなげる

* EDA[^2] Scrum
  成果の見える化
  * EDA分析には終わりがなく進む方向を見失いがち
  * 周囲からも何をやっているのかわかりずらい
    1. レポートのライブラリ化

　取り組み
    * 手順のクラシルらしさ判定
    * サムネイル評価(再生数、お気に入り数)
    * 代替食材判定

1. 地域性
  + イベント、コミュニティ、学び合い、コンビニレシピ、スーパーレシピ
2. フレッシュ性
  * 無駄の排除（廃棄寸前商品をレコメンデーション＋クッキング）
3. 履歴
4. ビジュアライズ
5. 健康状態-> ボット活用-> レコメンデーション
6. 配達（生協、タペソタ)
7. 音声認識

---
[^1]:
[^2]:
[^3]: Hyper parameter




