#include <stdio.h>
#include <stdlib.h>
#include <SFMT.h>
#include <random>
#include <algorithm>
#include <vector>
#include "param.h"

// それぞれのニューロンのデータを出力するためのファイルを参照する関数
void file_open ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    n_MSN_D1 -> file = fopen ( "MSN_D1spike.dat", "w" );
    n_MSN_D2 -> file = fopen ( "MSN_D2spike.dat", "w" );
    n_FSI -> file = fopen ( "FSIspike.dat", "w" );
    n_STN -> file = fopen ( "STNspike.dat", "w" );
    n_GPe -> file = fopen ( "GPespike.dat", "w" );
    n_GPi -> file = fopen ( "GPispike.dat", "w" );
    n_SNc -> file = fopen ( "SNcspike.dat", "w" );
    n_PTN -> file = fopen ( "PTNspike.dat", "w" );
    n_PTI -> file = fopen ( "PTIspike.dat", "w" );
    n_PSN -> file = fopen ( "PSNspike.dat", "w" );
    n_Th -> file = fopen ( "Thspike.dat", "w" );
    n_CMPf -> file = fopen ( "CMPfspike.dat", "w" );
}

// 構造体内のそれぞれのニューロンに関する値を格納する配列のメモリ確保をする関数
void Allocating_Neuron ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    cudaMallocManaged ( &n_MSN_D1 -> v, sizeof ( float ) * N_MSN_D1 );
    cudaMallocManaged ( &n_MSN_D1 -> ig, sizeof ( float ) * N_MSN_D1 );
    cudaMallocManaged ( &n_MSN_D1 -> psp_GABA, sizeof ( float ) * N_MSN_D1 );
    cudaMallocManaged ( &n_MSN_D1 -> refr, sizeof ( int ) * N_MSN_D1 );
    cudaMallocManaged ( &n_MSN_D1 -> ts, sizeof ( int ) * N_MSN_D1 );
    cudaMallocManaged ( &n_MSN_D1 -> s, sizeof ( bool ) * N_MSN_D1 );
    cudaMallocManaged ( &n_MSN_D1 -> counter, sizeof ( int ) * N_MSN_D1 );
    cudaMallocManaged ( &n_MSN_D1 -> num_pre, sizeof ( long ) * N_MSN_D1 * 9 );

    cudaMallocManaged ( &n_MSN_D2 -> v, sizeof ( float ) * N_MSN_D2 );
    cudaMallocManaged ( &n_MSN_D2 -> ig, sizeof ( float ) * N_MSN_D2 );
    cudaMallocManaged ( &n_MSN_D2 -> psp_GABA, sizeof ( float ) * N_MSN_D2 );
    cudaMallocManaged ( &n_MSN_D2 -> refr, sizeof ( int ) * N_MSN_D2 );
    cudaMallocManaged ( &n_MSN_D2 -> ts, sizeof ( int ) * N_MSN_D2 );
    cudaMallocManaged ( &n_MSN_D2 -> s, sizeof ( bool ) * N_MSN_D2 );
    cudaMallocManaged ( &n_MSN_D2 -> counter, sizeof ( int ) * N_MSN_D2 );
    cudaMallocManaged ( &n_MSN_D2 -> num_pre, sizeof ( long ) * N_MSN_D2 * 9 );

    cudaMallocManaged ( &n_FSI -> v, sizeof ( float ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> ig, sizeof ( float ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> psp_GABA, sizeof ( float ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> s, sizeof ( bool ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> ts, sizeof ( int ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> refr, sizeof ( int ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> counter, sizeof ( int ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> num_pre, sizeof ( long ) * N_FSI * 6 );

    cudaMallocManaged ( &n_STN -> v, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> ig, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> psp_AMPA, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> psp_NMDA, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> s, sizeof ( bool ) * N_STN );
    cudaMallocManaged ( &n_STN -> ts, sizeof ( int ) * N_STN );
    cudaMallocManaged ( &n_STN -> refr, sizeof ( int ) * N_STN );
    cudaMallocManaged ( &n_STN -> counter, sizeof ( int ) * N_STN );
    cudaMallocManaged ( &n_STN -> num_pre, sizeof ( long ) * N_STN * 3 );

    cudaMallocManaged ( &n_GPe -> v, sizeof ( float ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> ig, sizeof ( float ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> psp_GABA, sizeof ( float ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> s, sizeof ( bool ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> ts, sizeof ( int ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> refr, sizeof ( int ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> counter, sizeof ( int ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> num_pre, sizeof ( long ) * N_GPe * 5 );

    cudaMallocManaged ( &n_GPi -> v, sizeof ( float ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> ig, sizeof ( float ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> psp_GABA, sizeof ( float ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> s, sizeof ( bool ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> ts, sizeof ( int ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> refr, sizeof ( int ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> counter, sizeof ( int ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> num_pre, sizeof ( long ) * N_GPi * 5 );

    cudaMallocManaged ( &n_SNc -> v, sizeof ( float ) * N_SNc );
    cudaMallocManaged ( &n_SNc -> ig, sizeof ( float ) * N_SNc );
    cudaMallocManaged ( &n_SNc -> psp_DOPA, sizeof ( float ) * N_SNc );
    cudaMallocManaged ( &n_SNc -> s, sizeof ( bool ) * N_SNc );
    cudaMallocManaged ( &n_SNc -> ts, sizeof ( int ) * N_SNc );
    cudaMallocManaged ( &n_SNc -> refr, sizeof ( int ) * N_SNc );
    cudaMallocManaged ( &n_SNc -> counter, sizeof ( int ) * N_SNc );
    cudaMallocManaged ( &n_SNc -> num_pre, sizeof ( long ) * N_SNc * 2 );

    cudaMallocManaged ( &n_PTN -> v, sizeof ( float ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> ig, sizeof ( float ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> psp_AMPA, sizeof ( float ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> psp_NMDA, sizeof ( float ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> s, sizeof ( bool ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> ts, sizeof ( int ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> refr, sizeof ( int ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> counter, sizeof ( int ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> num_pre, sizeof ( long ) * N_PTN * 3 );

    cudaMallocManaged ( &n_PTI -> v, sizeof ( float ) * N_PTI );
    cudaMallocManaged ( &n_PTI -> ig, sizeof ( float ) * N_PTI );
    cudaMallocManaged ( &n_PTI -> psp_GABA, sizeof ( float ) * N_PTI );
    cudaMallocManaged ( &n_PTI -> s, sizeof ( bool ) * N_PTI );
    cudaMallocManaged ( &n_PTI -> ts, sizeof ( int ) * N_PTI );
    cudaMallocManaged ( &n_PTI -> refr, sizeof ( int ) * N_PTI );
    cudaMallocManaged ( &n_PTI -> counter, sizeof ( int ) * N_PTI );
    cudaMallocManaged ( &n_PTI -> num_pre, sizeof ( long ) * N_PTI );

    cudaMallocManaged ( &n_PSN -> psp_AMPA, sizeof ( float ) * N_PSN );
    cudaMallocManaged ( &n_PSN -> psp_NMDA, sizeof ( float ) * N_PSN );
    cudaMallocManaged ( &n_PSN -> s, sizeof ( bool ) * N_PSN );
    cudaMallocManaged ( &n_PSN -> ts, sizeof ( int ) * N_PSN );
    cudaMallocManaged ( &n_PSN -> counter, sizeof ( int ) * N_PSN );
    cudaMallocManaged ( &n_PSN -> select, sizeof ( bool ) * N_PSN );

    cudaMallocManaged ( &n_Th -> v, sizeof ( float ) * N_Th );
    cudaMallocManaged ( &n_Th -> ig, sizeof ( float ) * N_Th );
    cudaMallocManaged ( &n_Th -> psp_AMPA, sizeof ( float ) * N_Th );
    cudaMallocManaged ( &n_Th -> psp_NMDA, sizeof ( float ) * N_Th );
    cudaMallocManaged ( &n_Th -> s, sizeof ( bool ) * N_Th );
    cudaMallocManaged ( &n_Th -> ts, sizeof ( int ) * N_Th );
    cudaMallocManaged ( &n_Th -> refr, sizeof ( int ) * N_Th );
    cudaMallocManaged ( &n_Th -> counter, sizeof ( int ) * N_Th );
    cudaMallocManaged ( &n_Th -> num_pre, sizeof ( long ) * N_Th * 2 );

    cudaMallocManaged ( &n_CMPf -> psp_AMPA, sizeof ( float ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> psp_NMDA, sizeof ( float ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> s, sizeof ( bool ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> ts, sizeof ( int ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> counter, sizeof ( int ) * N_CMPf );
}

// ニューロンの値の初期化をする関数
void initalize_Neuron ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    for ( int i = 0; i < N_MSN_D1; i++ ){

        n_MSN_D1 -> v[ i ] = Er_MSN_D1 + 10. * sfmt_genrand_real2 ( &n_MSN_D1 -> rng );
        n_MSN_D1 -> ig[ i ] = 0;
        n_MSN_D1 -> psp_GABA[ i ] = 0;
        n_MSN_D1 -> s[ i ] = false;
        n_MSN_D1 -> ts[ i ] = 1000;
        n_MSN_D1 -> refr[ i ] = 0;
        n_MSN_D1 -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_MSN_D2; i++ ){

        n_MSN_D2 -> v[ i ] = Er_MSN_D2 + 10. * sfmt_genrand_real2 ( &n_MSN_D2 -> rng );
        n_MSN_D2 -> ig[ i ] = 0;
        n_MSN_D2 -> psp_GABA[ i ] = 0;
        n_MSN_D2 -> s[ i ] = false;
        n_MSN_D2 -> ts[ i ] = 1000;
        n_MSN_D2 -> refr[ i ] = 0;
        n_MSN_D2 -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_FSI; i++ ){

        n_FSI -> v[ i ] = Er_FSI + 10. * sfmt_genrand_real2 ( &n_FSI -> rng );
        n_FSI -> ig[ i ] = 0;
        n_FSI -> psp_GABA[ i ] = 0;
        n_FSI -> s[ i ] = false;
        n_FSI -> ts[ i ] = 1000;
        n_FSI -> refr[ i ] = 0;
        n_FSI -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_STN; i++ ){

        n_STN -> v[ i ] = Er_STN + 10. * sfmt_genrand_real2 ( &n_STN -> rng );
        n_STN -> ig[ i ] = 0;
        n_STN -> psp_AMPA[ i ] = 0;
        n_STN -> psp_NMDA[ i ] = 0;
        n_STN -> s[ i ] = false;
        n_STN -> ts[ i ] = 1000;
        n_STN -> refr[ i ] = 0;
        n_STN -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_GPe; i++ ){

        n_GPe -> v[ i ] = Er_GPe + 10. * sfmt_genrand_real2 ( &n_GPe -> rng );
        n_GPe -> ig[ i ] = 0;
        n_GPe -> psp_GABA[ i ] = 0;
        n_GPe -> s[ i ] = false;
        n_GPe -> ts[ i ] = 1000;
        n_GPe -> refr[ i ] = 0;
        n_GPe -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_GPi; i++ ){

        n_GPi -> v[ i ] = Er_GPi + 10. * sfmt_genrand_real2 ( &n_GPi -> rng );
        n_GPi -> ig[ i ] = 0;
        n_GPi -> psp_GABA[ i ] = 0;
        n_GPi -> s[ i ] = false;
        n_GPi -> ts[ i ] = 1000;
        n_GPi -> refr[ i ] = 0;
        n_GPi -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_SNc; i++ ){

        n_SNc -> v[ i ] = Er_SNc + 10. * sfmt_genrand_real2 ( &n_SNc -> rng );
        n_SNc -> ig[ i ] = 0;
        n_SNc -> psp_DOPA[ i ] = 0;
        n_SNc -> s[ i ] = false;
        n_SNc -> ts[ i ] = 1000;
        n_SNc -> refr[ i ] = 0;
        n_SNc -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_PTN; i++ ){

        n_PTN -> v[ i ] = Er_PTN + 10. * sfmt_genrand_real2 ( &n_PTN -> rng );
        n_PTN -> ig[ i ] = 0;
        n_PTN -> psp_AMPA[ i ] = 0;
        n_PTN -> psp_NMDA[ i ] = 0;
        n_PTN -> s[ i ] = false;
        n_PTN -> ts[ i ] = 1000;
        n_PTN -> refr[ i ] = 0;
        n_PTN -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_PSN; i++ ){

        n_PSN -> psp_AMPA[ i ] = 0;
        n_PSN -> psp_NMDA[ i ] = 0;
        n_PSN -> s[ i ] = false;
        n_PSN -> ts[ i ] = 1000;
        n_PSN -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_PTI; i++ ){

        n_PTI -> v[ i ] = Er_PTI + 10. * sfmt_genrand_real2 ( &n_PTI -> rng );
        n_PTI -> ig[ i ] = 0;
        n_PTI -> psp_GABA[ i ] = 0;
        n_PTI -> s[ i ] = false;
        n_PTI -> ts[ i ] = 1000;
        n_PTI -> refr[ i ] = 0;
        n_PTI -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_Th; i++ ){

        n_Th -> v[ i ] = Er_Th + 10. * sfmt_genrand_real2 ( &n_Th -> rng );
        n_Th -> ig[ i ] = 0;
        n_Th -> psp_AMPA[ i ] = 0;
        n_Th -> psp_NMDA[ i ] = 0;
        n_Th -> s[ i ] = false;
        n_Th -> ts[ i ] = 1000;
        n_Th -> refr[ i ] = 0;
        n_Th -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_CMPf; i++ ){

        n_CMPf -> psp_AMPA[ i ] = 0;
        n_CMPf -> psp_NMDA[ i ] = 0;
        n_CMPf -> s[ i ] = false;
        n_CMPf -> ts[ i ] = 1000;
        n_CMPf -> counter[ i ] = 0;
    }
}

// シナプスについてのメモリ確保・初期化をする関数
void initalize_synapse( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_Th ){

    int k = 0;
    long post_synapse = 0;
    long count = 0;
    long count_pre = 0;

    srand ( 1 );
    // CMPf→MSN_D1(拡散型)
    post_synapse += N_CMPf * N_MSN_D1;

    // MSN_D1→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_MSN_D1; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND1MSND1 );
        }
    }
    post_synapse += count;
    count = 0;

    // MSN_D2→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_MSN_D2; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND2MSND1 );
        }
    }
    post_synapse += count;
    count = 0;

    // FSI→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_FSI; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_FSIMSND1 );
        }
    }
    post_synapse += count;
    count = 0;

    // STN→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNMSND1 );
        }
    }
    post_synapse += count;
    count = 0;

    // GPe→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand ( ) / RAND_MAX ) < P_GPeMSND1 );
        }
    }
    post_synapse += count;
    count = 0;

    // SNc→MSN_D1(拡散型？)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_SNc; j++ ){
            count += ( long ) ( ( ( double ) rand ( ) / RAND_MAX ) < P_SNcMSND1 );
        }
    }
    post_synapse += count;
    count = 0;

    // PTN→MSN_D1(集中型)
    post_synapse += per_chanel_N_PTN * per_chanel_N_MSN_D1 * N_chanel;

    // PSN→MSN_D1(集中型)
    post_synapse += per_chanel_N_PSN * per_chanel_N_MSN_D1 * N_chanel;

    cudaMallocManaged ( &n_MSN_D1 -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // CMPf→MSN_D2(拡散型)
    post_synapse += N_CMPf * N_MSN_D2;

    // MSN_D1→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_MSN_D1; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND1MSND2 );
        }
    }
    post_synapse += count;
    count = 0;

    // MSN_D2→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_MSN_D2; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND2MSND2 );
        }
    }
    post_synapse += count;
    count = 0;

    // FSI→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_FSI; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_FSIMSND2 );
        }
    }
    post_synapse += count;
    count = 0;

    // STN→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNMSND2 );
        }
    }
    post_synapse += count;
    count = 0;

    // GPe→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand ( ) / RAND_MAX ) < P_GPeMSND2 );
        }
    }
    post_synapse += count;
    count = 0;

    // SNc→MSN_D2(拡散型？)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_SNc; j++ ){
            count += ( long ) ( ( ( double ) rand ( ) / RAND_MAX ) < P_SNcMSND2 );
        }
    }
    post_synapse += count;
    count = 0;

    // PTN→MSN_D2(集中型)
    post_synapse += per_chanel_N_PTN * per_chanel_N_MSN_D2 * N_chanel;

    // PSN→MSN_D2(集中型)
    post_synapse += per_chanel_N_PSN * per_chanel_N_MSN_D2 * N_chanel;

    cudaMallocManaged ( &n_MSN_D2 -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // CMPf→FSI(拡散型)
    post_synapse += N_CMPf * N_FSI;

    // FSI→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_FSI; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_FSIFSI );
        }
    }
    post_synapse += count;
    count = 0;

    // STN→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNFSI );
        }
    }
    post_synapse += count;
    count = 0;

    // GPe→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_GPeFSI );
        }
    }
    post_synapse += count;
    count = 0;

    // PTN→FSI(集中型)
    post_synapse += per_chanel_N_PTN * per_chanel_N_FSI * N_chanel;

    // PSN→FSI(集中型)
    post_synapse += per_chanel_N_PSN * per_chanel_N_FSI * N_chanel;

    cudaMallocManaged ( &n_FSI -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // CMPf→STN(拡散型)
    post_synapse += N_CMPf * N_STN;

    // GPe→STN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_STN; i++ ){
            for ( long j = 0; j < per_chanel_N_GPe; j++ ){
                count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_GPeSTN );
            }
        }
    }
    post_synapse += count;
    count = 0;

    // PTN→STN(集中型)
    post_synapse += per_chanel_N_PTN * per_chanel_N_STN * N_chanel;

    cudaMallocManaged ( &n_STN -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // CMPf→GPe(拡散型)
    post_synapse += N_CMPf * N_GPe;

    // MSN_D1→GPe(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPe; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D1; j++ ){
                count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND1GPe );
            }
        }
    }
    post_synapse += count;
    count = 0;

    // MSN_D2→GPe(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPe; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D2; j++ ){
                count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND2GPe );
            }
        }
    }
    post_synapse += count;
    count = 0;

    // STN→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNGPe );
        }
    }
    post_synapse += count;
    count = 0;

    // GPe→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPe );
        }
    }
    post_synapse += count;
    count = 0;

    cudaMallocManaged ( &n_GPe -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // CMPf→GPi(拡散型)
    post_synapse += N_CMPf * N_GPi;

    // MSN_D1→GPi(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPi; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D1; j++ ){
                count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND1GPi );
            }
        }
    }
    post_synapse += count;
    count = 0;

    // MSN_D2→GPi(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPi; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D2; j++ ){
                count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND2GPi );
            }
        }
    }
    post_synapse += count;
    count = 0;

    // STN→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNGPi );
        }
    }
    post_synapse += count;
    count = 0;

    // GPe→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPi );
        }
    }
    post_synapse += count;
    count = 0;

    cudaMallocManaged ( &n_GPi -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // MSN_D1→SNc(拡散型？)
    for ( long i = 0; i < N_SNc; i++ ){
        for ( long j = 0; j < N_MSN_D1; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND1SNc );
        }
    }
    post_synapse += count;
    count = 0;

    // MSN_D2→SNc(拡散型？)
    for ( long i = 0; i < N_SNc; i++ ){
        for ( long j = 0; j < N_MSN_D2; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSND2SNc );
        }
    }
    post_synapse += count;
    count = 0;

    cudaMallocManaged ( &n_SNc -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // PTI→PTN(拡散型)
    post_synapse += N_PTI * N_PTN;

    // PSN→PTN(集中型)
    post_synapse += per_chanel_N_PSN * per_chanel_N_PTN * N_chanel;

    // Th→PTN(集中型?)
    post_synapse += per_chanel_N_Th * per_chanel_N_PTN * N_chanel;

    cudaMallocManaged ( &n_PTN -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // PTN→PTI(集中型)
    post_synapse += per_chanel_N_PTN * per_chanel_N_PTI * N_chanel;

    cudaMallocManaged ( &n_PTI -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // GPi→Th(集中型)
    post_synapse += per_chanel_N_GPi * per_chanel_N_Th * N_chanel;

    // PTN→Th(拡散型)
    post_synapse += per_chanel_N_PTN * per_chanel_N_Th * N_chanel;

    cudaMallocManaged ( &n_Th -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    srand ( 1 );

    // CMPf→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_MSN_D1 -> post[ count + post_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_MSN_D1 -> num_pre[ i + ( N_MSN_D1 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D1→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_MSN_D1; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_MSND1MSND1 ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + SynapseMSN_D1;
                count++;
                count_pre++;
            }
        }
        n_MSN_D1 -> num_pre[ i + ( N_MSN_D1 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D2→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_MSN_D2; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_MSND2MSND1 ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + SynapseMSN_D2;
                count++;
                count_pre++;
            }
        }
        n_MSN_D1 -> num_pre[ i + ( N_MSN_D1 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // FSI→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_FSI; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_FSIMSND1 ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + SynapseFSI;
                count++;
                count_pre++;
            }
        }
        n_MSN_D1 -> num_pre[ i + ( N_MSN_D1 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // STN→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNMSND1 ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
        }
        n_MSN_D1 -> num_pre[ i + ( N_MSN_D1 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // GPe→MSN_D1(拡散型)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeMSND1 ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_MSN_D1 -> num_pre[ i + ( N_MSN_D1 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // SNc→MSN_D1(拡散型?)
    for ( long i = 0; i < N_MSN_D1; i++ ){
        for ( long j = 0; j < N_SNc; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_SNcMSND1 ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + SynapseSNc;
                count++;
                count_pre++;
            }
        }
        n_MSN_D1 -> num_pre[ i + ( N_MSN_D1 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // PTN→MSN_D1(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_MSN_D1; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_MSN_D1 -> num_pre[ i + ( t * per_chanel_N_MSN_D1 ) + ( N_MSN_D1 * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // PSN→MSN_D1(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_MSN_D1; i++ ){
            for ( long j = 0; j < per_chanel_N_PSN; j++ ){
                n_MSN_D1 -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PSN ) + SynapsePSN;
                count++;
                count_pre++;
            }
            n_MSN_D1 -> num_pre[ i + ( t * per_chanel_N_MSN_D1 ) + ( N_MSN_D1 * k ) ] = count_pre;
        }
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // CMPf→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_MSN_D2 -> post[ count + post_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_MSN_D2 -> num_pre[ i + ( N_MSN_D2 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D1→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_MSN_D1; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_MSND1MSND2 ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + SynapseMSN_D1;
                count++;
                count_pre++;
            }
        }
        n_MSN_D2 -> num_pre[ i + ( N_MSN_D2 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D2→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_MSN_D2; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_MSND2MSND2 ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + SynapseMSN_D2;
                count++;
                count_pre++;
            }
        }
        n_MSN_D2 -> num_pre[ i + ( N_MSN_D2 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // FSI→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_FSI; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_FSIMSND2 ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + SynapseFSI;
                count++;
                count_pre++;
            }
        }
        n_MSN_D2 -> num_pre[ i + ( N_MSN_D2 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // STN→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNMSND2 ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
        }
        n_MSN_D2 -> num_pre[ i + ( N_MSN_D2 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // GPe→MSN_D2(拡散型)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeMSND2 ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_MSN_D2 -> num_pre[ i + ( N_MSN_D2 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // SNc→MSN_D2(拡散型?)
    for ( long i = 0; i < N_MSN_D2; i++ ){
        for ( long j = 0; j < N_SNc; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_SNcMSND2 ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + SynapseSNc;
                count++;
                count_pre++;
            }
        }
        n_MSN_D2 -> num_pre[ i + ( N_MSN_D2 * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // PTN→MSN_D2(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_MSN_D2; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_MSN_D2 -> num_pre[ i + ( t * per_chanel_N_MSN_D2 ) + ( N_MSN_D2 * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // PSN→MSN_D2(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_MSN_D2; i++ ){
            for ( long j = 0; j < per_chanel_N_PSN; j++ ){
                n_MSN_D2 -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PSN ) + SynapsePSN;
                count++;
                count_pre++;
            }
            n_MSN_D2 -> num_pre[ i + ( t * per_chanel_N_MSN_D2 ) + ( N_MSN_D2 * k ) ] = count_pre;
        }
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // CMPf→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_FSI -> post[ count + post_synapse ] = j  + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // FSI→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_FSI; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_FSIFSI ){
                n_FSI -> post[ count + post_synapse ] = j + SynapseFSI;
                count++;
                count_pre++;
            }
        }
        n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // STN→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNFSI ){
                n_FSI -> post[ count + post_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
            n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // GPe→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeFSI ){
                n_FSI -> post[ count + post_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // PTN→FSI(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_FSI; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_FSI -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_FSI -> num_pre[ i + ( t * per_chanel_N_FSI ) + ( N_FSI * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // PSN→FSI(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_FSI; i++ ){
            for ( long j = 0; j < per_chanel_N_PSN; j++ ){
                n_FSI -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PSN ) + SynapsePSN;
                count++;
                count_pre++;
            }
            n_FSI -> num_pre[ i + ( t * per_chanel_N_FSI ) + ( N_FSI * k ) ] = count_pre;
        }
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // CMPf→STN(拡散型)
    for ( long i = 0; i < N_STN; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_STN -> post[ count + post_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_STN -> num_pre [ i + ( N_STN * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // GPe→STN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_STN; i++ ){
            for ( long j = 0; j < per_chanel_N_GPe; j++ ){
                if ( ( ( double ) rand () / RAND_MAX ) < P_GPeSTN ){
                    n_STN -> post[ count + post_synapse ] = j + ( t * per_chanel_N_GPe ) + SynapseGPe;
                    count++;
                    count_pre++;
                }
            }
            n_STN -> num_pre[ i + ( t * per_chanel_N_STN ) + ( N_STN * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // PTN→STN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_STN; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_STN -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_STN -> num_pre[ i + ( t * per_chanel_N_STN ) + ( N_STN * k ) ] = count_pre;
        }
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // CMPf→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_GPe -> post[ count + post_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_GPe -> num_pre[ i + ( N_GPe * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D1→GPe(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPe; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D1; j++ ){
                if ( ( ( double ) rand () / RAND_MAX ) < P_MSND1GPe ){
                    n_GPe -> post[ count + post_synapse ] = j + ( t * per_chanel_N_MSN_D1 ) + SynapseMSN_D1;
                    count++;
                    count_pre++;
                }
            }
            n_GPe -> num_pre[ i + ( t * per_chanel_N_GPe ) + ( N_GPe * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D2→GPe(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPe; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D2; j++ ){
                if ( ( ( double ) rand () / RAND_MAX ) < P_MSND2GPe ){
                    n_GPe -> post[ count + post_synapse ] = j + ( t * per_chanel_N_MSN_D2 ) + SynapseMSN_D2;
                    count++;
                    count_pre++;
                }
            }
            n_GPe -> num_pre[ i + ( t * per_chanel_N_GPe ) + ( N_GPe * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // STN→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNGPe ){
                n_GPe -> post[ count + post_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
        }
        n_GPe -> num_pre[ i + ( N_GPe * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // GPe→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPe ){
                n_GPe -> post[ count + post_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_GPe -> num_pre[ i + ( N_GPe * k ) ] = count_pre;
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // CMPf→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_GPi -> post[ count + post_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_GPi -> num_pre[ i + ( N_GPi * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D1→GPi(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPi; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D1; j++ ){
                if ( ( ( double ) rand () / RAND_MAX ) < P_MSND1GPi ){
                    n_GPi -> post[ count + post_synapse ] = j + ( t * per_chanel_N_MSN_D1 ) + SynapseMSN_D1;
                    count++;
                    count_pre++;
                }
            }
            n_GPi -> num_pre[ i + ( t * per_chanel_N_GPi ) + ( N_GPi * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D2→GPi(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPi; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN_D2; j++ ){
                if ( ( ( double ) rand () / RAND_MAX ) < P_MSND2GPi ){
                    n_GPi -> post[ count + post_synapse ] = j + ( t * per_chanel_N_MSN_D2 ) + SynapseMSN_D2;
                    count++;
                    count_pre++;
                }
            }
            n_GPi -> num_pre[ i + ( t * per_chanel_N_GPi ) + ( N_GPi * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // STN→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNGPi ){
                n_GPi -> post[ count + post_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
        }
        n_GPi -> num_pre[ i + ( N_GPi * k ) ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // GPe→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPi ){
                n_GPi -> post[ count + post_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_GPi -> num_pre[ i + ( N_GPi * k ) ] = count_pre;
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // MSN_D1→SNc(拡散型?)
    for ( long i = 0; i < N_SNc; i++ ){
        for ( long j = 0; j < N_MSN_D1; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_MSND1SNc ){
                n_SNc -> post[ count + post_synapse ] = j + SynapseMSN_D1;
                count++;
                count_pre++;
            }
        }
        n_SNc -> num_pre[ i + ( N_SNc * k ) + 1 ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // MSN_D2→SNc(拡散型?)
    for ( long i = 0; i < N_SNc; i++ ){
        for ( long j = 0; j < N_MSN_D2; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_MSND2SNc ){
                n_SNc -> post[ count + post_synapse ] = j + SynapseMSN_D2;
                count++;
                count_pre++;
            }
        }
        n_SNc -> num_pre[ i + ( N_SNc * k ) + 1 ] = count_pre;
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;
    n_SNc -> num_pre[ 0 ] = 0;

    // PTI→PTN(拡散型)
    for ( long i = 0; i < N_PTN; i++ ){
        for ( long j = 0; j < N_PTI; j++ ){
            n_PTN -> post[ count + post_synapse ] = j + SynapsePTI;
            count++;
            count_pre++;
        }
        n_PTN -> num_pre[ i + ( N_PTN * k ) + 1 ] = count_pre;
    }
    post_synapse += count;
    count = 0;
    k++;

    // PSN→PTN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_PTN; i++ ){
            for ( long j = 0; j < per_chanel_N_PSN; j++ ){
                n_PTN -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PSN ) + SynapsePSN;
                count++;
                count_pre++;
            }
            n_PTN -> num_pre[ i + ( t * per_chanel_N_PTN ) + ( N_PTN * k ) + 1 ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // Th→PTN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_PTN; i++ ){
            for ( long j = 0; j < per_chanel_N_Th; j++ ){
                n_PTN -> post[ count + post_synapse ] = j + ( t * per_chanel_N_Th ) + SynapseTh;
                count++;
                count_pre++;
            }
            n_PTN -> num_pre[ i + ( t * per_chanel_N_PTN ) + ( N_PTN * k ) + 1 ] = count_pre;
        }
    }
    post_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;
    n_PTN -> num_pre[ 0 ] = 0;

    // PTN→PTI(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_PTI; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_PTI -> post[ count ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_PTI -> num_pre[ i + ( t * per_chanel_N_PTI ) + 1 ] = count_pre;
        }
    }
    count = 0;
    count_pre = 0;
    n_PTI -> num_pre[ 0 ] = 0;

    // GPi→Th(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_Th; i++ ){
            for ( long j = 0; j < per_chanel_N_GPi; j++ ){
                n_Th -> post[ count + post_synapse ] = j + ( t * per_chanel_N_GPi ) + SynapseGPi;
                count++;
                count_pre++;
            }
            n_Th -> num_pre[ i + ( t * per_chanel_N_Th ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    k++;

    // PTN→Th(拡散型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_Th; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_Th -> post[ count + post_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_Th -> num_pre[ i + ( t * per_chanel_N_Th ) + ( N_Th * k ) ] = count_pre;
        }
    }
    post_synapse += count;
    count = 0;
    count_pre = 0;
    k = 0;
    n_Th -> num_pre[ 0 ] = 0;
}

// メモリ確保や初期化を行う関数を実行する関数
void initalize( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    // 疑似乱数ジェネレータ(pseudo random number generator：PRNG)のシード値の設定
    sfmt_init_gen_rand ( &( n_MSN_D1 -> rng ), 23 );
    sfmt_init_gen_rand ( &( n_MSN_D2 -> rng ), 20 );
    sfmt_init_gen_rand ( &( n_FSI -> rng ), 22 );
    sfmt_init_gen_rand ( &( n_STN -> rng ), 21 );
    sfmt_init_gen_rand ( &( n_GPe -> rng ), 29 );
    sfmt_init_gen_rand ( &( n_GPi -> rng ), 19 );
    sfmt_init_gen_rand ( &( n_SNc -> rng ), 28 );
    sfmt_init_gen_rand ( &( n_PTN -> rng ), 10 );
    sfmt_init_gen_rand ( &( n_PTI -> rng ), 27 );
    sfmt_init_gen_rand ( &( n_PSN -> rng ), 15 );
    sfmt_init_gen_rand ( &( n_Th -> rng ), 17 );
    sfmt_init_gen_rand ( &( n_CMPf -> rng ), 18 );

    // ニューロンを表現する構造体のメンバ変数のメモリ確保
    Allocating_Neuron( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );

    // ニューロンを表現する構造体のメンバ変数の初期化
    initalize_Neuron( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_PSN, n_Th, n_CMPf );

    // シナプス結合に関するメンバ変数のメモリ確保と乱数を用いて結合の再現
    initalize_synapse( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_GPi, n_SNc, n_PTN, n_PTI, n_Th );
}