#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include "param.h"
#include "structure.cu"
#include "synapse_function.cu"
#include "update.cu"
#include "output.cu"
#include "function.cu"
#include "initalize.cu"

int main( void ){

  neuron_t *msn_d1, *msn_d2, *fsi, *stn, *gpe, *gpi, *snc, *ptn, *pti, *psa, *th, *cmpf;

  //初期化・メモリの確保・ファイルを開く
  cudaMallocManaged ( &msn_d1, sizeof ( neuron_t ) );
  cudaMallocManaged ( &msn_d2, sizeof ( neuron_t ) );
  cudaMallocManaged ( &fsi, sizeof ( neuron_t ) );
  cudaMallocManaged ( &stn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &gpe, sizeof ( neuron_t ) );
  cudaMallocManaged ( &gpi, sizeof ( neuron_t ) );
  cudaMallocManaged ( &snc, sizeof ( neuron_t ) );
  cudaMallocManaged ( &ptn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &pti, sizeof ( neuron_t ) );
  cudaMallocManaged ( &psa, sizeof ( neuron_t ) );
  cudaMallocManaged ( &th, sizeof ( neuron_t ) );
  cudaMallocManaged ( &cmpf, sizeof ( neuron_t ) );
  
  initalizeNeuron ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psa, th, cmpf );
  initsynapse ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, th );

  //単位時間によるループ(1ms)
  loop ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psa, th, cmpf );

  //メモリの解放・ファイルを閉じる
  finalize ( msn_d1, msn_d2, fsi, stn, gpe, gpi, snc, ptn, pti, psa, th, cmpf );

  cudaFree ( msn_d1 );
  cudaFree ( msn_d2 );
  cudaFree ( fsi );
  cudaFree ( stn );
  cudaFree ( gpe );
  cudaFree ( gpi );
  cudaFree ( snc );
  cudaFree ( ptn );
  cudaFree ( pti );
  cudaFree ( psa );
  cudaFree ( th );
  cudaFree ( cmpf );

  return 0;
}