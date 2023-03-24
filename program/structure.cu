#include <stdio.h>
#include <stdlib.h>
#include <SFMT.h>
#include "param.h"

//ニューロン
typedef struct{

  float *v, *ig, *alpha_AMPA, *alpha_NMDA, *alpha_GABA;
  bool *s, *select;
  int *refr, *ts, *counter, *post;
  long  *num_pre;
  sfmt_t rng;
  FILE *file, *file1, *file2;
} neuron_t;

typedef enum{
  MSN,
  FSI,
  STN,
  GPe,
  GPi,
  CSN,
  PTN,
  CMPf
} neuron_kind;

void fileclose( neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN ){

  // fclose ( n_MSN -> file );
  // fclose ( n_MSN -> file1 );
  // fclose ( n_MSN -> file2 );

  // fclose ( n_FSI -> file );
  // fclose ( n_FSI -> file1 );
  // fclose ( n_FSI -> file2 );

  // fclose ( n_STN -> file );
  // fclose ( n_STN -> file1 );
  // fclose ( n_STN -> file2 );

  // fclose ( n_GPe -> file );
  // fclose ( n_GPe -> file1 );
  // fclose ( n_GPe -> file2 );

  // fclose ( n_GPi -> file );
  fclose ( n_GPi -> file1 );
  fclose ( n_GPi -> file2 );

  // fclose ( n_CSN -> file );
  fclose ( n_CSN -> file1 );
  fclose ( n_CSN -> file2 );

  // fclose ( n_PTN -> file );
  fclose ( n_PTN -> file1 );
  fclose ( n_PTN -> file2 );

  // fclose ( n_CMPf -> file );
  // fclose ( n_CMPf -> file1 );
  // fclose ( n_CMPf -> file2 );
}

void finalize_neuron ( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

  // MSN
  cudaFree ( n_MSN -> v );
  cudaFree ( n_MSN -> ig );
  cudaFree ( n_MSN -> alpha_GABA );
  cudaFree ( n_MSN -> ts );
  cudaFree ( n_MSN -> s );
  cudaFree ( n_MSN -> refr );
  //cudaFree ( n_MSN -> counter );
  cudaFree ( n_MSN -> post );
  cudaFree ( n_MSN -> num_pre );

  // FSI
  cudaFree ( n_FSI -> v );
  cudaFree ( n_FSI -> ig );
  cudaFree ( n_FSI -> alpha_GABA );
  cudaFree ( n_FSI -> ts );
  cudaFree ( n_FSI -> s );
  cudaFree ( n_FSI -> refr );
  //cudaFree ( n_FSI -> counter );
  cudaFree ( n_FSI -> post );
  cudaFree ( n_FSI -> num_pre );

  // STN
  cudaFree ( n_STN -> v );
  cudaFree ( n_STN -> ig );
  cudaFree ( n_STN -> alpha_AMPA );
  cudaFree ( n_STN -> alpha_NMDA );
  cudaFree ( n_STN -> ts );
  cudaFree ( n_STN -> s );
  //cudaFree ( n_STN -> refr );
  cudaFree ( n_STN -> counter );
  cudaFree ( n_STN -> post );
  cudaFree ( n_STN -> num_pre );

  // GPe
  cudaFree ( n_GPe -> v );
  cudaFree ( n_GPe -> ig );
  cudaFree ( n_GPe -> alpha_GABA );
  cudaFree ( n_GPe -> ts );
  cudaFree ( n_GPe -> s );
  cudaFree ( n_GPe -> refr );
  //cudaFree ( n_GPe -> counter );
  cudaFree ( n_GPe -> post );
  cudaFree ( n_GPe -> num_pre );

  // GPi
  cudaFree ( n_GPi -> v );
  cudaFree ( n_GPi -> ig );
  cudaFree ( n_GPi -> ts );
  cudaFree ( n_GPi -> s );
  cudaFree ( n_GPi -> refr );
  cudaFree ( n_GPi -> counter );
  cudaFree ( n_GPi -> post );
  cudaFree ( n_GPi -> num_pre );

  // CSN
  cudaFree ( n_CSN -> alpha_AMPA );
  cudaFree ( n_CSN -> alpha_NMDA );
  cudaFree ( n_CSN -> ts );
  cudaFree ( n_CSN -> s );
  cudaFree ( n_CSN -> refr );
  cudaFree ( n_CSN -> counter );

  // PTN
  cudaFree ( n_PTN -> alpha_AMPA );
  cudaFree ( n_PTN -> alpha_NMDA );
  cudaFree ( n_PTN -> ts );
  cudaFree ( n_PTN -> s );
  cudaFree ( n_PTN -> refr );
  cudaFree ( n_PTN -> counter );

  // CMPf
  cudaFree ( n_CMPf -> alpha_AMPA );
  cudaFree ( n_CMPf -> alpha_NMDA );
  cudaFree ( n_CMPf -> ts );
  cudaFree ( n_CMPf -> s );
  cudaFree ( n_CMPf -> refr );
  //cudaFree ( n_CMPf -> counter );
}

void finalize ( neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

  finalize_neuron ( n_MSN, n_FSI, n_STN, n_GPe, n_GPi, n_CSN, n_PTN, n_CMPf );
}