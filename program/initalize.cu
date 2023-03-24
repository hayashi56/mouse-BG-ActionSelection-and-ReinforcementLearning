#include <stdio.h>
#include <stdlib.h>
#include <SFMT.h>
#include <random>
#include <algorithm>
#include <vector>
#include "param.h"

void fileopen ( /*neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe,*/ neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN/*, neuron_t *n_CMPf*/ ){

    // n_MSN -> file = fopen ( "MSNspike.dat", "w" );
    // n_MSN -> file1 = fopen ( "MSNfiringrate.dat", "w" );
    // n_MSN -> file2 = fopen ( "MSN.dat", "w" );

    // n_FSI -> file = fopen ( "FSIspike.dat", "w" );
    // n_FSI -> file1 = fopen ( "FSIfiringrate.dat", "w" );
    // n_FSI -> file2 = fopen ( "FSI.dat", "w" );

    // n_STN -> file = fopen ( "STNspike.dat", "w" );
    // n_STN -> file1 = fopen ( "STNfiringrate.dat", "w" );
    // n_STN -> file2 = fopen ( "STN.dat", "w" );

    // n_GPe -> file = fopen ( "GPespike.dat", "w" );
    // n_GPe -> file1 = fopen ( "GPefiringrate.dat", "w" );
    // n_GPe -> file2 = fopen ( "GPe.dat", "w" );

    // n_GPi -> file = fopen ( "GPi.dat", "w" );
    n_GPi -> file1 = fopen ( "GPifiringrate_chanel1.dat", "w" );
    n_GPi -> file2 = fopen ( "GPifiringrate_chanel2.dat", "w" );

    //n_CSN -> file = fopen ( "CSNspike.dat", "w" );
    n_CSN -> file1 = fopen ( "CSNfiringrate_chanel1.dat", "w" );
    n_CSN -> file2 = fopen ( "CSNfiringrate_chanel2.dat", "w" );

    //n_PTN -> file = fopen ( "PTNspike.dat", "w" );
    n_PTN -> file1 = fopen ( "PTNfiringrate_chanel1.dat", "w" );
    n_PTN -> file2 = fopen ( "PTNfiringrate_chanel2.dat", "w" );

    // n_CMPf -> file = fopen ( "CMPfspike.dat", "w" );
    // n_CMPf -> file1 = fopen ( "CMPffiringrate.dat", "w" );
    // n_CMPf -> file2 = fopen ( "CMPf.dat", "w" );
}

