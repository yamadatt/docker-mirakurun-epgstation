# ※ l3tnun/docker-mirakurun-epgstation をベースに PX-W3PE4で動くように / QSV エンコードできるように 自前で改変してあります
# docker-mirakurun-epgstation
[Mirakurun](https://github.com/Chinachu/Mirakurun) + [EPGStation](https://github.com/l3tnun/EPGStation) の Docker コンテナ

## 前提条件
- Docker, docker-compose の導入が必須
- ホスト上の pcscd は停止する
- ~PT3用に設定済みなのでPT3での使用を想定~

## インストール手順

```sh
$ git clone https://github.com/l3tnun/docker-mirakurun-epgstation.git
$ cd docker-mirakurun-epgstation
$ cp docker-compose-sample.yml docker-compose.yml
$ cp epgstation/config/config.sample.json epgstation/config/config.json
$ sudo docker-compose pull
$ sudo docker-compose build

#チャンネル設定
$ vim mirakurun/conf/channels.yml

#コメントアウトされている restart や user の設定を適宜変更する
$ vim docker-compose.yml
```

## 起動

```sh
$ sudo docker-compose up -d
```
mirakurun の EPG 更新を待ってからブラウザで http://DockerHostIP:8888 へアクセスし動作を確認する

## 停止

```sh
$ sudo docker-compose down
```

## 設定

### Mirakurun

* ポート番号: 40772

### EPGStation

* ポート番号: 8888
* ポート番号: 8889

### 各種ファイル保存先

* 録画データ

```./recorded```

* サムネイル

```./epgstation/thumbnail```

* 予約情報と HLS 配信時の一時ファイル

```./epgstation/data```

* EPGStation 設定ファイル

```./epgstation/config```

* EPGStation のログ

```./epgstation/logs```
