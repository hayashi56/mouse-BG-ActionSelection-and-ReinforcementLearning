#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

void outputFiringRate ( /*neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe,*/ neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN/*, neuron_t *n_CMPf */){

  float mean = 0;
  /*
  //MSN
  for ( int i = 0; i < N_MSN; i++ ){
    mean += n_MSN -> counter[ i ]; 
  }
  mean = mean / N_MSN;
  fprintf ( n_MSN -> file1, "%f\n", mean );

  //FSI
  mean = 0;
  for ( int i = 0; i < N_FSI; i++ ){
    mean += n_FSI -> counter[ i ];
  }
  mean = mean / N_FSI;
  fprintf ( n_FSI -> file1, "%f\n", mean );

  //STN
  mean = 0;
  for ( int i = 0; i < N_STN; i++ ){
    mean += n_STN -> counter[ i ];
  }
  mean = mean / N_STN;
  fprintf ( n_STN -> file1, "%f\n", mean );

  //GPe
  mean = 0;
  for ( int i = 0; i < N_GPe; i++ ){
    mean += n_GPe -> counter[ i ];
  }
  mean = mean / N_GPe;
  fprintf ( n_GPe -> file1, "%f\n", mean );

  */
  //GPi
  // mean = 0;
  for ( int i = 0; i < per_chanel_N_GPi; i++ ){
    mean += n_GPi -> counter[ i ];
  }
  mean = mean / per_chanel_N_GPi;
  fprintf ( n_GPi -> file1, "%f\n", mean );
  mean = 0;
  for ( int i = 0; i < per_chanel_N_GPi; i++ ){
    mean += n_GPi -> counter[ i + per_chanel_N_GPi ];
  }
  mean = mean / per_chanel_N_GPi;
  fprintf ( n_GPi -> file2, "%f\n", mean );

  //CSN
  mean = 0;
  for ( int i = 0; i < per_chanel_N_CSN; i++ ){
    mean += n_CSN -> counter[ i ];
  }
  mean = mean / per_chanel_N_CSN;
  fprintf ( n_CSN -> file1, "%f\n", mean );
  mean = 0;
  for ( int i = 0; i < per_chanel_N_CSN; i++ ){
    mean += n_CSN -> counter[ i + per_chanel_N_CSN ];
  }
  mean = mean / per_chanel_N_CSN;
  fprintf ( n_CSN -> file2, "%f\n", mean );

  //PTN
  mean = 0;
  for ( int i = 0; i < per_chanel_N_PTN; i++ ){
    mean += n_PTN -> counter[ i ];
  }
  mean = mean / per_chanel_N_PTN;
  fprintf ( n_PTN -> file1, "%f\n", mean );
  mean = 0;
  for ( int i = 0; i < per_chanel_N_PTN; i++ ){
    mean += n_PTN -> counter[ i + per_chanel_N_PTN ];
  }
  mean = mean / per_chanel_N_PTN;
  fprintf ( n_PTN -> file2, "%f\n", mean );

  /*
  //CMPf
  mean = 0;
  for ( int i = 0; i < N_CMPf; i++ ){
    mean += n_CMPf -> counter[ i ];
  }
  mean = mean / N_CMPf;
  fprintf ( n_CMPf -> file1, "%f\n", mean );
  */
}

void outputSpike ( /*int nt, neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe,*/ neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN/*, neuron_t *n_CMPf*/ ){

  /*
  //MSN
  for ( int i = 0; i < N_MSN; i++ ){

    if ( n_MSN -> s[ i ] ){

      fprintf ( n_MSN -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_MSN -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }

  //FSI
  for ( int i = 0; i < N_FSI; i++ ){

    if ( n_FSI -> s[ i ] ){

      fprintf ( n_FSI -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_FSI -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }

  //STN
  for ( int i = 0; i < N_STN; i++ ){

    if ( n_STN -> s[ i ] ){

      fprintf ( n_STN -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_STN -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }

  //GPe
  for ( int i = 0; i < N_GPe; i++ ){

    if ( n_GPe -> s[ i ] ){

      fprintf ( n_GPe -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_GPe -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }
  */

  //GPi
  for ( int i = 0; i < N_GPi; i++ ){

    if ( n_GPi -> s[ i ] ){

      //fprintf ( n_GPi -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_GPi -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }

  //CSN
  for ( int i = 0; i < N_CSN; i++ ){

    if ( n_CSN -> s[ i ] ){

      //fprintf ( n_CSN -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_CSN -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }

  //PTN
  for ( int i = 0; i < N_PTN; i++ ){

    if ( n_PTN -> s[ i ] ){

      //fprintf ( n_PTN -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_PTN -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }

  /*
  //CMPf
  for ( int i = 0; i < N_CMPf; i++ ){

    if ( n_CMPf -> s[ i ] ){

      fprintf ( n_CMPf -> file, "%f %d\n", DT * ( nt + 1 ), i );
      n_CMPf -> counter[ i ]++;
    } // Spike time is not t but t + DT
  }
  */
}