void AllocatingNeuron ( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

    cudaMallocManaged ( &n_MSN -> v, sizeof ( float ) * N_MSN );
    cudaMallocManaged ( &n_MSN -> ig, sizeof ( float ) * N_MSN );
    cudaMallocManaged ( &n_MSN -> alpha_GABA, sizeof ( float ) * N_MSN );
    cudaMallocManaged ( &n_MSN -> refr, sizeof ( int ) * N_MSN );
    cudaMallocManaged ( &n_MSN -> ts, sizeof ( int ) * N_MSN );
    cudaMallocManaged ( &n_MSN -> s, sizeof ( bool ) * N_MSN );
    // cudaMallocManaged ( &n_MSN -> counter, sizeof ( int ) * N_MSN );
    cudaMallocManaged ( &n_MSN -> num_pre, sizeof ( long ) * N_MSN * 7 );
    
    cudaMallocManaged ( &n_FSI -> v, sizeof ( float ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> ig, sizeof ( float ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> alpha_GABA, sizeof ( float ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> s, sizeof ( bool ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> ts, sizeof ( int ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> refr, sizeof ( int ) * N_FSI );
    //cudaMallocManaged ( &n_FSI -> counter, sizeof ( int ) * N_FSI );
    cudaMallocManaged ( &n_FSI -> num_pre, sizeof ( long ) * N_FSI * 6 );
    
    cudaMallocManaged ( &n_STN -> v, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> ig, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> alpha_AMPA, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> alpha_NMDA, sizeof ( float ) * N_STN );
    cudaMallocManaged ( &n_STN -> s, sizeof ( bool ) * N_STN );
    cudaMallocManaged ( &n_STN -> ts, sizeof ( int ) * N_STN );
    cudaMallocManaged ( &n_STN -> refr, sizeof ( int ) * N_STN );
    //cudaMallocManaged ( &n_STN -> counter, sizeof ( int ) * N_STN );
    cudaMallocManaged ( &n_STN -> num_pre, sizeof ( long ) * N_STN * 3 );
    
    cudaMallocManaged ( &n_GPe -> v, sizeof ( float ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> ig, sizeof ( float ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> alpha_GABA, sizeof ( float ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> s, sizeof ( bool ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> ts, sizeof ( int ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> refr, sizeof ( int ) * N_GPe );
    //cudaMallocManaged ( &n_GPe -> counter, sizeof ( int ) * N_GPe );
    cudaMallocManaged ( &n_GPe -> num_pre, sizeof ( long ) * N_GPe * 4 );

    cudaMallocManaged ( &n_GPi -> v, sizeof ( float ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> ig, sizeof ( float ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> s, sizeof ( bool ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> ts, sizeof ( int ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> refr, sizeof ( int ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> counter, sizeof ( int ) * N_GPi );
    cudaMallocManaged ( &n_GPi -> num_pre, sizeof ( long ) * N_GPi * 4 );

    cudaMallocManaged ( &n_CSN -> alpha_AMPA, sizeof ( float ) * N_CSN );
    cudaMallocManaged ( &n_CSN -> alpha_NMDA, sizeof ( float ) * N_CSN );
    cudaMallocManaged ( &n_CSN -> s, sizeof ( bool ) * N_CSN );
    cudaMallocManaged ( &n_CSN -> select, sizeof ( bool ) * N_CSN );
    cudaMallocManaged ( &n_CSN -> ts, sizeof ( int ) * N_CSN );
    cudaMallocManaged ( &n_CSN -> refr, sizeof ( int ) * N_CSN );
    cudaMallocManaged ( &n_CSN -> counter, sizeof ( int ) * N_CSN );

    cudaMallocManaged ( &n_PTN -> alpha_AMPA, sizeof ( float ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> alpha_NMDA, sizeof ( float ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> s, sizeof ( bool ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> select, sizeof ( bool ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> ts, sizeof ( int ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> refr, sizeof ( int ) * N_PTN );
    cudaMallocManaged ( &n_PTN -> counter, sizeof ( int ) * N_PTN );

    cudaMallocManaged ( &n_CMPf -> alpha_AMPA, sizeof ( float ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> alpha_NMDA, sizeof ( float ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> s, sizeof ( bool ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> ts, sizeof ( int ) * N_CMPf );
    cudaMallocManaged ( &n_CMPf -> refr, sizeof ( int ) * N_CMPf );
    //cudaMallocManaged ( &n_CMPf -> counter, sizeof ( int ) * N_CMPf );
}

void initNeuron ( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

    for ( int i = 0; i < N_MSN; i++ ){

        n_MSN -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_MSN -> rng );
        n_MSN -> ig[ i ] = 0;
        n_MSN -> alpha_GABA[ i ] = 0;
        n_MSN -> refr[ i ] = 0;
        n_MSN -> ts[ i ] = 1000;
        n_MSN -> s[ i ] = false;
        //n_MSN -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_FSI; i++ ){

        n_FSI -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_FSI -> rng );
        n_FSI -> ig[ i ] = 0;
        n_FSI -> alpha_GABA[ i ] = 0;
        n_FSI -> refr[ i ] = 0;
        n_FSI -> ts[ i ] = 1000;
        n_FSI -> s[ i ] = false;
        //n_FSI -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_STN; i++ ){

        n_STN -> v[ i ] = V_INIT + 50. * sfmt_genrand_real2 ( &n_STN -> rng );
        n_STN -> ig[ i ] = 0;
        n_STN -> alpha_AMPA[ i ] = 0;
        n_STN -> alpha_NMDA[ i ] = 0;
        n_STN -> refr[ i ] = 0;
        n_STN -> ts[ i ] = 1000;
        n_STN -> s[ i ] = false;
        //n_STN -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_GPe; i++ ){

        n_GPe -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_GPe -> rng );
        n_GPe -> ig[ i ] = 0;
        n_GPe -> alpha_GABA[ i ] = 0;
        n_GPe -> refr[ i ] = 0;
        n_GPe -> ts[ i ] = 1000;
        n_GPe -> s[ i ] = false;
        //n_GPe -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_GPi; i++ ){

        n_GPi -> v[ i ] = V_INIT + 10. * sfmt_genrand_real2 ( &n_GPi -> rng );
        n_GPi -> ig[ i ] = 0;
        n_GPi -> refr[ i ] = 0;
        n_GPi -> ts[ i ] = 1000;
        n_GPi -> s[ i ] = false;
        n_GPi -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_CSN; i++ ){

        n_CSN -> alpha_AMPA[ i ] = 0;
        n_CSN -> alpha_NMDA[ i ] = 0;
        n_CSN -> refr[ i ] = 0;
        n_CSN -> ts[ i ] = 1000;
        n_CSN -> s[ i ] = false;
        n_CSN -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_PTN; i++ ){

        n_PTN -> alpha_AMPA[ i ] = 0;
        n_PTN -> alpha_NMDA[ i ] = 0;
        n_PTN -> refr[ i ] = 0;
        n_PTN -> ts[ i ] = 1000;
        n_PTN -> s[ i ] = false;
        n_PTN -> counter[ i ] = 0;
    }

    for ( int i = 0; i < N_CMPf; i++ ){

        n_CMPf -> alpha_AMPA[ i ] = 0;
        n_CMPf -> alpha_NMDA[ i ] = 0;
        n_CMPf -> refr[ i ] = 0;
        n_CMPf -> ts[ i ] = 1000;
        n_CMPf -> s[ i ] = false;
        //n_CMPf -> counter[ i ] = 0;
    }
}

void initselection( neuron_t *n_CSN, neuron_t *n_PTN ){
    
    std::vector<int> v;
    for ( int i = 0; i != N_CSN; ++i ){
        v.push_back( i );
    }

    std::random_device get_rand_dev;
    std::mt19937 get_rand_mt ( get_rand_dev () );
    std::shuffle ( v.begin (), v.end (), get_rand_mt );

    for ( int i = 0; i < N_select; i++ ){
        n_CSN -> select [ v [ i ] ] = true;
        n_PTN -> select [ v [ i ] ] = true;
    }
}

void initalizeNeuron( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){
 
    fileopen ( /*n_MSN, n_FSI, n_STN, n_GPe,*/ n_GPi, n_CSN, n_PTN/*, n_CMPf*/ );
    AllocatingNeuron ( n_MSN, n_FSI, n_STN, n_GPe, n_GPi, n_CSN, n_PTN, n_CMPf );

    // PRNG
    sfmt_init_gen_rand ( &( n_MSN -> rng ), 23 );
    sfmt_init_gen_rand ( &( n_FSI -> rng ), 22 );
    sfmt_init_gen_rand ( &( n_STN -> rng ), 21 );
    sfmt_init_gen_rand ( &( n_GPe -> rng ), 20 );
    sfmt_init_gen_rand ( &( n_GPi -> rng ), 19 );
    sfmt_init_gen_rand ( &( n_CSN -> rng ), 23 );
    sfmt_init_gen_rand ( &( n_PTN -> rng ), 23 );
    sfmt_init_gen_rand ( &( n_CMPf -> rng ), 23 );

    initNeuron ( n_MSN, n_FSI, n_STN, n_GPe, n_GPi, n_CSN, n_PTN, n_CMPf );
    initselection ( n_CSN, n_PTN );
}

void initsynapse( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi ){

    int k = 0;
    long num_of_synapse = 0;
    long post_synapse = 0;
    long count = 0;
    long count_pre = 0;

    srand ( 1 );
    // MSN→MSN(拡散型)
    num_of_synapse += N_MSN * N_MSN;
    post_synapse += N_MSN * N_MSN;

    // FSI→MSN(拡散型)
    num_of_synapse += N_FSI * N_MSN;
    post_synapse += N_FSI * N_MSN;

    // STN→MSN(拡散型)
    for ( long i = 0; i < N_MSN; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNMSN );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // GPe→MSN(拡散型)
    for ( long i = 0; i < N_MSN; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand ( ) / RAND_MAX ) < P_GPeMSN );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // CSN→MSN(集中型)
    num_of_synapse += per_chanel_N_CSN * per_chanel_N_MSN * N_chanel;
    post_synapse += per_chanel_N_CSN * per_chanel_N_MSN * N_chanel;

    // PTN→MSN(集中型)
    num_of_synapse += per_chanel_N_PTN * per_chanel_N_MSN * N_chanel;
    post_synapse += per_chanel_N_PTN * per_chanel_N_MSN * N_chanel;

    // CMPf→MSN(拡散型)
    num_of_synapse += N_CMPf * N_MSN;
    post_synapse += N_CMPf * N_MSN;

    cudaMallocManaged ( &n_MSN -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // FSI→FSI(拡散型)
    num_of_synapse += N_FSI * N_FSI;
    post_synapse += N_FSI * N_FSI;

    // STN→FSI(拡散型)   
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNFSI );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // GPe→FSI(拡散型)    
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_GPeFSI );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // CSN→FSI(集中型)
    num_of_synapse += per_chanel_N_CSN * per_chanel_N_FSI * N_chanel;
    post_synapse += per_chanel_N_CSN * per_chanel_N_FSI * N_chanel;

    // PTN→FSI(集中型)
    num_of_synapse += per_chanel_N_PTN * per_chanel_N_FSI * N_chanel;
    post_synapse += per_chanel_N_PTN * per_chanel_N_FSI * N_chanel;

    // CMPf→FSI(拡散型)
    num_of_synapse += N_CMPf * N_FSI;
    post_synapse += N_CMPf * N_FSI;

    cudaMallocManaged ( &n_FSI -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // GPe→STN(集中型)
    num_of_synapse += per_chanel_N_GPe * per_chanel_N_STN * N_chanel;
    post_synapse += per_chanel_N_GPe * per_chanel_N_STN * N_chanel;

    // PTN→STN(集中型)
    num_of_synapse += per_chanel_N_PTN * per_chanel_N_STN * N_chanel;
    post_synapse += per_chanel_N_PTN * per_chanel_N_STN * N_chanel;

    // CMPf→STN(拡散型)
    num_of_synapse += N_CMPf * N_STN;
    post_synapse += N_CMPf * N_STN;

    cudaMallocManaged ( &n_STN -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // MSN→GPe(集中型)
    num_of_synapse += per_chanel_N_MSN * per_chanel_N_GPe * N_chanel;
    post_synapse += per_chanel_N_MSN * per_chanel_N_GPe * N_chanel;

    // STN→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNGPe );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // GPe→GPe(拡散型)  
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPe );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // CMPf→GPe(拡散型)
    num_of_synapse += N_CMPf * N_GPe;
    post_synapse += N_CMPf * N_GPe;

    cudaMallocManaged ( &n_GPe -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;

    // CMPf→GPi(拡散型)
    num_of_synapse += N_CMPf * N_GPi;
    post_synapse += N_CMPf * N_GPi;

    // STN→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_STNGPi );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // GPe→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPi );
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    // MSN→GPi(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPi; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN; j++ ){
                count += ( long ) ( ( ( double ) rand () / RAND_MAX ) < P_MSNGPi );
            }
        }
    }
    num_of_synapse += count;
    post_synapse += count;
    count = 0;

    cudaMallocManaged ( &n_GPi -> post, sizeof ( long ) * post_synapse );
    post_synapse = 0;    


    printf("%ld\n",num_of_synapse);

    num_of_synapse = 0;

    srand ( 1 );

    // MSN→MSN(拡散型)
    for ( long i = 0; i < N_MSN; i++ ){        
        for ( long j = 0; j < N_MSN; j++ ){
            n_MSN -> post[ count ] = j;
            count++;
            count_pre++;
        }
        n_MSN -> num_pre[ i + ( N_MSN * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // FSI→MSN(拡散型)
    for ( long i = 0; i < N_MSN; i++ ){    
        for ( long j = 0; j < N_FSI; j++ ){
            n_MSN -> post[ count + num_of_synapse ] = j + SynapseFSI;
            count++;
            count_pre++;
        }
        n_MSN -> num_pre[ i + ( N_MSN * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // STN→MSN(拡散型)
    for ( long i = 0; i < N_MSN; i++ ){    
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNMSN ){
                n_MSN -> post[ count + num_of_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
        }
        n_MSN -> num_pre[ i + ( N_MSN * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // GPe→MSN(拡散型)
    for ( long i = 0; i < N_MSN; i++ ){    
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeMSN ){
                n_MSN -> post[ count + num_of_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_MSN -> num_pre[ i + ( N_MSN * k ) ] = count_pre;  
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // CSN→MSN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_MSN; i++ ){
            for ( long j = 0; j < per_chanel_N_CSN; j++ ){
                n_MSN -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_CSN ) + SynapseCSN;
                count++;
                count_pre++;
            }
            n_MSN -> num_pre[ i + ( t * per_chanel_N_MSN ) + ( N_MSN * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // PTN→MSN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_MSN; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_MSN -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_MSN -> num_pre[ i + ( t * per_chanel_N_MSN ) + ( N_MSN * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // CMPf→MSN(拡散型)    
    for ( long i = 0; i < N_MSN; i++ ){        
        for ( long j = 0; j < N_CMPf; j++ ){
            n_MSN -> post[ count + num_of_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_MSN -> num_pre[ i + ( N_MSN * k ) ] = count_pre;
    }
    num_of_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // FSI→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_FSI; j++ ){
            n_FSI -> post[ count + num_of_synapse ] = j + SynapseFSI;
            count++;
            count_pre++;
        }
        n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // STN→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){            
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNFSI ){
                n_FSI -> post[ count + num_of_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
            n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // GPe→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeFSI ){
                n_FSI -> post[ count + num_of_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // CSN→FSI(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_FSI; i++ ){
            for ( long j = 0; j < per_chanel_N_CSN; j++ ){
                n_FSI -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_CSN ) + SynapseCSN;
                count++;
                count_pre++;
            }
            n_FSI -> num_pre[ i + ( t * per_chanel_N_FSI ) + ( N_FSI * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // PTN→FSI(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_FSI; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_FSI -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_FSI -> num_pre[ i + ( t * per_chanel_N_FSI ) + ( N_FSI * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // CMPf→FSI(拡散型)
    for ( long i = 0; i < N_FSI; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_FSI -> post[ count + num_of_synapse ] = j  + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_FSI -> num_pre[ i + ( N_FSI * k ) ] = count_pre;
    }
    num_of_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // GPe→STN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_STN; i++ ){
            for ( long j = 0; j < per_chanel_N_GPe; j++ ){
                n_STN -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_GPe ) + SynapseGPe;
                count++;
                count_pre++;
            }
            n_STN -> num_pre[ i + ( t * per_chanel_N_STN ) + ( N_STN * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // PTN→STN(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_STN; i++ ){
            for ( long j = 0; j < per_chanel_N_PTN; j++ ){
                n_STN -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_PTN ) + SynapsePTN;
                count++;
                count_pre++;
            }
            n_STN -> num_pre[ i + ( t * per_chanel_N_STN ) + ( N_STN * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // CMPf→STN(拡散型)
    for ( long i = 0; i < N_STN; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_STN -> post[ count + num_of_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_STN -> num_pre [ i + ( N_STN * k ) ] = count_pre;
    }
    num_of_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // MSN→GPe(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPe; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN; j++ ){
                n_GPe -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_MSN );
                count++;
                count_pre++;
            }
            n_GPe -> num_pre[ i + ( t * per_chanel_N_GPe ) + ( N_GPe * k ) ] = count_pre;
        }
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // STN→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){   
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNGPe ){
                n_GPe -> post[ count + num_of_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
        }
        n_GPe -> num_pre[ i + ( N_GPe * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // GPe→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){     
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPe ){
                n_GPe -> post[ count + num_of_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_GPe -> num_pre[ i + ( N_GPe * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // CMPf→GPe(拡散型)
    for ( long i = 0; i < N_GPe; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_GPe -> post[ count + num_of_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_GPe -> num_pre[ i + ( N_GPe * k ) ] = count_pre;
    }
    num_of_synapse = 0;
    count = 0;
    count_pre = 0;
    k = 0;

    // CMPf→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_CMPf; j++ ){
            n_GPi -> post[ count + num_of_synapse ] = j + SynapseCMPf;
            count++;
            count_pre++;
        }
        n_GPi -> num_pre[ i + ( N_GPi * k ) ] = count_pre;
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // STN→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_STN; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_STNGPi ){
                n_GPi -> post[ count + num_of_synapse ] = j + SynapseSTN;
                count++;
                count_pre++;
            }
        }
        n_GPi -> num_pre[ i + ( N_GPi * k ) ] = count_pre; 
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // GPe→GPi(拡散型)
    for ( long i = 0; i < N_GPi; i++ ){
        for ( long j = 0; j < N_GPe; j++ ){
            if ( ( ( double ) rand () / RAND_MAX ) < P_GPeGPi ){
                n_GPi -> post[ count + num_of_synapse ] = j + SynapseGPe;
                count++;
                count_pre++;
            }
        }
        n_GPi -> num_pre[ i + ( N_GPi * k ) ] = count_pre; 
    }
    num_of_synapse += count;
    count = 0;
    k++;

    // MSN→GPi(集中型)
    for ( int t = 0; t < N_chanel; t++ ){
        for ( long i = 0; i < per_chanel_N_GPi; i++ ){
            for ( long j = 0; j < per_chanel_N_MSN; j++ ){
                if ( ( ( double ) rand () / RAND_MAX ) < P_MSNGPi ){
                    n_GPi -> post[ count + num_of_synapse ] = j + ( t * per_chanel_N_MSN );
                    count++;
                    count_pre++;
                }
            }
            n_GPi -> num_pre[ i + ( t * per_chanel_N_GPi ) + ( N_GPi * k ) ] = count_pre;
        }
    }
    num_of_synapse = 0;
    count = 0;
}