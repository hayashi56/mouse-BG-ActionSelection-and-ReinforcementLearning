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

  neuron_t *msn, *fsi, *stn, *gpe, *gpi, *csn, *ptn, *cmpf;

  //初期化・メモリの確保・ファイルを開く
  cudaMallocManaged ( &msn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &fsi, sizeof ( neuron_t ) );
  cudaMallocManaged ( &stn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &gpe, sizeof ( neuron_t ) );
  cudaMallocManaged ( &gpi, sizeof ( neuron_t ) );
  cudaMallocManaged ( &csn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &ptn, sizeof ( neuron_t ) );
  cudaMallocManaged ( &cmpf, sizeof ( neuron_t ) );
  
  initalizeNeuron ( msn, fsi, stn, gpe, gpi, csn, ptn, cmpf );
  initsynapse ( msn, fsi, stn, gpe, gpi );

  for ( int w = 0; w < N_i; w++ ){
    for ( int z = 0; z < N_i; z++ ){
      loop ( msn, fsi, stn, gpe, gpi, csn, ptn, cmpf, w, z );
    }
  }

  //メモリの解放・ファイルを閉じる
  fileclose ( gpi, csn, ptn );
  finalize ( msn, fsi, stn, gpe, gpi, csn, ptn, cmpf );

  cudaFree ( msn );
  cudaFree ( fsi );
  cudaFree ( stn );
  cudaFree ( gpe );
  cudaFree ( gpi );
  cudaFree ( csn );
  cudaFree ( ptn );
  cudaFree ( cmpf );

  return 0;
}