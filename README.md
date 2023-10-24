# piget
[google π　dataクラウド](https://api.pi.delivery/ "api.pi.delivery") から指定の数字列を検索する。

## Usage
```
Usage: piget.sh [from <Start search offset>] [beep] [raw] <Number string to search for> ...
<Start search offset> : Default is 0
beep : Beep when found
raw : The displayed content is the content of the received data (tags etc. are not displayed if not specified)
```

## History
* 2023.
  - 数値列検索に成功したらビープ音を鳴らすオプションを追加する
  - 表示内容からタグやカッコを省き簡素化する
  - 受信した内容を表示させるrawオプションを追加する
  
* 2023.10.23
  - コマンド引数に「検索開始オフセット（from）」を追加する
  - 検索数列を複数指定できるようにする
