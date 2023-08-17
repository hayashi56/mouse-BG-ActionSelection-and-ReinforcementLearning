#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <time.h>

extern "C" { void timer_start( void ); }
extern "C" { double timer_elapsed( void ); }

// 積分発火型モデルで再現するそれぞれのニューロンの不応期を再現している関数
__global__ void t_refr_MSN_D1 ( neuron_t *n_MSN_D1 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D1 ){

        n_MSN_D1 -> refr [ i ] = ( n_MSN_D1 -> s [ i ] ) * ( T_REFR ) + ( !( n_MSN_D1 -> s [ i ] ) ) * ( ( n_MSN_D1 -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_MSN_D2 ( neuron_t *n_MSN_D2 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D2 ){

        n_MSN_D2 -> refr [ i ] = ( n_MSN_D2 -> s [ i ] ) * ( T_REFR ) + ( !( n_MSN_D2 -> s [ i ] ) ) * ( ( n_MSN_D2 -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_FSI ( neuron_t *n_FSI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_FSI ){

        n_FSI -> refr [ i ] = ( n_FSI -> s [ i ] ) * ( T_REFR ) + ( !( n_FSI -> s [ i ] ) ) * ( ( n_FSI -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_STN ( neuron_t *n_STN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_STN ){

        n_STN -> refr [ i ] = ( n_STN -> s [ i ] ) * ( T_REFR ) + ( !( n_STN -> s [ i ] ) ) * ( ( n_STN -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_GPe ( neuron_t *n_GPe ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPe ){

        n_GPe -> refr [ i ] = ( n_GPe -> s [ i ] ) * ( T_REFR ) + ( !( n_GPe -> s [ i ] ) ) * ( ( n_GPe -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_GPi ( neuron_t *n_GPi ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPi ){

        n_GPi -> refr [ i ] = ( n_GPi -> s [ i ] ) * ( T_REFR ) + ( !( n_GPi -> s [ i ] ) ) * ( ( n_GPi -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_SNc ( neuron_t *n_SNc ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_SNc ){

        n_SNc -> refr [ i ] = ( n_SNc -> s [ i ] ) * ( T_REFR ) + ( !( n_SNc -> s [ i ] ) ) * ( ( n_SNc -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_PTN ( neuron_t *n_PTN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTN ){

        n_PTN -> refr [ i ] = ( n_PTN -> s [ i ] ) * ( T_REFR ) + ( !( n_PTN -> s [ i ] ) ) * ( ( n_PTN -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_PTI ( neuron_t *n_PTI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTI ){

        n_PTI -> refr [ i ] = ( n_PTI -> s [ i ] ) * ( T_REFR ) + ( !( n_PTI -> s [ i ] ) ) * ( ( n_PTI -> refr [ i ] ) - 1 ); // set counter
    }
}
__global__ void t_refr_Th ( neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_Th ){

        n_Th -> refr [ i ] = ( n_Th -> s [ i ] ) * ( T_REFR ) + ( !( n_Th -> s [ i ] ) ) * ( ( n_Th -> refr [ i ] ) - 1 ); // set counter
    }
}

// 不応期を再現している関数をグリッド数とブロック数を指定してGPUで実行する関数
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

// ループによって時間変化を表現しシミュレーションを実行する関数
void simulat( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    // シミュレーションの計算時間の計測を開始
    timer_start();

    // シミュレーション内の時間を表す変数
    int nt;

    // 初期化時のランダム性から影響を受けないようにするための100[ms]のフリーラン
    for ( nt = 0; nt < FreeRun; nt++ ){
        // preニューロン毎のシナプス後電圧を計算
        updateSynapse ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );

        // それぞれのpostニューロンが受け取るシナプス後電圧の合計を計算
        InputSynapsePotential ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );

        // それぞれのニューロンの膜電位を計算し発火の有無を判定
        updatePotential( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );

        // 入力となるニューロンの発火の有無を判定
        input_neuron ( nt, n_PSN, n_CMPf );

        // 前の関数でわかった発火の有無をもとに不応期を計算
        t_refr ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
    }

    // 行動選択を行うという入力が無い時間範囲を再現するためのループ(0[ms]~1000[ms]の間)
    for ( ; nt < NT; nt++ ){

        // preニューロン毎のシナプス後電圧を計算
        updateSynapse ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );

        // それぞれのpostニューロンが受け取るシナプス後電圧の合計を計算
        InputSynapsePotential ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );

        // それぞれのニューロンの膜電位を計算し発火の有無を判定
        updatePotential( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );

        // 入力となるニューロンの発火の有無を判定
        input_neuron ( nt, n_PSN, n_CMPf );

        // 前の関数でわかった発火の有無をもとに不応期を計算
        t_refr ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );

        // それぞれのニューロンについて発火しているニューロンをそのシミュレーション内の時間と共に出力
        outputSpike ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );
    }

    // シミュレーションの計算時間
    double elapsedTime = timer_elapsed ();

    // シミュレーションに要した計算時間の出力
    printf ( "Elapsed time = %f sec.\n", elapsedTime );

    // 1000msのシミュレーションでのそれぞれのニューロンの１個あたりの発火率をファイル出力
    outputFiringRate ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );
}