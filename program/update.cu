#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

//膜電位の更新
// MSN
__global__ void updatePotential_MSN ( int nt, neuron_t *n_MSN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN ){

        n_MSN -> v[ i ] += DT * ( - ( n_MSN -> v[ i ] ) + Vc_MSN + ( rho * n_MSN -> ig[ i ] ) ) / TAU_MSN;
        n_MSN -> s[ i ] = ( n_MSN -> v[ i ] > THETA_MSN );
        n_MSN -> ts[ i ] = ( n_MSN -> s[ i ] ) * ( nt + 1 ) + ( !( n_MSN -> s[ i ] ) ) * ( n_MSN -> ts[ i ] );
        n_MSN -> v[ i ] = ( n_MSN -> s[ i ] ) * V_RESET + ( !( n_MSN -> s[ i ] ) ) * n_MSN -> v[ i ];
        n_MSN -> ig[ i ] = V_RESET;
    }
}
// FSI
__global__ void updatePotential_FSI ( int nt, neuron_t *n_FSI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_FSI ){

        n_FSI -> v[ i ] += DT * ( - ( n_FSI -> v[ i ] ) + Vc_FSI + ( rho * n_FSI -> ig[ i ] ) ) / TAU_FSI;
        n_FSI -> s[ i ] = ( n_FSI -> v[ i ] > THETA_FSI );
        n_FSI -> ts[ i ] = ( n_FSI -> s[ i ] ) * ( nt + 1 ) + ( !( n_FSI -> s[ i ] ) ) * ( n_FSI -> ts[ i ] );
        n_FSI -> v[ i ] = ( n_FSI -> s[ i ] ) * V_RESET + ( !( n_FSI -> s[ i ] ) ) * n_FSI -> v[ i ];
        n_FSI -> ig[ i ] = V_RESET;
    }
}
// STN
__global__ void updatePotential_STN ( int nt, neuron_t *n_STN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_STN ){

        n_STN -> v[ i ] += DT * ( - ( n_STN -> v[ i ] ) + Vc_STN + ( rho * n_STN -> ig[ i ] ) ) / TAU_STN;
        n_STN -> s[ i ] = ( n_STN -> v[ i ] > THETA_STN );
        n_STN -> ts[ i ] = ( n_STN -> s[ i ]) * ( nt + 1 ) + ( !( n_STN -> s[ i ] ) ) * ( n_STN -> ts[ i ] );
        n_STN -> v[ i ] = ( n_STN -> s[ i ] ) * V_RESET + ( !( n_STN -> s[ i ] ) ) * n_STN -> v[ i ];
        n_STN -> ig[ i ] = V_RESET;
    }
}
// GPe
__global__ void updatePotential_GPe ( int nt, neuron_t *n_GPe ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPe ){

        n_GPe -> v[ i ] += DT * ( - ( n_GPe -> v[ i ] ) + Vc_GPe + ( rho * n_GPe -> ig[ i ] ) ) / TAU_GPe;
        n_GPe -> s[ i ] = ( n_GPe -> v[ i ] > THETA_GPe );
        n_GPe -> ts[ i ] = ( n_GPe -> s[ i ] ) * ( nt + 1 ) + ( !( n_GPe -> s[ i ] ) ) * ( n_GPe -> ts[ i ] );
        n_GPe -> v[ i ] = ( n_GPe -> s[ i ] ) * V_RESET + ( !( n_GPe -> s[ i ] ) ) * n_GPe -> v[ i ];
        n_GPe -> ig[ i ] = V_RESET;
    }
}
// GPi
__global__ void updatePotential_GPi ( int nt, neuron_t *n_GPi ){
    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPi ){

        n_GPi -> v[ i ] += DT * ( - ( n_GPi -> v[ i ] ) + Vc_GPi + ( rho * n_GPi -> ig[ i ] ) ) / TAU_GPi;
        n_GPi -> s[ i ] = ( n_GPi -> v[ i ] > THETA_GPi );
        n_GPi -> ts[ i ] = ( n_GPi -> s[ i ] ) * ( nt + 1 ) + ( !( n_GPi -> s[ i ] ) ) * ( n_GPi -> ts[ i ] );
        n_GPi -> v[ i ] = ( n_GPi -> s[ i ] ) * V_RESET + ( !( n_GPi -> s[ i ] ) ) * n_GPi -> v[ i ];
        n_GPi -> ig[ i ] = V_RESET;
    }
}

