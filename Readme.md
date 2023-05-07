# このリポジトリは？

録画サーバを構築するためのもの。

構築するのは、NVIDAエンコード可能なEPGStation。

PLEXのチューナーを使用し、recpt1による録画が可能。

また、録画ルールのバックアップにもこのリポジトリを使用している。

## 構築手順

### 録画、エンコードまで

初期設定として、shellスクリプトを動かす。

- 01_common.sh
- 02_GPU.sh

docker-composeで起動して動作確認する。

### やっておくと便利

ルールのバックアップとして、以下をcronで起動する。

  00 1 * * * docker exec -d epgstation-nvenc npm run backup config/`date +\%Y\%m\%d`_rule_backup.json

以下を使用して、録画状況をslackに通知する。

- 改めてbuildする場合は、```CGO_ENABLED=0 go build```でduildする
- appのslack導入とchannelの参加も忘れずに実施

[hiroxto/epgstation\-slack\-notification: EPGStationの通知をSlackに送るコマンドラインツール](https://github.com/hiroxto/epgstation-slack-notification)

## その他

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
