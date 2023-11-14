#include <stdio.h>
#include <stdlib.h>
#include <SFMT.h>
#include "param.h"

//ニューロン
typedef struct{

    float *v, *i_syn, *conductance_AMPA, *conductance_GABA, *conductance_NMDA, *conductance_DOPA;
    bool *s, *select;
    int *refr, *ts, *counter, *post;
    long *num_pre;
    sfmt_t rng;
    FILE *file, *file1, *file2, *file3;
} neuron_t;

void fileclose( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    fclose ( n_MSN_D1 -> file );
    fclose ( n_MSN_D2 -> file );
    fclose ( n_FSI -> file );
    fclose ( n_STN -> file );
    fclose ( n_GPe -> file );
    fclose ( n_GPi -> file );
    fclose ( n_SNc -> file );
    fclose ( n_PTI -> file );
    fclose ( n_PTN -> file );
    fclose ( n_PSN -> file );
    fclose ( n_Th -> file );
    fclose ( n_CMPf -> file );

    fclose ( n_MSN_D1 -> file1 );
    fclose ( n_MSN_D2 -> file1 );
    fclose ( n_FSI -> file1 );
    fclose ( n_STN -> file1 );
    fclose ( n_GPe -> file1 );
    fclose ( n_GPi -> file1 );
    fclose ( n_SNc -> file1 );
    fclose ( n_PTI -> file1 );
    fclose ( n_PTN -> file1 );
    fclose ( n_PSN -> file1 );
    fclose ( n_Th -> file1 );
    fclose ( n_CMPf -> file1 );
    
    // fclose ( n_MSN_D1 -> file2 );
    // fclose ( n_MSN_D2 -> file2 );
    // fclose ( n_FSI -> file2 );
    // fclose ( n_STN -> file2 );
    // fclose ( n_GPe -> file2 );
    // fclose ( n_GPi -> file2 );
    // fclose ( n_SNc -> file2 );
    // fclose ( n_PTI -> file2 );
    fclose ( n_PTN -> file2 );
    fclose ( n_PTN -> file3 );
    fclose ( n_PSN -> file2 );
    // fclose ( n_Th -> file2 );
    // fclose ( n_CMPf -> file2 );
}

