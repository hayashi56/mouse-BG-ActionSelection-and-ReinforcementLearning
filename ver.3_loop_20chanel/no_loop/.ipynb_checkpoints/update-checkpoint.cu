#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

//膜電位の更新
// MSN_D1
__global__ void updatePotential_MSN_D1 ( int nt, neuron_t *n_MSN_D1 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D1 ){

        n_MSN_D1 -> v[ i ] += DT * ( - ( n_MSN_D1 -> v[ i ] ) + Vc_MSN_D1 + ( rho * n_MSN_D1 -> ig[ i ] ) ) / TAU_MSN_D1;
        n_MSN_D1 -> v [ i ] = ( ( n_MSN_D1 -> refr [ i ] ) > 0 ) ? ( V_RESET ) : ( ( n_MSN_D1 -> v [ i ] ) );
        n_MSN_D1 -> s[ i ] = ( n_MSN_D1 -> v[ i ] > THETA_MSN_D1 );
        n_MSN_D1 -> ts[ i ] = ( n_MSN_D1 -> s[ i ] ) * ( nt + 1 ) + ( !( n_MSN_D1 -> s[ i ] ) ) * ( n_MSN_D1 -> ts[ i ] );
        n_MSN_D1 -> v[ i ] = ( n_MSN_D1 -> s[ i ] ) * V_RESET + ( !( n_MSN_D1 -> s[ i ] ) ) * n_MSN_D1 -> v[ i ];
        n_MSN_D1 -> ig[ i ] = V_RESET;
    }
}
// MSN_D2
__global__ void updatePotential_MSN_D2 ( int nt, neuron_t *n_MSN_D2 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D2 ){

        n_MSN_D2 -> v[ i ] += DT * ( - ( n_MSN_D2 -> v[ i ] ) + Vc_MSN_D2 + ( rho * n_MSN_D2 -> ig[ i ] ) ) / TAU_MSN_D2;
        n_MSN_D2 -> s[ i ] = ( n_MSN_D2 -> v[ i ] > THETA_MSN_D2 );
        n_MSN_D2 -> ts[ i ] = ( n_MSN_D2 -> s[ i ] ) * ( nt + 1 ) + ( !( n_MSN_D2 -> s[ i ] ) ) * ( n_MSN_D2 -> ts[ i ] );
        n_MSN_D2 -> v[ i ] = ( n_MSN_D2 -> s[ i ] ) * V_RESET + ( !( n_MSN_D2 -> s[ i ] ) ) * n_MSN_D2 -> v[ i ];
        n_MSN_D2 -> ig[ i ] = V_RESET;
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
// SNc
__global__ void updatePotential_SNc ( int nt, neuron_t *n_SNc ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_SNc ){

        n_SNc -> v[ i ] += DT * ( - ( n_SNc -> v[ i ] ) + Vc_SNc + ( rho * n_SNc -> ig[ i ] ) ) / TAU_SNc;
        n_SNc -> s[ i ] = ( n_SNc -> v[ i ] > THETA_SNc );
        n_SNc -> ts[ i ] = ( n_SNc -> s[ i ] ) * ( nt + 1 ) + ( !( n_SNc -> s[ i ] ) ) * ( n_SNc -> ts[ i ] );
        n_SNc -> v[ i ] = ( n_SNc -> s[ i ] ) * V_RESET + ( !( n_SNc -> s[ i ] ) ) * n_SNc -> v[ i ];
        n_SNc -> ig[ i ] = V_RESET;
    }
}
// PTN
__global__ void updatePotential_PTN ( int nt, neuron_t *n_PTN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTN ){

        n_PTN -> v[ i ] += DT * ( - ( n_PTN -> v[ i ] ) + Vc_PTN /*- 91.7*/ + ( rho * n_PTN -> ig[ i ] ) ) / TAU_PTN;
        n_PTN -> s[ i ] = ( n_PTN -> v[ i ] > THETA_PTN );
        n_PTN -> ts[ i ] = ( n_PTN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PTN -> s[ i ] ) ) * ( n_PTN -> ts[ i ] );
        n_PTN -> v[ i ] = ( n_PTN -> s[ i ] ) * V_RESET + ( !( n_PTN -> s[ i ] ) ) * n_PTN -> v[ i ];
        n_PTN -> ig[ i ] = V_RESET;
    }
}
// PTI
__global__ void updatePotential_PTI ( int nt, neuron_t *n_PTI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTI ){

        n_PTI -> v[ i ] += DT * ( - ( n_PTI -> v[ i ] ) + Vc_PTI + ( rho * n_PTI -> ig[ i ] ) ) / TAU_PTI;
        n_PTI -> s[ i ] = ( n_PTI -> v[ i ] > THETA_PTI );
        n_PTI -> ts[ i ] = ( n_PTI -> s[ i ] ) * ( nt + 1 ) + ( !( n_PTI -> s[ i ] ) ) * ( n_PTI -> ts[ i ] );
        n_PTI -> v[ i ] = ( n_PTI -> s[ i ] ) * V_RESET + ( !( n_PTI -> s[ i ] ) ) * n_PTI -> v[ i ];
        n_PTI -> ig[ i ] = V_RESET;
    }
}
// Th
__global__ void updatePotential_Th ( int nt, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_Th ){

        n_Th -> v[ i ] += DT * ( - ( n_Th -> v[ i ] ) + Vc_Th + ( rho * n_Th -> ig[ i ] ) ) / TAU_Th;
        n_Th -> s[ i ] = ( n_Th -> v[ i ] > THETA_Th );
        n_Th -> ts[ i ] = ( n_Th -> s[ i ] ) * ( nt + 1 ) + ( !( n_Th -> s[ i ] ) ) * ( n_Th -> ts[ i ] );
        n_Th -> v[ i ] = ( n_Th -> s[ i ] ) * V_RESET + ( !( n_Th -> s[ i ] ) ) * n_Th -> v[ i ];
        n_Th -> ig[ i ] = V_RESET;
    }
}

