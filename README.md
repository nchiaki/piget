# piget
[google π　dataクラウド](https://api.pi.delivery/ "api.pi.delivery") から指定の数字列を検索する。

## Usage
```
piget.sh piget.sh [from <Start search offset>] <Number string to search for>
<Start search offset> : Default is 0
```

## History
* 2023.
  - 数値列検索に成功したらビープ音を鳴らすオプションを追加する
  
* 2023.10.23
  - コマンド引数に「検索開始オフセット（from）」を追加する
  - 検索数列を複数指定できるようにする