void finalize ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    // MSN_D1
    cudaFree ( n_MSN_D1 -> v );
    cudaFree ( n_MSN_D1 -> i_syn );
    cudaFree ( n_MSN_D1 -> conductance_GABA );
    cudaFree ( n_MSN_D1 -> ts );
    cudaFree ( n_MSN_D1 -> s );
    cudaFree ( n_MSN_D1 -> refr );
    cudaFree ( n_MSN_D1 -> counter );
    cudaFree ( n_MSN_D1 -> post );
    cudaFree ( n_MSN_D1 -> num_pre );

    // MSN_D2
    cudaFree ( n_MSN_D2 -> v );
    cudaFree ( n_MSN_D2 -> i_syn );
    cudaFree ( n_MSN_D2 -> conductance_GABA );
    cudaFree ( n_MSN_D2 -> ts );
    cudaFree ( n_MSN_D2 -> s );
    cudaFree ( n_MSN_D2 -> refr );
    cudaFree ( n_MSN_D2 -> counter );
    cudaFree ( n_MSN_D2 -> post );
    cudaFree ( n_MSN_D2 -> num_pre );

    // FSI
    cudaFree ( n_FSI -> v );
    cudaFree ( n_FSI -> i_syn );
    cudaFree ( n_FSI -> conductance_GABA );
    cudaFree ( n_FSI -> ts );
    cudaFree ( n_FSI -> s );
    cudaFree ( n_FSI -> refr );
    cudaFree ( n_FSI -> counter );
    cudaFree ( n_FSI -> post );
    cudaFree ( n_FSI -> num_pre );

    // STN
    cudaFree ( n_STN -> v );
    cudaFree ( n_STN -> i_syn );
    cudaFree ( n_STN -> conductance_AMPA );
    cudaFree ( n_STN -> conductance_NMDA );
    cudaFree ( n_STN -> ts );
    cudaFree ( n_STN -> s );
    cudaFree ( n_STN -> refr );
    cudaFree ( n_STN -> counter );
    cudaFree ( n_STN -> post );
    cudaFree ( n_STN -> num_pre );

    // GPe
    cudaFree ( n_GPe -> v );
    cudaFree ( n_GPe -> i_syn );
    cudaFree ( n_GPe -> conductance_GABA );
    cudaFree ( n_GPe -> ts );
    cudaFree ( n_GPe -> s );
    cudaFree ( n_GPe -> refr );
    cudaFree ( n_GPe -> counter );
    cudaFree ( n_GPe -> post );
    cudaFree ( n_GPe -> num_pre );

    // GPi
    cudaFree ( n_GPi -> v );
    cudaFree ( n_GPi -> i_syn );
    cudaFree ( n_GPi -> conductance_GABA );
    cudaFree ( n_GPi -> ts );
    cudaFree ( n_GPi -> s );
    cudaFree ( n_GPi -> refr );
    cudaFree ( n_GPi -> counter );
    cudaFree ( n_GPi -> post );
    cudaFree ( n_GPi -> num_pre );

    // SNc
    cudaFree ( n_SNc -> v );
    cudaFree ( n_SNc -> i_syn );
    cudaFree ( n_SNc -> conductance_DOPA );
    cudaFree ( n_SNc -> ts );
    cudaFree ( n_SNc -> s );
    cudaFree ( n_SNc -> refr );
    cudaFree ( n_SNc -> counter );
    cudaFree ( n_SNc -> post );
    cudaFree ( n_SNc -> num_pre );

    // PTN
    cudaFree ( n_PTN -> v );
    cudaFree ( n_PTN -> i_syn );
    cudaFree ( n_PTN -> conductance_AMPA );
    cudaFree ( n_PTN -> conductance_NMDA );
    cudaFree ( n_PTN -> ts );
    cudaFree ( n_PTN -> s );
    cudaFree ( n_PTN -> refr );
    cudaFree ( n_PTN -> counter );
    cudaFree ( n_PTN -> post );
    cudaFree ( n_PTN -> num_pre );

    // PTI
    cudaFree ( n_PTI -> v );
    cudaFree ( n_PTI -> i_syn );
    cudaFree ( n_PTI -> conductance_GABA );
    cudaFree ( n_PTI -> ts );
    cudaFree ( n_PTI -> s );
    cudaFree ( n_PTI -> refr );
    cudaFree ( n_PTI -> counter );
    cudaFree ( n_PTI -> post );
    cudaFree ( n_PTI -> num_pre );

    // PSN
    cudaFree ( n_PSN -> conductance_AMPA );
    cudaFree ( n_PSN -> conductance_NMDA );
    cudaFree ( n_PSN -> ts );
    cudaFree ( n_PSN -> s );
    cudaFree ( n_PSN -> counter );
    cudaFree ( n_PSN -> select );

    // Th
    cudaFree ( n_Th -> v );
    cudaFree ( n_Th -> i_syn );
    cudaFree ( n_Th -> conductance_AMPA );
    cudaFree ( n_Th -> conductance_NMDA );
    cudaFree ( n_Th -> ts );
    cudaFree ( n_Th -> s );
    cudaFree ( n_Th -> refr );
    cudaFree ( n_Th -> counter );
    cudaFree ( n_Th -> post );
    cudaFree ( n_Th -> num_pre );

    // CMPf
    cudaFree ( n_CMPf -> conductance_AMPA );
    cudaFree ( n_CMPf -> conductance_NMDA );
    cudaFree ( n_CMPf -> ts );
    cudaFree ( n_CMPf -> s );
    cudaFree ( n_CMPf -> counter );
}