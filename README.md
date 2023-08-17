# model of action selection in the basal ganglia of the mouse
## ファイル構成

このファイルの末尾に一覧を添付する。また、各フォルダはそれぞれ`Makefile`を含んでいる。

疑似乱数として、[SIMD-oriented Fast Mersenne Twister (SFMT)](http://www.math.sci.hiroshima-u.ac.jp/m-mat/MT/SFMT/index-jp.html) のバージョン 1.5.1 を使っている。`./src/misc/SFMT-1.5.1` 以下がそれである。

## 使い方
programフォルダ内で下記の操作でコンパイル・実行(2回目以降はコンパイル前に)するか、もしくは`make`で自動的にコンパイル・実行される。

### コンパイル方法
'''
nvcc -O3 -std=c++11 -I../misc/SFMT-src-1.5.1 -D SFMT_MEXP=19937 -c bcbg.cu
gcc -O3 -std=gnu11 -Wall -I../misc/SFMT-src-1.5.1 -D SFMT_MEXP=19937 -c ../misc/SFMT-src-1.5.1/SFMT.c
gcc -O3 -std=gnu11 -Wall -c ../misc/timer.c
nvcc -O3 -std=c++11 -I../misc/SFMT-src-1.5.1 -D SFMT_MEXP=19937 -o bcbg bcbg.o SFMT.o timer.o -lm
'''
### 実行方法
'''
./bcbg
'''
### 結果の表示
実行後、実行結果が`baseline`と`baseline`それぞれ`lif.dat`, `lif_alt.dat`, `lif_refr.dat`, `lif2.dat`, `network.dat`, `network_delay.dat`に出力されるので、それらをプロットすればよい。

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
