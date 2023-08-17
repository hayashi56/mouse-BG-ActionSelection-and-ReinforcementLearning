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
実行後、実行結果が`baseline`と`actionselection`は、まず標準出力でシミュレーションの計算時間が`Elapsed time = (elapsedTime) sec.`の様な形(`(elapsedTime)は数値`)で出力され、そして標準出力で各神経細胞の平均発火率が以下のように出力される。
```
MSND1:(firingrate)Hz
MSND2:(firingrate)Hz
FSI:(firingrate)Hz
STN:(firingrate)Hz
GPe:(firingrate)Hz
GPi:(firingrate)Hz
SNc:(firingrate)Hz
PTN:(firingrate)Hz
PTI:(firingrate)Hz
PSN:(firingrate)Hz
Th:(firingrate)Hz
CMPf:(firingrate)Hz
```
ファイル出力でそれぞれ`MSN_D1spike.dat`, `MSN_D2spike.dat`, `FSIspike.dat`, `STNspike.dat`, `GPespike.dat`, `GPispike.dat`, `SNcspike.dat`, `PTNspike.dat`, `PTIspike.dat`, `PSNspike.dat`, `Thspike.dat`, `CMPfspike.dat`に出力されるので、それらを`rasterplot.ipynb`でプロットできる。

実行後、実行結果が`map_actionselection`は、まず標準出力でシミュレーションの計算時間が`Elapsed time = (elapsedTime) sec.`の様な形(`(elapsedTime)は数値`)で出力される。
`map_actionselection`ではシミュレーションを400回行うので、400回シミュレーションの計算時間が表示される。
ファイル出力でそれぞれ`GPifiringrate_chanel1.dat`, `GPifiringrate_chanel2.dat`に出力されるので、それらを`actionselection.ipynb`でプロットできる。

### ファイルの処理
実行ファイルと結果ファイルは`distclean: clean`で削除するか、もしくは以下の操作で削除できる。
- 実行ファイル
```
rm -f bcbg *.o
```
- 結果ファイル
```
rm -f *.dat
```

## ライセンス

- SFMTのライセンスは修正BSDライセンスである。SFMTのホームページ上の[`LICENSE.txt`](http://www.math.sci.hiroshima-u.ac.jp/m-mat/MT/SFMT/LICENSE.txt)を確認のこと。
- `./src/misc/timer.c`のライセンスはPublic Domainである。
- それ以外のソースコードのライセンスは修正BSDライセンスである。

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
