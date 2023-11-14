#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include "param.h"

// 下記は各ニューロンについて積分発火モデル(Leaky integrate-and-fire model)における膜電位の更新や膜電位をもとに発火の有無を判定をGPUで並列計算する関数
__global__ void updatePotential_MSN_D1 ( int nt, neuron_t *n_MSN_D1 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D1 ){

        n_MSN_D1 -> v[ i ] += DT * ( - ( n_MSN_D1 -> v[ i ] - Er_MSN_D1 ) + Vc_MSN_D1 + ( rho * n_MSN_D1 -> i_syn[ i ] ) ) / TAU_MSN_D1;
        n_MSN_D1 -> s[ i ] = ( n_MSN_D1 -> v[ i ] > THETA_MSN_D1 ) * ( ( n_MSN_D1 -> refr[ i ] ) <= 0 );
        n_MSN_D1 -> ts[ i ] = ( n_MSN_D1 -> s[ i ] ) * ( nt + 1 ) + ( !( n_MSN_D1 -> s[ i ] ) ) * ( n_MSN_D1 -> ts[ i ] );
        n_MSN_D1 -> v[ i ] = ( n_MSN_D1 -> s[ i ] ) * Er_MSN_D1 + ( !( n_MSN_D1 -> s[ i ] ) ) * n_MSN_D1 -> v[ i ];
        n_MSN_D1 -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_MSN_D2 ( int nt, neuron_t *n_MSN_D2 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D2 ){

        n_MSN_D2 -> v[ i ] += DT * ( - ( n_MSN_D2 -> v[ i ] - Er_MSN_D2 ) + Vc_MSN_D2 + ( rho * n_MSN_D2 -> i_syn[ i ] ) ) / TAU_MSN_D2;
        n_MSN_D2 -> s[ i ] = ( n_MSN_D2 -> v[ i ] > THETA_MSN_D2 ) * ( ( n_MSN_D2 -> refr[ i ] ) <= 0 );
        n_MSN_D2 -> ts[ i ] = ( n_MSN_D2 -> s[ i ] ) * ( nt + 1 ) + ( !( n_MSN_D2 -> s[ i ] ) ) * ( n_MSN_D2 -> ts[ i ] );
        n_MSN_D2 -> v[ i ] = ( n_MSN_D2 -> s[ i ] ) * Er_MSN_D2 + ( !( n_MSN_D2 -> s[ i ] ) ) * n_MSN_D2 -> v[ i ];
        n_MSN_D2 -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_FSI ( int nt, neuron_t *n_FSI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_FSI ){

        n_FSI -> v[ i ] += DT * ( - ( n_FSI -> v[ i ] - Er_FSI ) + Vc_FSI + ( rho * n_FSI -> i_syn[ i ] ) ) / TAU_FSI;
        n_FSI -> s[ i ] = ( n_FSI -> v[ i ] > THETA_FSI ) * ( ( n_FSI -> refr[ i ] ) <= 0 );
        n_FSI -> ts[ i ] = ( n_FSI -> s[ i ] ) * ( nt + 1 ) + ( !( n_FSI -> s[ i ] ) ) * ( n_FSI -> ts[ i ] );
        n_FSI -> v[ i ] = ( n_FSI -> s[ i ] ) * Er_FSI + ( !( n_FSI -> s[ i ] ) ) * n_FSI -> v[ i ];
        n_FSI -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_STN ( int nt, neuron_t *n_STN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_STN ){

        n_STN -> v[ i ] += DT * ( - ( n_STN -> v[ i ] - Er_STN ) + Vc_STN + ( rho * n_STN -> i_syn[ i ] ) ) / TAU_STN;
        n_STN -> s[ i ] = ( n_STN -> v[ i ] > THETA_STN ) * ( ( n_STN -> refr [ i ] ) <= 0 );
        n_STN -> ts[ i ] = ( n_STN -> s[ i ]) * ( nt + 1 ) + ( !( n_STN -> s[ i ] ) ) * ( n_STN -> ts[ i ] );
        n_STN -> v[ i ] = ( n_STN -> s[ i ] ) * Er_STN + ( !( n_STN -> s[ i ] ) ) * n_STN -> v[ i ];
        n_STN -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_GPe ( int nt, neuron_t *n_GPe ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPe ){

        n_GPe -> v[ i ] += DT * ( - ( n_GPe -> v[ i ] - Er_GPe ) + Vc_GPe + ( rho * n_GPe -> i_syn[ i ] ) ) / TAU_GPe;
        n_GPe -> s[ i ] = ( n_GPe -> v[ i ] > THETA_GPe ) * ( ( n_GPe -> refr [ i ] ) <= 0 );
        n_GPe -> ts[ i ] = ( n_GPe -> s[ i ] ) * ( nt + 1 ) + ( !( n_GPe -> s[ i ] ) ) * ( n_GPe -> ts[ i ] );
        n_GPe -> v[ i ] = ( n_GPe -> s[ i ] ) * Er_GPe + ( !( n_GPe -> s[ i ] ) ) * n_GPe -> v[ i ];
        n_GPe -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_GPi ( int nt, neuron_t *n_GPi ){
    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPi ){

        n_GPi -> v[ i ] += DT * ( - ( n_GPi -> v[ i ] - Er_GPi ) + Vc_GPi + ( rho * n_GPi -> i_syn[ i ] ) ) / TAU_GPi;
        n_GPi -> s[ i ] = ( n_GPi -> v[ i ] > THETA_GPi ) * ( ( n_GPi -> refr [ i ] ) <= 0 );
        n_GPi -> ts[ i ] = ( n_GPi -> s[ i ] ) * ( nt + 1 ) + ( !( n_GPi -> s[ i ] ) ) * ( n_GPi -> ts[ i ] );
        n_GPi -> v[ i ] = ( n_GPi -> s[ i ] ) * Er_GPi + ( !( n_GPi -> s[ i ] ) ) * n_GPi -> v[ i ];
        n_GPi -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_SNc ( int nt, neuron_t *n_SNc ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_SNc ){

        n_SNc -> v[ i ] += DT * ( - ( n_SNc -> v[ i ] - Er_SNc ) + Vc_SNc + ( rho * n_SNc -> i_syn[ i ] ) ) / TAU_SNc;
        n_SNc -> s[ i ] = ( n_SNc -> v[ i ] > THETA_SNc ) * ( ( n_SNc -> refr [ i ] ) <= 0 );
        n_SNc -> ts[ i ] = ( n_SNc -> s[ i ] ) * ( nt + 1 ) + ( !( n_SNc -> s[ i ] ) ) * ( n_SNc -> ts[ i ] );
        n_SNc -> v[ i ] = ( n_SNc -> s[ i ] ) * Er_SNc + ( !( n_SNc -> s[ i ] ) ) * n_SNc -> v[ i ];
        n_SNc -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_PTN ( int nt, neuron_t *n_PTN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTN ){

        n_PTN -> v[ i ] += DT * ( - ( n_PTN -> v[ i ] - Er_PTN ) + Vc_PTN + ( rho * n_PTN -> i_syn[ i ] ) ) / TAU_PTN;
        n_PTN -> s[ i ] = ( n_PTN -> v[ i ] > THETA_PTN ) * ( ( n_PTN -> refr [ i ] ) <= 0 );
        n_PTN -> ts[ i ] = ( n_PTN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PTN -> s[ i ] ) ) * ( n_PTN -> ts[ i ] );
        n_PTN -> v[ i ] = ( n_PTN -> s[ i ] ) * Er_PTN + ( !( n_PTN -> s[ i ] ) ) * n_PTN -> v[ i ];
        n_PTN -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_PTI ( int nt, neuron_t *n_PTI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTI ){

        n_PTI -> v[ i ] += DT * ( - ( n_PTI -> v[ i ] - Er_PTI ) + Vc_PTI + ( rho * n_PTI -> i_syn[ i ] ) ) / TAU_PTI;
        n_PTI -> s[ i ] = ( n_PTI -> v[ i ] > THETA_PTI && n_PTI -> refr [ i ] <= 0 );
        n_PTI -> ts[ i ] = ( n_PTI -> s[ i ] ) * ( nt + 1 ) + ( !( n_PTI -> s[ i ] ) ) * ( n_PTI -> ts[ i ] );
        n_PTI -> v[ i ] = ( n_PTI -> s[ i ] ) * Er_PTI + ( !( n_PTI -> s[ i ] ) ) * n_PTI -> v[ i ];
        n_PTI -> i_syn[ i ] = PSP_RESET;
    }
}
__global__ void updatePotential_Th ( int nt, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_Th ){

        n_Th -> v[ i ] += DT * ( - ( n_Th -> v[ i ] - Er_Th ) + Vc_Th + ( rho * n_Th -> i_syn[ i ] ) ) / TAU_Th;
        n_Th -> s[ i ] = ( n_Th -> v[ i ] > THETA_Th ) * ( ( n_Th -> refr [ i ] ) <= 0 );
        n_Th -> ts[ i ] = ( n_Th -> s[ i ] ) * ( nt + 1 ) + ( !( n_Th -> s[ i ] ) ) * ( n_Th -> ts[ i ] );
        n_Th -> v[ i ] = ( n_Th -> s[ i ] ) * Er_Th + ( !( n_Th -> s[ i ] ) ) * n_Th -> v[ i ];
        n_Th -> i_syn[ i ] = PSP_RESET;
    }
}


// 下記はLIF modelでの更新の関数をCPUで各ニューロンについて実行する関数
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


/*
下記は外部入力を担っているニューロンをポアソンスパイクで再現した際の発火の有無を判定する関数で、
change_input_neuronは入力を安静時の発火率から変化させ、入力に選択肢の選択性を提示する関数
input_neuronは入力を安静時の発火率で行う関数
*/
void input ( int nt, neuron_t *n_PSN, neuron_t *n_CMPf, int channel ){

    if ( channel == 9 || channel == 10 ){
        for ( int i = 0 + ( per_chanel_N_PTN * channel ); i < per_chanel_N_PTN  * ( channel + 1 ); i++ ){

            double r = sfmt_genrand_real2 ( &n_PSN -> rng );
            n_PSN -> s[ i ] =  r < ( PHI_MIN_PSN + ( ( ( PHI_MAX_PSN - PHI_MIN_PSN ) * CHANGE_FR ) / N_i ) * n_PSN -> select[ i ] );
            n_PSN -> ts[ i ] = ( n_PSN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSN -> s[ i ] ) ) * ( n_PSN -> ts[ i ] );
        }
    }
    else{
        for ( int i = 0 + ( per_chanel_N_PTN * channel ); i < per_chanel_N_PTN  * ( channel + 1 ); i++ ){

            double r = sfmt_genrand_real2 ( &n_PSN -> rng );
            n_PSN -> s[ i ] =  r < ( PHI_MIN_PSN + ( ( ( PHI_MAX_PSN - PHI_MIN_PSN ) * REST_FR ) / N_i ) * n_PSN -> select[ i ] );
            n_PSN -> ts[ i ] = ( n_PSN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSN -> s[ i ] ) ) * ( n_PSN -> ts[ i ] );
        }
    }
}

void change_input_neuron ( int nt, neuron_t *n_PSN, neuron_t *n_CMPf ){

    //sensory cortexについて
    for ( int channel = 0; channel < 20; channel++ ){
        
        input( nt, n_PSN, n_CMPf, channel );
    }
    //CMPfについて
    for ( int i = 0; i < N_CMPf; i++ ){

        double r = sfmt_genrand_real2 ( &n_CMPf -> rng );
        n_CMPf -> s[ i ] = ( r < PHI_CMPf );
        n_CMPf -> ts[ i ] = ( n_CMPf -> s[ i ] ) * ( nt + 1 ) + ( !( n_CMPf -> s[ i ] ) ) * ( n_CMPf -> ts[ i ] );
    }
}

void input_neuron ( int nt, neuron_t *n_PSN, neuron_t *n_CMPf ){

    //PSNについて
    for ( int i = 0; i < N_PSN; i++ ){

        double r = sfmt_genrand_real2 ( &n_PSN -> rng );
        n_PSN -> s[ i ] = ( r < PHI_MIN_PSN );
        n_PSN -> ts[ i ] = ( n_PSN -> s[ i ] ) * ( nt + 1 ) + ( !( n_PSN -> s[ i ] ) ) * ( n_PSN -> ts[ i ] );
    }
    //CMPfについて
    for ( int i = 0; i < N_CMPf; i++ ){

        double r = sfmt_genrand_real2 ( &n_CMPf -> rng );
        n_CMPf -> s[ i ] = ( r < PHI_CMPf );
        n_CMPf -> ts[ i ] = ( n_CMPf -> s[ i ] ) * ( nt + 1 ) + ( !( n_CMPf -> s[ i ] ) ) * ( n_CMPf -> ts[ i ] );
    }
}