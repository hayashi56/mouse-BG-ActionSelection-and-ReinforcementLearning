#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include "param.h"
#include "structure.cu"
#include "initalize.cu"
#include "synapse_function.cu"
#include "update.cu"
#include "output.cu"
#include "function.cu"

int main( void ){

  /*
  各ニューロン(以下各ニューロンついて)を再現するためのポインタ変数の定義
  msn_d1→線条体内のD1受容体を発現する中型の有棘細胞(medium spiny neurons：MSN)
  msn_d2→線条体内のD2受容体を発現する中型の有棘細胞(medium spiny neurons：MSN)
  fsi→線条体内の高速でスパイクする介在ニューロン(fast-spiking interneurons：FSI)
  stn→視床下核(subthalamic nucleus：STN)
  gpe→淡蒼球外節(external globus pallidus：GPe)
  gpi→淡蒼球内節(internal globus pallidus：GPi)
  snc→黒質緻密部(substantia nigra pars compacta：SNc)
  ptn→大脳皮質の運動野(pyramidal tract neurons：PTN)
  pti→大脳皮質の運動野の介在ニューロン(pyramidal tract interneurons：PTI)
  psn→大脳皮質の運動野(pyramidal sensory neurons：PSN)
  th→視床(thalamus：Th)
  cmpf→視床下部(centromedian and parafascicular thalamic nuclei：CM/Pf)
  */
  neuron_t *msn_d1, *msn_d2, *fsi, *stn, *gpe, *gpi, *snc, *ptn, *pti, *psn, *th, *cmpf;

  // 定義したポインタ変数のメモリ確保
  cudaMallocManaged ( &msn_d1, sizeof ( neuron_t ) );
  cudaMallocManaged ( &msn_d2, sizeof ( neuron_t ) );
  cudaMallocManaged ( &fsi, sizeof ( neuron_t ) );
  cudaMallocManaged ( &stn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &gpe, sizeof ( neuron_t ) );
  cudaMallocManaged ( &gpi, sizeof ( neuron_t ) );
  cudaMallocManaged ( &snc, sizeof ( neuron_t ) );
  cudaMallocManaged ( &ptn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &pti, sizeof ( neuron_t ) );
  cudaMallocManaged ( &psn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &th, sizeof ( neuron_t ) );
  cudaMallocManaged ( &cmpf, sizeof ( neuron_t ) );


  // シミュレーション用いる変数のメモリ確保・初期化
  initalize ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psn, th, cmpf );

  // 各ニューロンについてのシミュレーション結果を出力するファイルをオープン
  file_open( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psn, th, cmpf  );

  // chanel1(選択肢1)の選択性の変化
  for ( int chanel1 = 0; chanel1 < N_change; chanel1++ ){
    // chanel2(選択肢2)の選択性の変化
    for ( int chanel2 = 0; chanel2 < N_change; chanel2++ ){
      // 1s(1000ms)のシミュレーションを行う関数
      loop ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psn, th, cmpf, chanel1 , chanel2 );
    }
  }

  // メモリ確保した構造体のメンバ変数のメモリの解放
  finalize ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psn, th, cmpf );

  // 出力に使ったファイルをクローズ
  fileclose_firingrate ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psn, th, cmpf );

  // 定義したポインタ変数のメモリ解放
  cudaFree ( msn_d1 );
  cudaFree ( msn_d2 );
  cudaFree ( fsi );
  cudaFree ( stn );
  cudaFree ( gpe );
  cudaFree ( gpi );
  cudaFree ( snc );
  cudaFree ( ptn );
  cudaFree ( pti );
  cudaFree ( psn );
  cudaFree ( th );
  cudaFree ( cmpf );

  return 0;
}