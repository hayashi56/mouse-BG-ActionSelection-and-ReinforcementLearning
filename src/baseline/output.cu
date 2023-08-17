#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

// それぞれのニューロンについて発火の総数をニューロン数で割り、平均発火率を計算し標準出力する関数
void outputFiringRate ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    float mean = 0;
    //MSN_D1
    for ( int i = 0; i < N_MSN_D1; i++ ){
        mean += n_MSN_D1 -> counter[ i ];
    }
    mean = mean / N_MSN_D1;
    printf( "MSND1:%fHz\n", mean );

    //MSN_D2
    mean = 0;
    for ( int i = 0; i < N_MSN_D2; i++ ){
        mean += n_MSN_D2 -> counter[ i ];
    }
    mean = mean / N_MSN_D2;
    printf( "MSND2:%fHz\n", mean );

    //FSI
    mean = 0;
    for ( int i = 0; i < N_FSI; i++ ){
        mean += n_FSI -> counter[ i ];
    }
    mean = mean / N_FSI;
    printf( "FSI:%fHz\n", mean );


    //STN
    mean = 0;
    for ( int i = 0; i < N_STN; i++ ){
        mean += n_STN -> counter[ i ];
    }
    mean = mean / N_STN;
    printf( "STN:%fHz\n", mean );

    //GPe
    mean = 0;
    for ( int i = 0; i < N_GPe; i++ ){
        mean += n_GPe -> counter[ i ];
    }
    mean = mean / N_GPe;
    printf( "GPe:%fHz\n", mean );

    //GPi
    mean = 0;
    for ( int i = 0; i < N_GPi; i++ ){
        mean += n_GPi -> counter[ i ];
    }
    mean = mean / N_GPi;
    printf( "GPi:%fHz\n", mean );

    //SNc
    mean = 0;
    for ( int i = 0; i < N_SNc; i++ ){
        mean += n_SNc -> counter[ i ];
    }
    mean = mean / N_SNc;
    printf( "SNc:%fHz\n", mean );

    //PTN
    mean = 0;
    for ( int i = 0; i < N_PTN; i++ ){
        mean += n_PTN -> counter[ i ];
    }
    mean = mean / N_PTN;
    printf( "PTN:%fHz\n", mean );

    //PTI
    mean = 0;
    for ( int i = 0; i < N_PTI; i++ ){
        mean += n_PTI -> counter[ i ];
    }
    mean = mean / N_PTI;
    printf( "PTI:%fHz\n", mean );

    //PSN
    mean = 0;
    for ( int i = 0; i < N_PSN; i++ ){
        mean += n_PSN -> counter[ i ];
    }
    mean = mean / N_PSN;
    printf( "PSN:%fHz\n", mean );

    //Th
    mean = 0;
    for ( int i = 0; i < N_Th; i++ ){
        mean += n_Th -> counter[ i ];
    }
    mean = mean / N_Th;
    printf( "Th:%fHz\n", mean );

    //CMPf
    mean = 0;
    for ( int i = 0; i < N_CMPf; i++ ){
        mean += n_CMPf -> counter[ i ];
    }
    mean = mean / N_CMPf;
    printf( "CMPf:%fHz\n", mean );
}

// それぞれのニューロンの発火について発火したときの時間と発火したニューロンの番号をファイルに出力する関数
void outputSpike ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    //MSN_D1
    for ( int i = 0; i < N_MSN_D1; i++ ){

        if ( n_MSN_D1 -> s[ i ] ){

            fprintf ( n_MSN_D1 -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_MSN_D1 -> counter[ i ]++;
        }
    }

    //MSN_D2
    for ( int i = 0; i < N_MSN_D2; i++ ){

        if ( n_MSN_D2 -> s[ i ] ){

            fprintf ( n_MSN_D2 -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_MSN_D2 -> counter[ i ]++;
        }
    }

    //FSI
    for ( int i = 0; i < N_FSI; i++ ){

        if ( n_FSI -> s[ i ] ){

            fprintf ( n_FSI -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_FSI -> counter[ i ]++;
        }
    }

    //STN
    for ( int i = 0; i < N_STN; i++ ){

        if ( n_STN -> s[ i ] ){

            fprintf ( n_STN -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_STN -> counter[ i ]++;
        }
    }

    //GPe
    for ( int i = 0; i < N_GPe; i++ ){

        if ( n_GPe -> s[ i ] ){

            fprintf ( n_GPe -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_GPe -> counter[ i ]++;
        }
    }

    //GPi
    for ( int i = 0; i < N_GPi; i++ ){

        if ( n_GPi -> s[ i ] ){

            fprintf ( n_GPi -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_GPi -> counter[ i ]++;
        }
    }

    //SNc
    for ( int i = 0; i < N_SNc; i++ ){

        if ( n_SNc -> s[ i ] ){

            fprintf ( n_SNc -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_SNc -> counter[ i ]++;
        }
    }

    //PTN
    for ( int i = 0; i < N_PTN; i++ ){

        if ( n_PTN -> s[ i ] ){

            fprintf ( n_PTN -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_PTN -> counter[ i ]++;
        }
    }

    //PTI
    for ( int i = 0; i < N_PTI; i++ ){

        if ( n_PTI -> s[ i ] ){

            fprintf ( n_PTI -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_PTI -> counter[ i ]++;
        }
    }

    //PSN
    for ( int i = 0; i < N_PSN; i++ ){

        if ( n_PSN -> s[ i ] ){

            fprintf ( n_PSN -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_PSN -> counter[ i ]++;
        }
    }

    //Th
    for ( int i = 0; i < N_Th; i++ ){

        if ( n_Th -> s[ i ] ){

            fprintf ( n_Th -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_Th -> counter[ i ]++;
        }
    }

    //CMPf
    for ( int i = 0; i < N_CMPf; i++ ){

        if ( n_CMPf -> s[ i ] ){

            fprintf ( n_CMPf -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_CMPf -> counter[ i ]++;
        }
    }
}