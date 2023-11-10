#include <stdio.h>
#include <math.h>
#include "param.h"

__global__ void updateSynapse_MSN_D1 ( int nt, neuron_t *n_MSN_D1 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D1 ){
        n_MSN_D1 -> psp_GABA[ i ] = ( float ) tauGABA * n_MSN_D1 -> psp_GABA[ i ] + PSP_amplitudes_GABA * ( n_MSN_D1 -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_MSN_D2 ( int nt, neuron_t *n_MSN_D2 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D2 ){
        n_MSN_D2 -> psp_GABA[ i ] = ( float ) tauGABA * n_MSN_D2 -> psp_GABA[ i ] + PSP_amplitudes_GABA * ( n_MSN_D2 -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_FSI ( int nt, neuron_t *n_FSI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_FSI ){
        n_FSI -> psp_GABA[ i ] = ( float ) tauGABA * n_FSI -> psp_GABA[ i ] + PSP_amplitudes_GABA * ( n_FSI -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_STN ( int nt, neuron_t *n_STN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_STN ){
        n_STN -> psp_AMPA[ i ] = ( float ) tauAMPA * n_STN -> psp_AMPA[ i ] + PSP_amplitudes_AMPA * ( n_STN -> ts[ i ] + DELAY == nt );
        n_STN -> psp_NMDA[ i ] = ( float ) tauNMDA * n_STN -> psp_NMDA[ i ] + PSP_amplitudes_NMDA * ( n_STN -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_GPe ( int nt, neuron_t *n_GPe ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPe ){
        n_GPe -> psp_GABA[ i ] = ( float ) tauGABA * n_GPe -> psp_GABA[ i ] + PSP_amplitudes_GABA * ( n_GPe -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_GPi ( int nt, neuron_t *n_GPi ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPi ){
        n_GPi -> psp_GABA[ i ] = ( float ) tauGABA * n_GPi -> psp_GABA[ i ] + PSP_amplitudes_GABA * ( n_GPi -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_SNc ( int nt, neuron_t *n_SNc ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_SNc ){
        n_SNc -> psp_DOPA[ i ] = ( float ) tauDOPA * n_SNc -> psp_DOPA[ i ] + PSP_amplitudes_DOPA * ( n_SNc -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_PTN ( int nt, neuron_t *n_PTN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i < N_PTN ){
        n_PTN -> psp_AMPA[ i ] = ( float ) tauAMPA * n_PTN -> psp_AMPA[ i ] + PSP_amplitudes_AMPA * ( n_PTN -> ts[ i ] + DELAY == nt );
        n_PTN -> psp_NMDA[ i ] = ( float ) tauNMDA * n_PTN -> psp_NMDA[ i ] + PSP_amplitudes_NMDA * ( n_PTN -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_PTI ( int nt, neuron_t *n_PTI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTI ){
        n_PTI -> psp_GABA[ i ] = ( float ) tauGABA * n_PTI -> psp_GABA[ i ] + PSP_amplitudes_GABA * ( n_PTI -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_PSN ( int nt, neuron_t *n_PSN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i < N_PSN ){
        n_PSN -> psp_AMPA[ i ] = ( float ) tauAMPA * n_PSN -> psp_AMPA[ i ] + PSP_amplitudes_AMPA * ( n_PSN -> ts[ i ] + DELAY == nt );
        n_PSN -> psp_NMDA[ i ] = ( float ) tauNMDA * n_PSN -> psp_NMDA[ i ] + PSP_amplitudes_NMDA * ( n_PSN -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_Th ( int nt, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i < N_Th ){
        n_Th -> psp_AMPA[ i ] = ( float ) tauAMPA * n_Th -> psp_AMPA[ i ] + PSP_amplitudes_AMPA * ( n_Th -> ts[ i ] + DELAY == nt );
        n_Th -> psp_NMDA[ i ] = ( float ) tauNMDA * n_Th -> psp_NMDA[ i ] + PSP_amplitudes_NMDA * ( n_Th -> ts[ i ] + DELAY == nt );
    }
}
__global__ void updateSynapse_CMPf ( int nt, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_CMPf ){
        n_CMPf -> psp_AMPA[ i ] = ( float ) tauAMPA * n_CMPf -> psp_AMPA[ i ] + PSP_amplitudes_AMPA * ( n_CMPf -> ts[ i ] + DELAY == nt );
        n_CMPf -> psp_NMDA[ i ] = ( float ) tauNMDA * n_CMPf -> psp_NMDA[ i ] + PSP_amplitudes_NMDA * ( n_CMPf -> ts[ i ] + DELAY == nt );
    }
}
void updateSynapse ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    updateSynapse_MSN_D1 <<< GRID_SIZE_MSN_D1, BLOCK_SIZE >>> ( nt, n_MSN_D1 );
    cudaDeviceSynchronize ( );
    updateSynapse_MSN_D2 <<< GRID_SIZE_MSN_D2, BLOCK_SIZE >>> ( nt, n_MSN_D2 );
    cudaDeviceSynchronize ( );
    updateSynapse_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( nt, n_FSI );
    cudaDeviceSynchronize ( );
    updateSynapse_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( nt, n_STN );
    cudaDeviceSynchronize ( );
    updateSynapse_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( nt, n_GPe );
    cudaDeviceSynchronize ( );
    updateSynapse_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( nt, n_GPi );
    cudaDeviceSynchronize ( );
    updateSynapse_SNc <<< GRID_SIZE_SNc, BLOCK_SIZE >>> ( nt, n_SNc );
    cudaDeviceSynchronize ( );
    updateSynapse_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( nt, n_PTN );
    cudaDeviceSynchronize ( );
    updateSynapse_PTI <<< GRID_SIZE_PTI, BLOCK_SIZE >>> ( nt, n_PTI );
    cudaDeviceSynchronize ( );
    updateSynapse_PSN <<< GRID_SIZE_PSN, BLOCK_SIZE >>> ( nt, n_PSN );
    cudaDeviceSynchronize ( );
    updateSynapse_Th <<< GRID_SIZE_Th, BLOCK_SIZE >>> ( nt, n_Th );
    cudaDeviceSynchronize ( );
    updateSynapse_CMPf <<< GRID_SIZE_CMPf, BLOCK_SIZE >>> ( nt, n_CMPf );
    cudaDeviceSynchronize ( );
}

__global__ void InputSynapsePotential_MSN_D1 ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PSN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_MSN_D1 ){
        float r = 0;
        int t = 0;
        // x =MSN_D1;
        // y =CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){
            r += ( n_CMPf ->  psp_AMPA[ j ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_AMPA ) * W_CMPfMSND1_AMPA ) + ( n_CMPf ->  psp_NMDA[ j ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_NMDA ) * W_CMPfMSND1_NMDA );
        }
        t++;
        // y =MSN_D1;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){
            r += n_MSN_D1 -> psp_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseMSN_D1 ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_GABA ) * W_MSND1MSND1;
        }
        t++;
        // y =MSN_D2;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){
            r += n_MSN_D2 -> psp_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseMSN_D2 ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_GABA ) * W_MSND2MSND1;
        }
        t++;
        // y =FSI;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += n_FSI -> psp_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseFSI ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_GABA ) * W_FSIMSND1;
        }
        t++;

        // y =STN;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += ( n_STN -> psp_AMPA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseSTN ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_AMPA ) * W_STNMSND1_AMPA ) + ( n_STN ->  psp_NMDA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseSTN ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_NMDA ) * W_STNMSND1_NMDA );
        }
        t++;

        // y =GPe;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += n_GPe -> psp_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseGPe ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_GABA ) * W_GPeMSND1;
        }
        t++;

        // y =SNc;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += n_SNc -> psp_DOPA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseSNc ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_DOPA ) * W_SNcMSND1;
        }
        t++;

        // y =PTN;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += ( n_PTN -> psp_AMPA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePTN ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_AMPA ) * W_PTNMSND1_AMPA ) + ( n_PTN ->  psp_NMDA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePTN ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_NMDA ) * W_PTNMSND1_NMDA );
        }
        t++;

        // y =PSN;
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += ( n_PSN -> psp_AMPA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePSN ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_AMPA ) * W_PSNMSND1_AMPA ) + ( n_PSN ->  psp_NMDA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePSN ] * ( - n_MSN_D1 -> v[ i ] + rev_potential_NMDA ) * W_PSNMSND1_NMDA );
        }
        n_MSN_D1 -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_MSN_D2 ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PSN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_MSN_D2 ){
        float r = 0;
        int t = 0;
        // x =MSN_D2;
        // y =CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){
            r += ( n_CMPf -> psp_AMPA[ j ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_AMPA ) * W_CMPfMSND2_AMPA ) + ( n_CMPf ->  psp_NMDA[ j ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_NMDA ) * W_CMPfMSND2_NMDA );
        }
        n_MSN_D2 -> k [ i ] = r;
        t++;
        // y =MSN_D1;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){
            r += n_MSN_D1 -> psp_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseMSN_D1 ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_GABA ) * W_MSND1MSND2;
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 ] = r;
        t++;
        // y =MSN_D2;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){
            r += n_MSN_D2 -> psp_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseMSN_D2 ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_GABA ) * W_MSND2MSND2;
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 * 2 ] = r;
        t++;
        // y =FSI;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += n_FSI -> psp_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseFSI ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_GABA ) * W_FSIMSND2;
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 * 3 ] = r;
        t++;

        // y =STN;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += ( n_STN -> psp_AMPA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseSTN ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_AMPA ) * W_STNMSND2_AMPA ) + ( n_STN ->  psp_NMDA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseSTN ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_NMDA ) * W_STNMSND2_NMDA );
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 * 4 ] = r;
        t++;

        // y =GPe;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += n_GPe -> psp_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseGPe ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_GABA ) * W_GPeMSND2;
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 * 5 ] = r;
        t++;

        // y =SNc;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += n_SNc -> psp_DOPA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseSNc ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_DOPA ) * W_SNcMSND2;
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 * 6 ] = r;
        t++;

        // y =PTN;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += ( n_PTN -> psp_AMPA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePTN ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_AMPA ) * W_PTNMSND2_AMPA ) + ( n_PTN ->  psp_NMDA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePTN ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_NMDA ) * W_PTNMSND2_NMDA );
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 * 7 ] = r;
        t++;

        // y =PSN;
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += ( n_PSN -> psp_AMPA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePSN ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_AMPA ) * W_PSNMSND2_AMPA ) + ( n_PSN ->  psp_NMDA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePSN ] * ( - n_MSN_D2 -> v[ i ] + rev_potential_NMDA ) * W_PSNMSND2_NMDA );
        }
        n_MSN_D2 -> k [ i + N_MSN_D2 * 8 ] = r;
        n_MSN_D2 -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_FSI ( int nt, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_PTN, neuron_t *n_PSN, neuron_t *n_CMPf ){
    
    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_FSI ) {
        float r = 0;
        int t = 0;
        // x =FSI;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( n_CMPf -> psp_AMPA[ j ] * ( - n_FSI -> v[ i ] + rev_potential_AMPA ) * W_CMPfFSI_AMPA ) + ( n_CMPf ->  psp_NMDA[ j ] * ( - n_FSI -> v[ i ] + rev_potential_NMDA ) * W_CMPfFSI_NMDA );
        }
        t++;
        // y =FSI;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += n_FSI -> psp_GABA[ n_FSI -> post[ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseFSI ] * ( - n_FSI -> v[ i ] + rev_potential_GABA ) * W_FSIFSI;
        }
        t++;
        // y =STN;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += ( n_STN -> psp_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseSTN ] * ( - n_FSI -> v[ i ] + rev_potential_AMPA ) * W_STNFSI_AMPA ) + ( n_STN ->  psp_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseSTN ] * ( - n_FSI -> v[ i ] + rev_potential_NMDA ) * W_STNFSI_NMDA );
        }
        t++;
        // y =GPe;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += n_GPe -> psp_GABA[ n_FSI -> post[ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseGPe ] * ( - n_FSI -> v[ i ] + rev_potential_GABA ) * W_GPeFSI;
        }
        t++;
        // y =PTN;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += ( n_PTN -> psp_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN ] * ( - n_FSI -> v[ i ] + rev_potential_AMPA ) * W_PTNFSI_AMPA ) + ( n_PTN ->  psp_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN ] * ( - n_FSI -> v[ i ] + rev_potential_NMDA ) * W_PTNFSI_NMDA );
        }
        t++;
        // y =PSN;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += ( n_PSN -> psp_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePSN ] * ( - n_FSI -> v[ i ] + rev_potential_AMPA ) * W_PSNFSI_AMPA ) + ( n_PSN ->  psp_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePSN ] * ( - n_FSI -> v[ i ] + rev_potential_NMDA ) * W_PSNFSI_NMDA );
        }
        n_FSI -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_STN ( int nt, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_PTN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_STN ){
        float r = 0;
        int t = 0;
        // x =STN;
        // y =CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( n_CMPf -> psp_AMPA[ j ] * ( - n_STN -> v[ i ] + rev_potential_AMPA ) * W_CMPfSTN_AMPA ) + ( n_CMPf ->  psp_NMDA[ j ] * ( - n_STN -> v[ i ] + rev_potential_NMDA ) * W_CMPfSTN_NMDA );
        }
        t++;
        // y =GPe;
        for ( int j = 0; j < ( n_STN -> num_pre[ i + ( t * N_STN ) ] - n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ); j++ ){ 
            r += n_GPe -> psp_GABA[ n_STN -> post[ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapseGPe ] * ( - n_STN -> v[ i ] + rev_potential_GABA ) * W_GPeSTN;
        }
        t++;
        // y =PTN;
        for ( int j = 0; j < ( n_STN -> num_pre[ i + ( t * N_STN ) ] - n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ); j++ ){ 
            r += ( n_PTN -> psp_AMPA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapsePTN ] * ( - n_STN -> v[ i ] + rev_potential_AMPA ) * W_PTNSTN_AMPA ) + ( n_PTN ->  psp_NMDA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapsePTN ] * ( - n_STN -> v[ i ] + rev_potential_NMDA ) * W_PTNSTN_NMDA );
        }
        t++;
        n_STN -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_GPe ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_GPe ){
        float r = 0;
        int t = 0;
        // x =GPe;
        // y =CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( n_CMPf -> psp_AMPA[ j ] * ( - n_GPe -> v[ i ] + rev_potential_AMPA ) * W_CMPfGPe_AMPA ) + ( n_CMPf ->  psp_NMDA[ j ] * ( - n_GPe -> v[ i ] + rev_potential_NMDA ) * W_CMPfGPe_NMDA );
        }
        t++;
        // y =MSN_D1;
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){
            r += n_MSN_D1 -> psp_GABA[ n_GPe -> post[ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseMSN_D1 ] * ( - n_GPe -> v[ i ] + rev_potential_GABA ) * W_MSND1GPe;
        }
        t++;
        // y =MSN_D2;
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){
            r += n_MSN_D2 -> psp_GABA[ n_GPe -> post[ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseMSN_D2 ] * ( - n_GPe -> v[ i ] + rev_potential_GABA ) * W_MSND2GPe;
        }
        t++;
        // y =STN;
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){ 
            r += ( n_STN -> psp_AMPA[ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseSTN ] * ( - n_GPe -> v[ i ] + rev_potential_AMPA ) * W_STNGPe_AMPA ) + ( n_STN ->  psp_NMDA[ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseSTN ] * ( - n_GPe -> v[ i ] + rev_potential_NMDA ) * W_STNGPe_NMDA );
        }
        t++;
        // y =GPe;
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){ 
            r += n_GPe -> psp_GABA[ n_GPe -> post[ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseGPe ] * ( - n_GPe -> v[ i ] + rev_potential_GABA ) * W_GPeGPe;
        }
        n_GPe -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_GPi ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_GPi ){
        float r = 0;
        int t = 0;
        // x =GPi;
        // y =CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( n_CMPf -> psp_AMPA[ j ] * ( - n_GPi -> v[ i ] + rev_potential_AMPA ) * W_CMPfGPi_AMPA ) + ( n_CMPf ->  psp_NMDA[ j ] * ( - n_GPi -> v[ i ] + rev_potential_NMDA ) * W_CMPfGPi_NMDA );
        }
        t++;
        // y =MSN_D1;
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){
            r += n_MSN_D1 -> psp_GABA[ n_GPi -> post[ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseMSN_D1 ] * ( - n_GPi -> v[ i ] + rev_potential_GABA ) * W_MSND1GPi;
        }
        t++;
        // y =MSN_D2;
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){
            r += n_MSN_D2 -> psp_GABA[ n_GPi -> post[ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseMSN_D2 ] * ( - n_GPi -> v[ i ] + rev_potential_GABA ) * W_MSND2GPi;
        }
        t++;
        // y =STN;
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){ 
            r += ( n_STN -> psp_AMPA[ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseSTN ] * ( - n_GPi -> v[ i ] + rev_potential_AMPA ) * W_STNGPi_AMPA ) + ( n_STN ->  psp_NMDA[ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseSTN ] * ( - n_GPi -> v[ i ] + rev_potential_NMDA ) * W_STNGPi_NMDA );
        }
        t++;
        // y =GPe;
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){ 
            r += n_GPe -> psp_GABA[ n_GPi -> post[ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseGPe ] * ( - n_GPi -> v[ i ] + rev_potential_GABA ) * W_GPeGPi;
        }
        n_GPi -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_SNc ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_SNc ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;
    int t = 0;

    if ( i < N_SNc ){
        float r = 0;
        // x =SNc;
        // y =MSN_D1;
        for ( int j = 0; j < ( n_SNc -> num_pre[ i + 1 ] - n_SNc -> num_pre[ i ] ); j++ ){ 
            r += n_MSN_D1 -> psp_GABA[ n_SNc -> post[ j + n_SNc -> num_pre[ i ] ] - SynapseMSN_D1 ] * ( - n_SNc -> v[ i ] + rev_potential_GABA ) * W_MSND1SNc;
        }
        t++;
        // y =MSN_D2;
        for ( int j = 0; j < ( n_SNc -> num_pre[ i + ( t * N_SNc ) + 1 ] - n_SNc -> num_pre[ i + ( t * N_SNc ) ] ); j++ ){
            r += n_MSN_D2 -> psp_GABA[ n_SNc -> post[ j + n_SNc -> num_pre[ i + ( t * N_SNc ) ] ] - SynapseMSN_D2 ] * ( - n_SNc -> v[ i ] + rev_potential_GABA ) * W_MSND2SNc;
        }
        n_SNc -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_PTN ( int nt, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;
    if ( i < N_PTN ){
        float r = 0;
        int t = 0;
        // x =PTN;
        // y =PTI;
        for ( int j = 0; j < ( n_PTN -> num_pre[ i + 1 ] - n_PTN -> num_pre[ i ] ); j++ ){
            r += n_PTI -> psp_GABA[ n_PTN -> post[ j + n_PTN -> num_pre[ i ] ] - SynapsePTI ] * ( - n_PTN -> v[ i ] + rev_potential_GABA ) * W_PTIPTN;
        }
        t++;
        // y =PSN;
        for ( int j = 0; j < ( n_PTN -> num_pre[ i + ( t * N_PTN ) + 1 ] - n_PTN -> num_pre[ i + ( t * N_PTN ) ] ); j++ ){ 
            r += ( n_PSN -> psp_AMPA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapsePSN ] * ( - n_PTN -> v[ i ] + rev_potential_AMPA ) * W_PSNPTN_AMPA ) + ( n_PSN ->  psp_NMDA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapsePSN ] * ( - n_PTN -> v[ i ] + rev_potential_NMDA ) * W_PSNPTN_NMDA );
        }
        t++;
        // y =Th;
        for ( int j = 0; j < ( n_PTN -> num_pre[ i + ( t * N_PTN ) + 1 ] - n_PTN -> num_pre[ i + ( t * N_PTN ) ] ); j++ ){ 
            r += ( n_Th -> psp_AMPA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapseTh ] * ( - n_PTN -> v[ i ] + rev_potential_AMPA ) * W_ThPTN_AMPA ) + ( n_Th ->  psp_NMDA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapseTh ] * ( - n_PTN -> v[ i ] + rev_potential_NMDA ) * W_ThPTN_NMDA );
        }
        n_PTN -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_PTI ( int nt, neuron_t *n_PTN, neuron_t *n_PTI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_PTI ){
        float r = 0;
        // x =PTI;
        // y =PTN;
        for ( int j = 0; j < ( n_PTI -> num_pre[ i + 1 ] - n_PTI -> num_pre[ i ] ); j++ ){ 
            r += ( n_PTN -> psp_AMPA[ n_PTI -> post [ j + n_PTI -> num_pre[ i ] ] - SynapsePTN ] * ( - n_PTI -> v[ i ] + rev_potential_AMPA ) * W_PTNPTI_AMPA ) + ( n_PTN ->  psp_NMDA[ n_PTI -> post [ j + n_PTI -> num_pre[ i ] ] - SynapsePTN ] * ( - n_PTI -> v[ i ] + rev_potential_NMDA ) * W_PTNPTI_NMDA );
        }
        n_PTI -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_Th ( int nt, neuron_t *n_GPi, neuron_t *n_PTN, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    // neuron_kind x, y;

    if ( i < N_Th ){
        float r = 0;
        int t = 0;
        // x =Th;
        // y =GPi;
        for ( int j = 0; j < ( n_Th -> num_pre[ i + 1 ] - n_Th -> num_pre[ i ] ); j++ ){
            r += n_GPi -> psp_GABA[ n_Th -> post[ j + n_Th -> num_pre[ i ] ] - SynapseGPi ] * ( - n_Th -> v[ i ] + rev_potential_GABA ) * W_GPiTh;
        }
        t++;
        // y =PTN;
        for ( int j = 0; j < ( n_Th -> num_pre[ i + ( t * N_Th ) + 1 ] - n_Th -> num_pre[ i + ( t * N_Th ) ] ); j++ ){ 
            r += ( n_PTN -> psp_AMPA[ n_Th -> post [ j + n_Th -> num_pre[ i + ( t * N_Th ) - 1 ] ] - SynapsePTN ] * ( - n_Th -> v[ i ] + rev_potential_AMPA ) * W_PTNTh_AMPA ) + ( n_PTN ->  psp_NMDA[ n_Th -> post [ j + n_Th -> num_pre[ i + ( t * N_Th ) - 1 ] ] - SynapsePTN ] * ( - n_Th -> v[ i ] + rev_potential_NMDA ) * W_PTNTh_NMDA );
        }
        n_Th -> ig[ i ] = r;
    }
}

void InputSynapsePotential ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    InputSynapsePotential_MSN_D1 <<< GRID_SIZE_MSN_D1, BLOCK_SIZE >>> ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_SNc, n_PTN, n_PSN, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_MSN_D2 <<< GRID_SIZE_MSN_D2, BLOCK_SIZE >>> ( nt, n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_SNc, n_PTN, n_PSN, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( nt, n_FSI, n_STN, n_GPe, n_PTN, n_PSN, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( nt, n_STN, n_GPe, n_PTN, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( nt, n_MSN_D1, n_MSN_D2, n_STN, n_GPe, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( nt, n_MSN_D1, n_MSN_D2, n_STN, n_GPe, n_GPi, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_SNc <<< GRID_SIZE_SNc, BLOCK_SIZE >>> ( nt, n_MSN_D1, n_MSN_D2, n_SNc );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( nt, n_PTN, n_PTI, n_PSN, n_Th );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_PTI <<< GRID_SIZE_PTI, BLOCK_SIZE >>> ( nt, n_PTN, n_PTI );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_Th <<< GRID_SIZE_Th, BLOCK_SIZE >>> ( nt, n_GPi, n_PTN, n_Th );
    cudaDeviceSynchronize ( );
}