void updatePotential ( int nt, neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi ){

    updatePotential_MSN <<< GRID_SIZE_MSN, BLOCK_SIZE >>> ( nt, n_MSN );
    cudaDeviceSynchronize ( );
    updatePotential_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( nt, n_FSI );
    cudaDeviceSynchronize ( );
    updatePotential_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( nt, n_STN );
    cudaDeviceSynchronize ( );
    updatePotential_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( nt, n_GPe );
    cudaDeviceSynchronize ( );
    updatePotential_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( nt, n_GPi );
    cudaDeviceSynchronize ( );
}

//ポアソンモデル
void change_inputneuron ( int nt, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf, int w, int z ){

    int i;
    //CSN
    for ( i = 0; i < per_chanel_N_CSN; i++ ){
        double r = sfmt_genrand_real2 ( &( n_CSN -> rng ) );
        n_CSN -> s [ i ] = r < ( PHI_MIN_CSN + ( ( ( ( PHI_MAX_CSN - PHI_MIN_CSN ) * w ) / N_i ) * n_CSN -> select [ i ] ) );
        n_CSN -> ts[ i ] = ( n_CSN -> s[ i ] ) * ( nt + 1 ) + ( !( n_CSN -> s[ i ] ) ) * ( n_CSN -> ts[ i ] );
    }
    for ( ; i < N_CSN; i++ ){
        double r = sfmt_genrand_real2 ( &( n_CSN -> rng ) );
        n_CSN -> s [ i ] = r < ( PHI_MIN_CSN + ( ( ( ( PHI_MAX_CSN - PHI_MIN_CSN ) * z ) / N_i ) * n_CSN -> select [ i ] ) );
        n_CSN -> ts[ i ] = ( n_CSN -> s[ i ] ) * ( nt + 1 ) + ( !( n_CSN -> s[ i ] ) ) * ( n_CSN -> ts[ i ] );
    }

    //PTN
    for ( i = 0; i < per_chanel_N_PTN; i++ ){
        double r = sfmt_genrand_real2 ( &( n_PTN -> rng ) );
        n_PTN -> s [ i ] =  r < ( PHI_MIN_PTN + ( ( ( PHI_MAX_PTN - PHI_MIN_PTN ) * w ) / N_i ) * n_PTN -> select [ i ] );
        n_PTN -> ts[ i ] = ( n_PTN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PTN -> s[ i ] ) ) * ( n_PTN -> ts[ i ] );
    }
    for ( ; i < N_PTN; i++ ){
        double r = sfmt_genrand_real2 ( &( n_PTN -> rng ) );
        n_PTN -> s [ i ] =  r < ( PHI_MIN_PTN + ( ( ( PHI_MAX_PTN - PHI_MIN_PTN ) * z ) / N_i ) * n_PTN -> select [ i ] );
        n_PTN -> ts[ i ] = ( n_PTN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PTN -> s[ i ] ) ) * ( n_PTN -> ts[ i ] );
    }

    //CMPf
    for ( int i = 0; i < N_CMPf; i++ ){
        double r = sfmt_genrand_real2 ( &( n_CMPf -> rng ) );
        n_CMPf -> s[ i ] = ( r < PHI_CMPf );
        n_CMPf -> ts[ i ] = ( n_CMPf -> s[ i ] ) * ( nt + 1 ) + ( !( n_CMPf -> s[ i ] ) ) * ( n_CMPf -> ts[ i ] );
    }
}

void inputneuron ( int nt, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

    //CSN
    for ( int i = 0; i < N_CSN; i++ ){

        double r = sfmt_genrand_real2 ( &( n_CSN -> rng ) );
        n_CSN -> s[ i ] = ( r < PHI_MIN_CSN );
        n_CSN -> ts[ i ] = ( n_CSN -> s[ i ] ) * ( nt + 1 ) + ( !( n_CSN -> s[ i ] ) ) * ( n_CSN -> ts[ i ] );
    }

    //PTN
    for ( int i = 0; i < N_PTN; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PTN -> rng ) );
        n_PTN -> s[ i ] = ( r < PHI_MIN_PTN );
        n_PTN -> ts[ i ] = ( n_PTN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PTN -> s[ i ] ) ) * ( n_PTN -> ts[ i ] );
    }

    //CMPf
    for ( int i = 0; i < N_CMPf; i++ ){

        double r = sfmt_genrand_real2 ( &( n_CMPf -> rng ) );
        n_CMPf -> s[ i ] = ( r < PHI_CMPf );
        n_CMPf -> ts[ i ] = ( n_CMPf -> s[ i ] ) * ( nt + 1 ) + ( !( n_CMPf -> s[ i ] ) ) * ( n_CMPf -> ts[ i ] );
    }
}