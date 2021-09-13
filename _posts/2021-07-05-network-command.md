---

title: Linuxコマンド備忘録
categories: Linux
tag: [Linux, command]
---

| コマンド        | 用途                                                   | 収録パッケージ |
|-----------------|--------------------------------------------------------|----------------|
| vmstat 2        | システム全体の負荷を見るならこれ。2で2秒ごと           | procps         |
| top             | CPUやメモリを食っているプロセスを特定したいならこれ    | procps         |
| sar             | 過去の負荷の履歴をみたいならこれ                       | sysstat        |
| mpstat -P ALL 1 | CPUコアごとの負荷を見るならこれ                        | sysstat        |
| dstat -taf      | 標準ではインストールされていないが、一番便利なコマンド | dstat          |
| free -m         | メモリ。-mでメガバイト単位                             | procps         |
| iostat -dmxt 1  | IO状況                                                 | sysstat        |

