#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

extern "C" { void timer_start( void ); }
extern "C" { double timer_elapsed( void ); }

//不応期
// MSN
__global__ void t_refr_MSN ( neuron_t *n_MSN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN ){

        n_MSN -> refr [ i ] = ( n_MSN -> s [ i ] ) * ( T_REFR ) + ( !( n_MSN -> s [ i ] ) ) * ( ( n_MSN -> refr [ i ] ) - 1 ); // set counter
        n_MSN -> v [ i ] = ( ( n_MSN -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( ( n_MSN -> v [ i ] ) );
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
// CSN
__global__ void t_refr_CSN ( neuron_t *n_CSN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_CSN ){

        n_CSN -> refr [ i ] = ( n_CSN -> s [ i ] ) * ( T_REFR ) + ( !( n_CSN -> s [ i ] ) ) * ( ( n_CSN -> refr [ i ] ) - 1 ); // set counter
    }
}
// PTN
__global__ void t_refr_PTN ( neuron_t *n_PTN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTN ){

        n_PTN -> refr [ i ] = ( n_PTN -> s [ i ] ) * ( T_REFR ) + ( !( n_PTN -> s [ i ] ) ) * ( ( n_PTN -> refr [ i ] ) - 1 ); // set counter
    }
}
// CMPf
__global__ void t_refr_CMPf ( neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_CMPf ){

        n_CMPf -> refr [ i ] = ( n_CMPf -> s [ i ] ) * ( T_REFR ) + ( ! ( n_CMPf -> s [ i ] ) ) * ( ( n_CMPf -> refr [ i ] ) - 1 ); // set counter
    }
}
void t_refr ( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

    t_refr_MSN <<< GRID_SIZE_MSN, BLOCK_SIZE >>> ( n_MSN );
    cudaDeviceSynchronize ( );
    t_refr_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( n_FSI );
    cudaDeviceSynchronize ( );
    t_refr_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( n_STN );
    cudaDeviceSynchronize ( );
    t_refr_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( n_GPe );
    cudaDeviceSynchronize ( );
    t_refr_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( n_GPi );
    cudaDeviceSynchronize ( );
    t_refr_CSN <<< GRID_SIZE_CSN, BLOCK_SIZE >>> ( n_CSN );
    cudaDeviceSynchronize ( );
    t_refr_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( n_PTN );
    cudaDeviceSynchronize ( );
    t_refr_CMPf <<< GRID_SIZE_CMPf, BLOCK_SIZE >>> ( n_CMPf );
    cudaDeviceSynchronize ( );
}

//ループ
void loop( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf, int w, int z ){

    timer_start();

    for ( int nt = 0; nt < FreeRun; nt++ ){
        updateSynapse ( nt, n_MSN, n_FSI, n_STN, n_GPe, n_CSN, n_PTN, n_CMPf );
        InputSynapsePotential ( nt, n_MSN, n_FSI, n_STN, n_GPe, n_GPi, n_CSN, n_PTN, n_CMPf );
        updatePotential( nt, n_MSN, n_FSI, n_STN, n_GPe, n_GPi );
        inputneuron ( nt, n_CSN, n_PTN, n_CMPf );
        t_refr ( n_MSN, n_FSI, n_STN, n_GPe, n_GPi, n_CSN, n_PTN, n_CMPf );
    }

    for ( int nt = 0; nt < NT; nt++ ){

        updateSynapse ( nt, n_MSN, n_FSI, n_STN, n_GPe, n_CSN, n_PTN, n_CMPf );
        InputSynapsePotential ( nt, n_MSN, n_FSI, n_STN, n_GPe, n_GPi, n_CSN, n_PTN, n_CMPf );
        updatePotential( nt, n_MSN, n_FSI, n_STN, n_GPe, n_GPi );
        change_inputneuron ( nt, n_CSN, n_PTN, n_CMPf, w, z );
        t_refr ( n_MSN, n_FSI, n_STN, n_GPe, n_GPi, n_CSN, n_PTN, n_CMPf );
        outputSpike ( n_GPi, n_CSN, n_PTN );
    }

    double elapsedTime = timer_elapsed ();

    printf ( "Elapsed time = %f sec.\n", elapsedTime );

    outputFiringRate ( n_GPi, n_CSN, n_PTN );

    for ( int i = 0; i < N_MSN; i++ ){
        n_MSN -> ig[ i ] = 0;
        n_MSN -> alpha_GABA[ i ] = 0;
        n_MSN -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_MSN -> rng );
        n_MSN -> s[ i ] = false;
        n_MSN -> ts[ i ] = 1000;
        n_MSN -> refr[ i ] = 0;
    }

    for ( int i = 0; i < N_FSI; i++ ){
        n_FSI -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_FSI -> rng );
        n_FSI -> s[ i ] = false;
        n_FSI -> alpha_GABA[ i ] = 0;
        n_FSI -> ts[ i ] = 1000;
        n_FSI -> ig[ i ] = 0;
        n_FSI -> refr[ i ] = 0;
    }

    for ( int i = 0; i < N_GPi; i++ ){
        n_GPi -> ig[ i ] = 0;
        n_GPi -> counter[ i ] = 0;
        n_GPi -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_GPi -> rng );
        n_GPi -> s[ i ] = false;
        n_GPi -> ts[ i ] = 1000;
        n_GPi -> refr[ i ] = 0;
    }

    for ( int i = 0; i < N_STN; i++ ){
        n_STN -> ig[ i ] = 0;
        n_STN -> alpha_AMPA[ i ] = 0;
        n_STN -> alpha_NMDA[ i ] = 0;
        n_STN -> v[ i ] = V_INIT + 50. * sfmt_genrand_real2 ( &n_STN -> rng );
        n_STN -> s[ i ] = false;
        n_STN -> ts[ i ] = 1000;
        n_STN -> refr[ i ] = 0;
    }

    for ( int i = 0; i < N_GPe; i++ ){
        n_GPe -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_GPe -> rng );
        n_GPe -> s[ i ] = false;
        n_GPe -> alpha_GABA[ i ] = 0;
        n_GPe -> ts[ i ] = 1000;
        n_GPe -> ig[ i ] = 0;
        n_GPe -> refr[ i ] = 0;
    }

    for ( int i = 0; i < N_CSN; i++ ){
        n_CSN -> alpha_AMPA[ i ] = 0;
        n_CSN -> alpha_NMDA[ i ] = 0;
        n_CSN -> counter[ i ] = 0;
        n_CSN -> s[ i ] = false;
        n_CSN -> ts[ i ] = 1000;
        n_CSN -> refr[ i ] = 0;
    }

    for ( int i = 0; i < N_PTN; i++ ){
        n_PTN -> alpha_AMPA[ i ] = 0;
        n_PTN -> alpha_NMDA[ i ] = 0;
        n_PTN -> counter[ i ] = 0;
        n_PTN -> s[ i ] = false;
        n_PTN -> ts[ i ] = 1000;
        n_PTN -> refr[ i ] = 0;
    }

    for ( int i = 0; i < N_CMPf; i++ ){
        n_CMPf -> alpha_AMPA[ i ] = 0;
        n_CMPf -> alpha_NMDA[ i ] = 0;
        n_CMPf -> s[ i ] = false;
        n_CMPf -> ts[ i ] = 1000;
        n_CMPf -> refr[ i ] = 0;
    }

    initselection ( n_CSN, n_PTN );
}