void updatePotential ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_Th ){

    updatePotential_MSN_D1 <<< GRID_SIZE_MSN_D1, BLOCK_SIZE >>> ( nt, n_MSN_D1 );
    cudaDeviceSynchronize ( );
    updatePotential_MSN_D2 <<< GRID_SIZE_MSN_D2, BLOCK_SIZE >>> ( nt, n_MSN_D2 );
    cudaDeviceSynchronize ( );
    updatePotential_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( nt, n_FSI );
    cudaDeviceSynchronize ( );
    updatePotential_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( nt, n_STN );
    cudaDeviceSynchronize ( );
    updatePotential_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( nt, n_GPe );
    cudaDeviceSynchronize ( );
    updatePotential_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( nt, n_GPi );
    cudaDeviceSynchronize ( );
    updatePotential_SNc <<< GRID_SIZE_SNc, BLOCK_SIZE >>> ( nt, n_SNc );
    cudaDeviceSynchronize ( );
    updatePotential_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( nt, n_PTN );
    cudaDeviceSynchronize ( );
    updatePotential_PTI <<< GRID_SIZE_PTI, BLOCK_SIZE >>> ( nt, n_PTI );
    cudaDeviceSynchronize ( );
    updatePotential_Th <<< GRID_SIZE_Th, BLOCK_SIZE >>> ( nt, n_Th );
    cudaDeviceSynchronize ( );
}
//ポアソンモデル
void change_inputneuron ( int nt, neuron_t *n_PSA, neuron_t *n_CMPf, int chanel1, int chanel2, int chanel3, int chanel4, int chanel5, int chanel6, int chanel7, int chanel8, int chanel9, int chanel10 ){


    int i;

    //PSA
    for ( i = 0; i < per_chanel_N_PSA; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel1 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 2; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel2 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 3; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel3 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 4; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel4 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 5; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel5 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 6; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel6 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 7; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel7 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 8; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel8 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < per_chanel_N_PSA * 9; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel9 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }
    for ( ; i < N_PSA; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s [ i ] =  r < ( PHI_MIN_PSA + ( ( ( PHI_MAX_PSA - PHI_MIN_PSA ) * chanel10 ) / N_i ) * n_PSA -> select [ i ] );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }

    //CMPf
    for ( int i = 0; i < N_CMPf; i++ ){

        double r = sfmt_genrand_real2 ( &( n_CMPf -> rng ) );
        n_CMPf -> s[ i ] = ( r < PHI_CMPf );
        n_CMPf -> ts[ i ] = ( n_CMPf -> s[ i ] ) * ( nt + 1 ) + ( !( n_CMPf -> s[ i ] ) ) * ( n_CMPf -> ts[ i ] );
    }
}

void inputneuron ( int nt, neuron_t *n_PSA, neuron_t *n_CMPf ){

    //PSA
    for ( int i = 0; i < N_PSA; i++ ){

        double r = sfmt_genrand_real2 ( &( n_PSA -> rng ) );
        n_PSA -> s[ i ] = ( r < PHI_MIN_PSA );
        n_PSA -> ts[ i ] = ( n_PSA -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSA -> s[ i ] ) ) * ( n_PSA -> ts[ i ] );
    }

    //CMPf
    for ( int i = 0; i < N_CMPf; i++ ){

        double r = sfmt_genrand_real2 ( &( n_CMPf -> rng ) );
        n_CMPf -> s[ i ] = ( r < PHI_CMPf );
        n_CMPf -> ts[ i ] = ( n_CMPf -> s[ i ] ) * ( nt + 1 ) + ( !( n_CMPf -> s[ i ] ) ) * ( n_CMPf -> ts[ i ] );
    }
}