#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

void outputFiringRate ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    float mean = 0;
    //MSN_D1
    for ( int i = 0; i < N_MSN_D1; i++ ){
        mean += n_MSN_D1 -> counter[ i ]; 
    }
    mean = mean / N_MSN_D1;
    // fprintf ( n_MSN_D1 -> file1, "%f\n", mean );
    printf( "MSND1:%fHz\n", mean );

    //MSN_D2
    mean = 0;
    for ( int i = 0; i < N_MSN_D2; i++ ){
        mean += n_MSN_D2 -> counter[ i ]; 
    }
    mean = mean / N_MSN_D2;
    // fprintf ( n_MSN_D2 -> file1, "%f\n", mean );
    printf( "MSND2:%fHz\n", mean );

    //FSI
    mean = 0;
    for ( int i = 0; i < N_FSI; i++ ){
        mean += n_FSI -> counter[ i ];
    }
    mean = mean / N_FSI;
    // fprintf ( n_FSI -> file1, "%f\n", mean );
    printf( "FSI:%fHz\n", mean );


    //STN
    mean = 0;
    for ( int i = 0; i < N_STN; i++ ){
        mean += n_STN -> counter[ i ];
    }
    mean = mean / N_STN;
    // fprintf ( n_STN -> file1, "%f\n", mean );
    printf( "STN:%fHz\n", mean );

    //GPe
    mean = 0;
    for ( int i = 0; i < N_GPe; i++ ){
        mean += n_GPe -> counter[ i ];
    }
    mean = mean / N_GPe;
    // fprintf ( n_GPe -> file1, "%f\n", mean );
    printf( "GPe:%fHz\n", mean );

    //GPi
    mean = 0;
    for ( int i = 0; i < N_GPi; i++ ){
        mean += n_GPi -> counter[ i ];
    }
    mean = mean / N_GPi;
    // fprintf ( n_GPi -> file1, "%f\n", mean );
    printf( "GPi:%fHz\n", mean );

    //SNc
    mean = 0;
    for ( int i = 0; i < N_SNc; i++ ){
        mean += n_SNc -> counter[ i ];
    }
    mean = mean / N_SNc;
    // fprintf ( n_SNc -> file1, "%f\n", mean );
    printf( "SNc:%fHz\n", mean );

    //PTN
    mean = 0;
    for ( int i = 0; i < N_PTN; i++ ){
        mean += n_PTN -> counter[ i ];
    }
    mean = mean / N_PTN;
    // fprintf ( n_PTN -> file1, "%f\n", mean );
    printf( "PTN:%fHz\n", mean );

    //PTI
    mean = 0;
    for ( int i = 0; i < N_PTI; i++ ){
        mean += n_PTI -> counter[ i ];
    }
    mean = mean / N_PTI;
    // fprintf ( n_PTI -> file1, "%f\n", mean );
    printf( "PTI:%fHz\n", mean );

    //PSN
    mean = 0;
    for ( int i = 0; i < N_PSN; i++ ){
        mean += n_PSN -> counter[ i ];
    }
    mean = mean / N_PSN;
    // fprintf ( n_PSN -> file1, "%f\n", mean );
    printf( "PSN:%fHz\n", mean );

    //Th
    mean = 0;
    for ( int i = 0; i < N_Th; i++ ){
        mean += n_Th -> counter[ i ];
    }
    mean = mean / N_Th;
    // fprintf ( n_Th -> file1, "%f\n", mean );
    printf( "Th:%fHz\n", mean );

    //CMPf
    mean = 0;
    for ( int i = 0; i < N_CMPf; i++ ){
        mean += n_CMPf -> counter[ i ];
    }
    mean = mean / N_CMPf;
    // fprintf ( n_CMPf -> file1, "%f\n", mean );
    printf( "CMPf:%fHz\n", mean );
}

void outputSpike ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    //MSN_D1
    for ( int i = 0; i < N_MSN_D1; i++ ){

        if ( n_MSN_D1 -> s[ i ] ){

            fprintf ( n_MSN_D1 -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_MSN_D1 -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //MSN_D2
    for ( int i = 0; i < N_MSN_D2; i++ ){

        if ( n_MSN_D2 -> s[ i ] ){

            fprintf ( n_MSN_D2 -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_MSN_D2 -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //FSI
    for ( int i = 0; i < N_FSI; i++ ){

        if ( n_FSI -> s[ i ] ){

            fprintf ( n_FSI -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_FSI -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //STN
    for ( int i = 0; i < N_STN; i++ ){

        if ( n_STN -> s[ i ] ){

            fprintf ( n_STN -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_STN -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //GPe
    for ( int i = 0; i < N_GPe; i++ ){

        if ( n_GPe -> s[ i ] ){

            fprintf ( n_GPe -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_GPe -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //GPi
    for ( int i = 0; i < N_GPi; i++ ){

        if ( n_GPi -> s[ i ] ){

            fprintf ( n_GPi -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_GPi -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //SNc
    for ( int i = 0; i < N_SNc; i++ ){

        if ( n_SNc -> s[ i ] ){

            fprintf ( n_SNc -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_SNc -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //PTN
    for ( int i = 0; i < N_PTN; i++ ){

        if ( n_PTN -> s[ i ] ){

            fprintf ( n_PTN -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_PTN -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //PTI
    for ( int i = 0; i < N_PTI; i++ ){

        if ( n_PTI -> s[ i ] ){

            fprintf ( n_PTI -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_PTI -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //PSN
    for ( int i = 0; i < N_PSN; i++ ){

        if ( n_PSN -> s[ i ] ){

            fprintf ( n_PSN -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_PSN -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //Th
    for ( int i = 0; i < N_Th; i++ ){

        if ( n_Th -> s[ i ] ){

            fprintf ( n_Th -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_Th -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }

    //CMPf
    for ( int i = 0; i < N_CMPf; i++ ){

        if ( n_CMPf -> s[ i ] ){

            fprintf ( n_CMPf -> file, "%f %d\n", DT * ( nt + 1 ) - FreeRun, i );
            n_CMPf -> counter[ i ]++;
        } // Spike time is not t but t + DT
    }
}