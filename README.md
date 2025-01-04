# multi-rtmp-server

1つのエンドポイントでYouTube, Twitch, ニコニコ生放送へ同時に配信する。

## 実行方法
1. 環境変数を設定する

```env
YOUTUBE_STREAM_KEY1=
YOUTUBE_STREAM_KEY2=
TWITCH_STREAM_KEY=
NICONICO_STREAM_KEY=
```

2. 起動する

`docker compose up -d`
