#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <time.h>

extern "C" { void timer_start( void ); }
extern "C" { double timer_elapsed( void ); }

//不応期
// MSN_D1
__global__ void t_refr_MSN_D1 ( neuron_t *n_MSN_D1 ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_MSN_D1 ){

    n_MSN_D1 -> refr [ i ] = ( n_MSN_D1 -> s [ i ] ) * ( T_REFR ) + ( !( n_MSN_D1 -> s [ i ] ) ) * ( ( n_MSN_D1 -> refr [ i ] ) - 1 ); // set counter
  }
}
// MSN_D2
__global__ void t_refr_MSN_D2 ( neuron_t *n_MSN_D2 ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_MSN_D2 ){

    n_MSN_D2 -> refr [ i ] = ( n_MSN_D2 -> s [ i ] ) * ( T_REFR ) + ( !( n_MSN_D2 -> s [ i ] ) ) * ( ( n_MSN_D2 -> refr [ i ] ) - 1 ); // set counter
    n_MSN_D2 -> v [ i ] = ( ( n_MSN_D2 -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( ( n_MSN_D2 -> v [ i ] ) );
  }
}
// FSI
__global__ void t_refr_FSI ( neuron_t *n_FSI ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_FSI ){

    n_FSI -> refr [ i ] = ( n_FSI -> s [ i ] ) * ( T_REFR ) + ( !( n_FSI -> s [ i ] ) ) * ( ( n_FSI -> refr [ i ] ) - 1 ); // set counter
    n_FSI -> v [ i ] = ( ( n_FSI -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( n_FSI -> v [ i ] );
  }
}
// STN
__global__ void t_refr_STN ( neuron_t *n_STN ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_STN ){

    n_STN -> refr [ i ] = ( n_STN -> s [ i ] ) * ( T_REFR ) + ( !( n_STN -> s [ i ] ) ) * ( ( n_STN -> refr [ i ] ) - 1 ); // set counter
    n_STN -> v [ i ] = ( ( n_STN -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( n_STN -> v [ i ] );
  }
}
// GPe
__global__ void t_refr_GPe ( neuron_t *n_GPe ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_GPe ){

    n_GPe -> refr [ i ] = ( n_GPe -> s [ i ] ) * ( T_REFR ) + ( !( n_GPe -> s [ i ] ) ) * ( ( n_GPe -> refr [ i ] ) - 1 ); // set counter
    n_GPe -> v [ i ] = ( ( n_GPe -> refr [ i ] ) > 0) ? ( V_RESET ) : ( n_GPe -> v [ i ] );
  }
}
// GPi
__global__ void t_refr_GPi ( neuron_t *n_GPi ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_GPi ){

    n_GPi -> refr [ i ] = ( n_GPi -> s [ i ] ) * ( T_REFR ) + ( !( n_GPi -> s [ i ] ) ) * ( ( n_GPi -> refr [ i ] ) - 1 ); // set counter
    n_GPi -> v [ i ] = ( ( n_GPi -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( n_GPi -> v [ i ] );
  }
}
// SNc
__global__ void t_refr_SNc ( neuron_t *n_SNc ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_SNc ){

    n_SNc -> refr [ i ] = ( n_SNc -> s [ i ] ) * ( T_REFR ) + ( !( n_SNc -> s [ i ] ) ) * ( ( n_SNc -> refr [ i ] ) - 1 ); // set counter
    n_SNc -> v [ i ] = ( ( n_SNc -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( n_SNc -> v [ i ] );
  }
}
// PTN
__global__ void t_refr_PTN ( neuron_t *n_PTN ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_PTN ){

    n_PTN -> refr [ i ] = ( n_PTN -> s [ i ] ) * ( T_REFR ) + ( !( n_PTN -> s [ i ] ) ) * ( ( n_PTN -> refr [ i ] ) - 1 ); // set counter
    n_PTN -> v [ i ] = ( ( n_PTN -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( n_PTN -> v [ i ] );
  }
}
// PTI
__global__ void t_refr_PTI ( neuron_t *n_PTI ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_PTI ){

    n_PTI -> refr [ i ] = ( n_PTI -> s [ i ] ) * ( T_REFR ) + ( !( n_PTI -> s [ i ] ) ) * ( ( n_PTI -> refr [ i ] ) - 1 ); // set counter
    n_PTI -> v [ i ] = ( ( n_PTI -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( n_PTI -> v [ i ] );
  }
}
// Th
__global__ void t_refr_Th ( neuron_t *n_Th ){

  long i = threadIdx.x + blockIdx.x * blockDim.x;

  if ( i < N_Th ){

    n_Th -> refr [ i ] = ( n_Th -> s [ i ] ) * ( T_REFR ) + ( !( n_Th -> s [ i ] ) ) * ( ( n_Th -> refr [ i ] ) - 1 ); // set counter
    n_Th -> v [ i ] = ( ( n_Th -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( n_Th -> v [ i ] );
  }
}
void t_refr ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_Th ){

  t_refr_MSN_D1 <<< GRID_SIZE_MSN_D1, BLOCK_SIZE >>> ( n_MSN_D1 );
  cudaDeviceSynchronize ( );
  t_refr_MSN_D2 <<< GRID_SIZE_MSN_D2, BLOCK_SIZE >>> ( n_MSN_D2 );
  cudaDeviceSynchronize ( );
  t_refr_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( n_FSI );
  cudaDeviceSynchronize ( );
  t_refr_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( n_STN );
  cudaDeviceSynchronize ( );
  t_refr_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( n_GPe );
  cudaDeviceSynchronize ( );
  t_refr_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( n_GPi );
  cudaDeviceSynchronize ( );
  t_refr_SNc <<< GRID_SIZE_SNc, BLOCK_SIZE >>> ( n_SNc );
  cudaDeviceSynchronize ( );
  t_refr_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( n_PTN );
  cudaDeviceSynchronize ( );
  t_refr_PTI <<< GRID_SIZE_PTI, BLOCK_SIZE >>> ( n_PTI );
  cudaDeviceSynchronize ( );
  t_refr_Th <<< GRID_SIZE_Th, BLOCK_SIZE >>> ( n_Th );
  cudaDeviceSynchronize ( );
}

//ループ
void loop( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSA, neuron_t *n_Th, neuron_t *n_CMPf ){
  
  timer_start();
  int nt;

  //FreeRun
  for ( nt = 0; nt < FreeRun; nt++ ){
    updateSynapse ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    InputSynapsePotential ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    updatePotential( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    inputneuron ( nt, n_PSA, n_CMPf );
    t_refr ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
  }

  //ActionSelectionなし
  for ( ; nt < NT; nt++ ){

    updateSynapse ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    InputSynapsePotential ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    updatePotential( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    inputneuron ( nt, n_PSA, n_CMPf );
    t_refr ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    outputSpike ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
  }

  //ActionSelectionあり
  for ( ; nt < NT_action; nt++ ){

    updateSynapse ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    InputSynapsePotential ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    updatePotential( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    inputneuron ( nt, n_PSA, n_CMPf );
    t_refr ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    outputSpike ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
  }

  //ActionSelectionなし
  for ( ; nt < NT2; nt++ ){

    updateSynapse ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    InputSynapsePotential ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
    updatePotential( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    inputneuron ( nt, n_PSA, n_CMPf );
    t_refr ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    outputSpike ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
  }

  double elapsedTime = timer_elapsed ();

  printf ( "Elapsed time = %f sec.\n", elapsedTime );

  outputFiringRate ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSA, n_Th, n_CMPf );
}