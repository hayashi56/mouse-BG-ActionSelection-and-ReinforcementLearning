# model of action selection in the basal ganglia of the mouse
## ファイル構成

テキストの付録A.3にも記載がある。このファイルの末尾に一覧を添付する。また、各フォルダはそれぞれ`README`と`Makefile`を含んでいる。

疑似乱数として、[SIMD-oriented Fast Mersenne Twister (SFMT)](http://www.math.sci.hiroshima-u.ac.jp/m-mat/MT/SFMT/index-jp.html) のバージョン 1.5.1 を使っている。`./{column, part1, part2, part3}/misc/SFMT-1.5.1` 以下がそれである。

## 使い方

テキスト中の説明を読み、各フォルダの下の`README-ja.md`を参照のこと。

## ライセンス

- SFMTのライセンスは修正BSDライセンスである。詳細は`SFMT-1.5.1`以下に同梱されている`LICENSE.txt`もしくはSFMTのホームページ上の[`LICENSE.txt`](http://www.math.sci.hiroshima-u.ac.jp/m-mat/MT/SFMT/LICENSE.txt)を確認のこと。
- `./src/misc/timer.c`のライセンスはPublic Domainである。
- それ以外のソースコードのライセンスは修正BSDライセンスである。`LICENSE.txt`を確認のこと。

## ファイル一覧

```
src/ : 第I部のソースコード
src/hh/ : ホジキン・ハクスレー型モデル
src/hh/hh.c : ホジキン・ハクスレーモデル
src/hh/sfa.c : 発火頻度適応のモデル
src/hh/sfa.c : 発火頻度適応のモデル
src/hh/ia.c : Type Iニューロンのモデル
src/lif/ : 積分発火型モデル
src/lif/lif.c : 1個のモデル
```
