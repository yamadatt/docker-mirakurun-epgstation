# このリポジトリは？

録画サーバを構築するためのもの。

構築するのは、NVIDAエンコード可能なEPGStation。

PLEXのチューナーを使用し、recpt1による録画が可能。

## 構築手順

初期設定として、shellスクリプトを動かす。

- 01_common.sh
- 02_GPU.sh

docker-composeで起動して動作確認する。

継続して以下の設定を実施する。

- GitHubの秘密鍵設定
- sambaのファイル共有
- tailscaleの設定
- node.jsのインストール
- hugoのインストール


## 設定情報

### Mirakurun

* ポート番号: 40772

### EPGStation

* ポート番号: 8888

### 各種ファイル保存先

* 録画データ

```/media/tv_record```

* サムネイル

```./epgstation/thumbnail```

* 予約情報と HLS 配信時の一時ファイル

```./epgstation/data```

* EPGStation 設定ファイル

```./epgstation/config```

* EPGStation のログ

```./epgstation/logs```
