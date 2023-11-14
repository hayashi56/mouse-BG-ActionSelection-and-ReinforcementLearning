#include <stdio.h>
#include <math.h>
#include "param.h"

__global__ void UpdateConductance_MSN_D1 ( int nt, neuron_t *n_MSN_D1 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D1 ){
        n_MSN_D1 -> conductance_GABA[ i ] = ( float ) PSP_amplitudes_GABA * ( TAU_GABA * n_MSN_D1 -> conductance_GABA[ i ] + ( n_MSN_D1 -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_MSN_D2 ( int nt, neuron_t *n_MSN_D2 ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D2 ){
        n_MSN_D2 -> conductance_GABA[ i ] = ( float ) PSP_amplitudes_GABA * ( TAU_GABA * n_MSN_D2 -> conductance_GABA[ i ] + ( n_MSN_D2 -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_FSI ( int nt, neuron_t *n_FSI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_FSI ){
        n_FSI -> conductance_GABA[ i ] = ( float ) PSP_amplitudes_GABA * ( TAU_GABA * n_FSI -> conductance_GABA[ i ] + ( n_FSI -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_STN ( int nt, neuron_t *n_STN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_STN ){
        n_STN -> conductance_AMPA[ i ] = ( float ) PSP_amplitudes_AMPA * ( TAU_AMPA * n_STN -> conductance_AMPA[ i ] + ( n_STN -> ts[ i ] + DELAY == nt + 1 ) );
        n_STN -> conductance_NMDA[ i ] = ( float ) PSP_amplitudes_NMDA * ( TAU_NMDA * n_STN -> conductance_NMDA[ i ] + ( n_STN -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_GPe ( int nt, neuron_t *n_GPe ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPe ){
        n_GPe -> conductance_GABA[ i ] = ( float ) PSP_amplitudes_GABA * ( TAU_GABA * n_GPe -> conductance_GABA[ i ] + ( n_GPe -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_GPi ( int nt, neuron_t *n_GPi ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPi ){
        n_GPi -> conductance_GABA[ i ] = ( float ) PSP_amplitudes_GABA * ( TAU_GABA * n_GPi -> conductance_GABA[ i ] + ( n_GPi -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_SNc ( int nt, neuron_t *n_SNc ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_SNc ){
        n_SNc -> conductance_DOPA[ i ] = ( float ) PSP_amplitudes_DOPA * ( TAU_DOPA * n_SNc -> conductance_DOPA[ i ] + ( n_SNc -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_PTN ( int nt, neuron_t *n_PTN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i < N_PTN ){
        n_PTN -> conductance_AMPA[ i ] = ( float ) PSP_amplitudes_AMPA * ( TAU_AMPA * n_PTN -> conductance_AMPA[ i ] + ( n_PTN -> ts[ i ] + DELAY == nt + 1 ) );
        n_PTN -> conductance_NMDA[ i ] = ( float ) PSP_amplitudes_NMDA * ( TAU_NMDA * n_PTN -> conductance_NMDA[ i ] + ( n_PTN -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_PTI ( int nt, neuron_t *n_PTI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_PTI ){
        n_PTI -> conductance_GABA[ i ] = ( float ) TAU_GABA * n_PTI -> conductance_GABA[ i ] + PSP_amplitudes_GABA * ( n_PTI -> ts[ i ] + DELAY == nt + 1 );
    }
}
__global__ void UpdateConductance_PSN ( int nt, neuron_t *n_PSN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i < N_PSN ){
        n_PSN -> conductance_AMPA[ i ] = ( float ) PSP_amplitudes_AMPA * ( TAU_AMPA * n_PSN -> conductance_AMPA[ i ] + ( n_PSN -> ts[ i ] + DELAY == nt + 1 ) );
        n_PSN -> conductance_NMDA[ i ] = ( float ) PSP_amplitudes_NMDA * ( TAU_NMDA * n_PSN -> conductance_NMDA[ i ] + ( n_PSN -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_Th ( int nt, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i < N_Th ){
        n_Th -> conductance_AMPA[ i ] = ( float ) PSP_amplitudes_AMPA * ( TAU_AMPA * n_Th -> conductance_AMPA[ i ] + ( n_Th -> ts[ i ] + DELAY == nt + 1 ) );
        n_Th -> conductance_NMDA[ i ] = ( float ) PSP_amplitudes_NMDA * ( TAU_NMDA * n_Th -> conductance_NMDA[ i ] + ( n_Th -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
__global__ void UpdateConductance_CMPf ( int nt, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_CMPf ){
        n_CMPf -> conductance_AMPA[ i ] = ( float ) PSP_amplitudes_AMPA * ( TAU_AMPA * n_CMPf -> conductance_AMPA[ i ] + ( n_CMPf -> ts[ i ] + DELAY == nt + 1 ) );
        n_CMPf -> conductance_NMDA[ i ] = ( float ) PSP_amplitudes_NMDA * ( TAU_NMDA * n_CMPf -> conductance_NMDA[ i ] + ( n_CMPf -> ts[ i ] + DELAY == nt + 1 ) );
    }
}
void UpdateConductance ( int nt, neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    UpdateConductance_MSN_D1 <<< GRID_SIZE_MSN_D1, BLOCK_SIZE >>> ( nt, n_MSN_D1 );
    cudaDeviceSynchronize ( );
    UpdateConductance_MSN_D2 <<< GRID_SIZE_MSN_D2, BLOCK_SIZE >>> ( nt, n_MSN_D2 );
    cudaDeviceSynchronize ( );
    UpdateConductance_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( nt, n_FSI );
    cudaDeviceSynchronize ( );
    UpdateConductance_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( nt, n_STN );
    cudaDeviceSynchronize ( );
    UpdateConductance_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( nt, n_GPe );
    cudaDeviceSynchronize ( );
    UpdateConductance_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( nt, n_GPi );
    cudaDeviceSynchronize ( );
    UpdateConductance_SNc <<< GRID_SIZE_SNc, BLOCK_SIZE >>> ( nt, n_SNc );
    cudaDeviceSynchronize ( );
    UpdateConductance_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( nt, n_PTN );
    cudaDeviceSynchronize ( );
    UpdateConductance_PTI <<< GRID_SIZE_PTI, BLOCK_SIZE >>> ( nt, n_PTI );
    cudaDeviceSynchronize ( );
    UpdateConductance_PSN <<< GRID_SIZE_PSN, BLOCK_SIZE >>> ( nt, n_PSN );
    cudaDeviceSynchronize ( );
    UpdateConductance_Th <<< GRID_SIZE_Th, BLOCK_SIZE >>> ( nt, n_Th );
    cudaDeviceSynchronize ( );
    UpdateConductance_CMPf <<< GRID_SIZE_CMPf, BLOCK_SIZE >>> ( nt, n_CMPf );
    cudaDeviceSynchronize ( );
}

// post:MSN_D1
__global__ void Synaptic_current_MSN_D1 ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PSN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D1 ){
        float r = 0;
        int t = 0;
        // pre:CMPf
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += - ( ( n_CMPf -> conductance_AMPA[ j ] * ( n_MSN_D1 -> v[ i ] - rev_potential_AMPA ) * W_CMPfMSND1_AMPA ) + ( n_CMPf ->  conductance_NMDA[ j ] * ( n_MSN_D1 -> v[ i ] - rev_potential_NMDA ) * W_CMPfMSND1_NMDA ) );
        }
        t++;
        // pre:MSN_D1
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){
            r += - ( n_MSN_D1 -> conductance_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseMSN_D1 ] * ( n_MSN_D1 -> v[ i ] - rev_potential_GABA ) * W_MSND1MSND1 );
        }
        t++;
        // pre:MSN_D2
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){
            r += - ( n_MSN_D2 -> conductance_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseMSN_D2 ] * ( n_MSN_D1 -> v[ i ] - rev_potential_GABA ) * W_MSND2MSND1 );
        }
        t++;
        // pre:FSI
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += - ( n_FSI -> conductance_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseFSI ] * ( n_MSN_D1 -> v[ i ] - rev_potential_GABA ) * W_FSIMSND1 );
        }
        t++;

        // pre:STN
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += - ( ( n_STN -> conductance_AMPA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseSTN ] * ( n_MSN_D1 -> v[ i ] - rev_potential_AMPA ) * W_STNMSND1_AMPA ) + ( n_STN ->  conductance_NMDA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseSTN ] * ( n_MSN_D1 -> v[ i ] - rev_potential_NMDA ) * W_STNMSND1_NMDA ) );
        }
        t++;

        // pre:GPe
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += - ( n_GPe -> conductance_GABA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseGPe ] * ( n_MSN_D1 -> v[ i ] - rev_potential_GABA ) * W_GPeMSND1 );
        }
        t++;

        // pre:SNc
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += - ( n_SNc -> conductance_DOPA[ n_MSN_D1 -> post[ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapseSNc ] * ( n_MSN_D1 -> v[ i ] - rev_potential_DOPA ) * W_SNcMSND1 );
        }
        t++;

        // pre:PTN
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += - ( ( n_PTN -> conductance_AMPA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePTN ] * ( n_MSN_D1 -> v[ i ] - rev_potential_AMPA ) * W_PTNMSND1_AMPA ) + ( n_PTN ->  conductance_NMDA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePTN ] * ( n_MSN_D1 -> v[ i ] - rev_potential_NMDA ) * W_PTNMSND1_NMDA ) );
        }
        t++;

        // pre:PSN
        for ( int j = 0; j < ( n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) ] - n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ); j++ ){ 
            r += - ( ( n_PSN -> conductance_AMPA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePSN ] * ( n_MSN_D1 -> v[ i ] - rev_potential_AMPA ) * W_PSNMSND1_AMPA ) + ( n_PSN ->  conductance_NMDA[ n_MSN_D1 -> post [ j + n_MSN_D1 -> num_pre[ i + ( t * N_MSN_D1 ) - 1 ] ] - SynapsePSN ] * ( n_MSN_D1 -> v[ i ] - rev_potential_NMDA ) * W_PSNMSND1_NMDA ) );
        }
        n_MSN_D1 -> i_syn[ i ] = r;
    }
}
// post:MSN_D2
__global__ void Synaptic_current_MSN_D2 ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PSN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN_D2 ){
        float r = 0;
        int t = 0;
        // pre:CMPf
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += - ( ( n_CMPf -> conductance_AMPA[ j ] * ( n_MSN_D2 -> v[ i ] - rev_potential_AMPA ) * W_CMPfMSND2_AMPA ) + ( n_CMPf ->  conductance_NMDA[ j ] * ( n_MSN_D2 -> v[ i ] - rev_potential_NMDA ) * W_CMPfMSND2_NMDA ) );
        }
        t++;
        // pre:MSN_D1
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){
            r += - ( n_MSN_D1 -> conductance_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseMSN_D1 ] * ( n_MSN_D2 -> v[ i ] - rev_potential_GABA ) * W_MSND1MSND2 );
        }
        t++;
        // pre:MSN_D2
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){
            r += - ( n_MSN_D2 -> conductance_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseMSN_D2 ] * ( n_MSN_D2 -> v[ i ] - rev_potential_GABA ) * W_MSND2MSND2 );
        }
        t++;
        // pre:FSI
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += - ( n_FSI -> conductance_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseFSI ] * ( n_MSN_D2 -> v[ i ] - rev_potential_GABA ) * W_FSIMSND2 );
        }
        t++;

        // pre:STN
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += - ( ( n_STN -> conductance_AMPA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseSTN ] * ( n_MSN_D2 -> v[ i ] - rev_potential_AMPA ) * W_STNMSND2_AMPA ) + ( n_STN ->  conductance_NMDA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseSTN ] * ( n_MSN_D2 -> v[ i ] - rev_potential_NMDA ) * W_STNMSND2_NMDA ) );
        }
        t++;

        // pre:GPe
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += - ( n_GPe -> conductance_GABA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseGPe ] * ( n_MSN_D2 -> v[ i ] - rev_potential_GABA ) * W_GPeMSND2 );
        }
        t++;

        // pre:SNc
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += - ( n_SNc -> conductance_DOPA[ n_MSN_D2 -> post[ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapseSNc ] * ( n_MSN_D2 -> v[ i ] - rev_potential_DOPA ) * W_SNcMSND2 );
        }
        t++;

        // pre:PTN
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += - ( ( n_PTN -> conductance_AMPA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePTN ] * ( n_MSN_D2 -> v[ i ] - rev_potential_AMPA ) * W_PTNMSND2_AMPA ) + ( n_PTN ->  conductance_NMDA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePTN ] * ( n_MSN_D2 -> v[ i ] - rev_potential_NMDA ) * W_PTNMSND2_NMDA ) );
        }
        t++;

        // pre:PSN
        for ( int j = 0; j < ( n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) ] - n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ); j++ ){ 
            r += - ( ( n_PSN -> conductance_AMPA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePSN ] * ( n_MSN_D2 -> v[ i ] - rev_potential_AMPA ) * W_PSNMSND2_AMPA ) + ( n_PSN ->  conductance_NMDA[ n_MSN_D2 -> post [ j + n_MSN_D2 -> num_pre[ i + ( t * N_MSN_D2 ) - 1 ] ] - SynapsePSN ] * ( n_MSN_D2 -> v[ i ] - rev_potential_NMDA ) * W_PSNMSND2_NMDA ) );
        }
        n_MSN_D2 -> i_syn[ i ] = r;
    }
}
// post:FSI
__global__ void Synaptic_current_FSI ( neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_PTN, neuron_t *n_PSN, neuron_t *n_CMPf ){
    
    long i = threadIdx.x + blockIdx.x * blockDim.x;
    
    if ( i < N_FSI ) {
        float r = 0;
        int t = 0;
        // pre:CMPf
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += - ( ( n_CMPf -> conductance_AMPA[ j ] * ( n_FSI -> v[ i ] - rev_potential_AMPA ) * W_CMPfFSI_AMPA ) + ( n_CMPf ->  conductance_NMDA[ j ] * ( n_FSI -> v[ i ] - rev_potential_NMDA ) * W_CMPfFSI_NMDA ) );
        }
        t++;
        // pre:FSI
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += - ( n_FSI -> conductance_GABA[ n_FSI -> post[ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseFSI ] * ( n_FSI -> v[ i ] - rev_potential_GABA ) * W_FSIFSI );
        }
        t++;
        // pre:STN
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += - ( ( n_STN -> conductance_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseSTN ] * ( n_FSI -> v[ i ] - rev_potential_AMPA ) * W_STNFSI_AMPA ) + ( n_STN ->  conductance_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseSTN ] * ( n_FSI -> v[ i ] - rev_potential_NMDA ) * W_STNFSI_NMDA ) );
        }
        t++;
        // pre:GPe
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += - ( n_GPe -> conductance_GABA[ n_FSI -> post[ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseGPe ] * ( n_FSI -> v[ i ] - rev_potential_GABA ) * W_GPeFSI );
        }
        t++;
        // pre:PTN
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += - ( ( n_PTN -> conductance_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN ] * ( n_FSI -> v[ i ] - rev_potential_AMPA ) * W_PTNFSI_AMPA ) + ( n_PTN ->  conductance_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN ] * ( n_FSI -> v[ i ] - rev_potential_NMDA ) * W_PTNFSI_NMDA ) );
        }
        t++;
        // pre:PSN
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += - ( ( n_PSN -> conductance_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePSN ] * ( n_FSI -> v[ i ] - rev_potential_AMPA ) * W_PSNFSI_AMPA ) + ( n_PSN ->  conductance_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePSN ] * ( n_FSI -> v[ i ] - rev_potential_NMDA ) * W_PSNFSI_NMDA ) );
        }
        n_FSI -> i_syn[ i ] = r;
    }
}
// post:STN
__global__ void Synaptic_current_STN ( neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_PTN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    
    if ( i < N_STN ){
        float r = 0;
        int t = 0;
        // pre:CMPf
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += - ( ( n_CMPf -> conductance_AMPA[ j ] * ( n_STN -> v[ i ] - rev_potential_AMPA ) * W_CMPfSTN_AMPA ) + ( n_CMPf ->  conductance_NMDA[ j ] * ( n_STN -> v[ i ] - rev_potential_NMDA ) * W_CMPfSTN_NMDA ) );
        }
        t++;
        // pre:GPe
        for ( int j = 0; j < ( n_STN -> num_pre[ i + ( t * N_STN ) ] - n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ); j++ ){ 
            r += - ( n_GPe -> conductance_GABA[ n_STN -> post[ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapseGPe ] * ( n_STN -> v[ i ] - rev_potential_GABA ) * W_GPeSTN );
        }
        t++;
        // pre:PTN
        for ( int j = 0; j < ( n_STN -> num_pre[ i + ( t * N_STN ) ] - n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ); j++ ){ 
            r += - ( ( n_PTN -> conductance_AMPA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapsePTN ] * ( n_STN -> v[ i ] - rev_potential_AMPA ) * W_PTNSTN_AMPA ) + ( n_PTN ->  conductance_NMDA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapsePTN ] * ( n_STN -> v[ i ] - rev_potential_NMDA ) * W_PTNSTN_NMDA ) );
        }
        t++;
        n_STN -> i_syn[ i ] = r;
    }
}
// post:GPe
__global__ void Synaptic_current_GPe ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    
    if ( i < N_GPe ){
        float r = 0;
        int t = 0;
        // pre:CMPf
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += - ( ( n_CMPf -> conductance_AMPA[ j ] * ( - n_GPe -> v[ i ] + rev_potential_AMPA ) * W_CMPfGPe_AMPA ) + ( n_CMPf ->  conductance_NMDA[ j ] * ( - n_GPe -> v[ i ] + rev_potential_NMDA ) * W_CMPfGPe_NMDA ) );
        }
        t++;
        // pre:MSN_D1
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){
            r += - ( n_MSN_D1 -> conductance_GABA[ n_GPe -> post[ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseMSN_D1 ] * ( - n_GPe -> v[ i ] + rev_potential_GABA ) * W_MSND1GPe );
        }
        t++;
        // pre:MSN_D2
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){
            r += - ( n_MSN_D2 -> conductance_GABA[ n_GPe -> post[ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseMSN_D2 ] * ( - n_GPe -> v[ i ] + rev_potential_GABA ) * W_MSND2GPe );
        }
        t++;
        // pre:STN
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){ 
            r += - ( ( n_STN -> conductance_AMPA[ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseSTN ] * ( - n_GPe -> v[ i ] + rev_potential_AMPA ) * W_STNGPe_AMPA ) + ( n_STN ->  conductance_NMDA[ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseSTN ] * ( - n_GPe -> v[ i ] + rev_potential_NMDA ) * W_STNGPe_NMDA ) );
        }
        t++;
        // pre:GPe
        for ( int j = 0; j < ( n_GPe -> num_pre[ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){ 
            r += - ( n_GPe -> conductance_GABA[ n_GPe -> post[ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseGPe ] * ( - n_GPe -> v[ i ] + rev_potential_GABA ) * W_GPeGPe );
        }
        n_GPe -> i_syn[ i ] = r;
    }
}
// post:GPi
__global__ void Synaptic_current_GPi ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    
    if ( i < N_GPi ){
        float r = 0;
        int t = 0;
        // pre:CMPf
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += - ( ( n_CMPf -> conductance_AMPA[ j ] * ( - n_GPi -> v[ i ] + rev_potential_AMPA ) * W_CMPfGPi_AMPA ) + ( n_CMPf ->  conductance_NMDA[ j ] * ( - n_GPi -> v[ i ] + rev_potential_NMDA ) * W_CMPfGPi_NMDA ) );
        }
        t++;
        // pre:MSN_D1
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){
            r += - ( n_MSN_D1 -> conductance_GABA[ n_GPi -> post[ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseMSN_D1 ] * ( - n_GPi -> v[ i ] + rev_potential_GABA ) * W_MSND1GPi );
        }
        t++;
        // pre:MSN_D2
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){
            r += - ( n_MSN_D2 -> conductance_GABA[ n_GPi -> post[ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseMSN_D2 ] * ( - n_GPi -> v[ i ] + rev_potential_GABA ) * W_MSND2GPi );
        }
        t++;
        // pre:STN
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){ 
            r += - ( ( n_STN -> conductance_AMPA[ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseSTN ] * ( - n_GPi -> v[ i ] + rev_potential_AMPA ) * W_STNGPi_AMPA ) + ( n_STN ->  conductance_NMDA[ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseSTN ] * ( - n_GPi -> v[ i ] + rev_potential_NMDA ) * W_STNGPi_NMDA ) );
        }
        t++;
        // pre:GPe
        for ( int j = 0; j < ( n_GPi -> num_pre[ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){ 
            r += - ( n_GPe -> conductance_GABA[ n_GPi -> post[ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseGPe ] * ( - n_GPi -> v[ i ] + rev_potential_GABA ) * W_GPeGPi );
        }
        n_GPi -> i_syn[ i ] = r;
    }
}
// post:SNc
__global__ void Synaptic_current_SNc ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_SNc ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_SNc ){
        float r = 0;
        int t = 0;
        // pre:MSN_D1
        for ( int j = 0; j < ( n_SNc -> num_pre[ i + 1 ] - n_SNc -> num_pre[ i ] ); j++ ){ 
            r += - ( n_MSN_D1 -> conductance_GABA[ n_SNc -> post[ j + n_SNc -> num_pre[ i ] ] - SynapseMSN_D1 ] * ( - n_SNc -> v[ i ] + rev_potential_GABA ) * W_MSND1SNc );
        }
        t++;
        // pre:MSN_D2
        for ( int j = 0; j < ( n_SNc -> num_pre[ i + ( t * N_SNc ) + 1 ] - n_SNc -> num_pre[ i + ( t * N_SNc ) ] ); j++ ){
            r += - ( n_MSN_D2 -> conductance_GABA[ n_SNc -> post[ j + n_SNc -> num_pre[ i + ( t * N_SNc ) ] ] - SynapseMSN_D2 ] * ( - n_SNc -> v[ i ] + rev_potential_GABA ) * W_MSND2SNc );
        }
        n_SNc -> i_syn[ i ] = r;
    }
}
// post:PTN
__global__ void Synaptic_current_PTN ( neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    
    if ( i < N_PTN ){
        float r = 0;
        int t = 0;
        // pre:PTI
        for ( int j = 0; j < ( n_PTN -> num_pre[ i + 1 ] - n_PTN -> num_pre[ i ] ); j++ ){
            r += - ( n_PTI -> conductance_GABA[ n_PTN -> post[ j + n_PTN -> num_pre[ i ] ] - SynapsePTI ] * ( - n_PTN -> v[ i ] + rev_potential_GABA ) * W_PTIPTN );
        }
        t++;
        // pre:PSN
        for ( int j = 0; j < ( n_PTN -> num_pre[ i + ( t * N_PTN ) + 1 ] - n_PTN -> num_pre[ i + ( t * N_PTN ) ] ); j++ ){ 
            r += - ( ( n_PSN -> conductance_AMPA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapsePSN ] * ( - n_PTN -> v[ i ] + rev_potential_AMPA ) * W_PSNPTN_AMPA ) + ( n_PSN ->  conductance_NMDA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapsePSN ] * ( - n_PTN -> v[ i ] + rev_potential_NMDA ) * W_PSNPTN_NMDA ) );
        }
        t++;
        // pre:Th
        for ( int j = 0; j < ( n_PTN -> num_pre[ i + ( t * N_PTN ) + 1 ] - n_PTN -> num_pre[ i + ( t * N_PTN ) ] ); j++ ){ 
            r += - ( ( n_Th -> conductance_AMPA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapseTh ] * ( - n_PTN -> v[ i ] + rev_potential_AMPA ) * W_ThPTN_AMPA ) + ( n_Th ->  conductance_NMDA[ n_PTN -> post [ j + n_PTN -> num_pre[ i + ( t * N_PTN ) - 1 ] ] - SynapseTh ] * ( - n_PTN -> v[ i ] + rev_potential_NMDA ) * W_ThPTN_NMDA ) );
        }
        n_PTN -> i_syn[ i ] = r;
    }
}
// post:PTI
__global__ void Synaptic_current_PTI ( neuron_t *n_PTN, neuron_t *n_PTI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    

    if ( i < N_PTI ){
        float r = 0;
        // pre:PTN
        for ( int j = 0; j < ( n_PTI -> num_pre[ i + 1 ] - n_PTI -> num_pre[ i ] ); j++ ){ 
            r += - ( ( n_PTN -> conductance_AMPA[ n_PTI -> post [ j + n_PTI -> num_pre[ i ] ] - SynapsePTN ] * ( - n_PTI -> v[ i ] + rev_potential_AMPA ) * W_PTNPTI_AMPA ) + ( n_PTN ->  conductance_NMDA[ n_PTI -> post [ j + n_PTI -> num_pre[ i ] ] - SynapsePTN ] * ( - n_PTI -> v[ i ] + rev_potential_NMDA ) * W_PTNPTI_NMDA ) );
        }
        n_PTI -> i_syn[ i ] = r;
    }
}
// post:Th
__global__ void Synaptic_current_Th ( neuron_t *n_GPi, neuron_t *n_PTN, neuron_t *n_Th ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    
    if ( i < N_Th ){
        float r = 0;
        int t = 0;
        // pre:GPi
        for ( int j = 0; j < ( n_Th -> num_pre[ i + 1 ] - n_Th -> num_pre[ i ] ); j++ ){
            r += - ( n_GPi -> conductance_GABA[ n_Th -> post[ j + n_Th -> num_pre[ i ] ] - SynapseGPi ] * ( - n_Th -> v[ i ] + rev_potential_GABA ) * W_GPiTh );
        }
        t++;
        // pre:PTN
        for ( int j = 0; j < ( n_Th -> num_pre[ i + ( t * N_Th ) + 1 ] - n_Th -> num_pre[ i + ( t * N_Th ) ] ); j++ ){ 
            r += - ( ( n_PTN -> conductance_AMPA[ n_Th -> post [ j + n_Th -> num_pre[ i + ( t * N_Th ) - 1 ] ] - SynapsePTN ] * ( - n_Th -> v[ i ] + rev_potential_AMPA ) * W_PTNTh_AMPA ) + ( n_PTN ->  conductance_NMDA[ n_Th -> post [ j + n_Th -> num_pre[ i + ( t * N_Th ) - 1 ] ] - SynapsePTN ] * ( - n_Th -> v[ i ] + rev_potential_NMDA ) * W_PTNTh_NMDA ) );
        }
        n_Th -> i_syn[ i ] = r;
    }
}

void Synaptic_current ( neuron_t *n_MSN_D1, neuron_t *n_MSN_D2, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_SNc, neuron_t *n_PTN, neuron_t *n_PTI, neuron_t *n_PSN, neuron_t *n_Th, neuron_t *n_CMPf ){

    Synaptic_current_MSN_D1 <<< GRID_SIZE_MSN_D1, BLOCK_SIZE >>> ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_SNc, n_PTN, n_PSN, n_CMPf );
    cudaDeviceSynchronize ( );
    Synaptic_current_MSN_D2 <<< GRID_SIZE_MSN_D2, BLOCK_SIZE >>> ( n_MSN_D1, n_MSN_D2, n_FSI, n_STN, n_GPe, n_SNc, n_PTN, n_PSN, n_CMPf );
    cudaDeviceSynchronize ( );
    Synaptic_current_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( n_FSI, n_STN, n_GPe, n_PTN, n_PSN, n_CMPf );
    cudaDeviceSynchronize ( );
    Synaptic_current_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( n_STN, n_GPe, n_PTN, n_CMPf );
    cudaDeviceSynchronize ( );
    Synaptic_current_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( n_MSN_D1, n_MSN_D2, n_STN, n_GPe, n_CMPf );
    cudaDeviceSynchronize ( );
    Synaptic_current_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( n_MSN_D1, n_MSN_D2, n_STN, n_GPe, n_GPi, n_CMPf );
    cudaDeviceSynchronize ( );
    Synaptic_current_SNc <<< GRID_SIZE_SNc, BLOCK_SIZE >>> ( n_MSN_D1, n_MSN_D2, n_SNc );
    cudaDeviceSynchronize ( );
    Synaptic_current_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( n_PTN, n_PTI, n_PSN, n_Th );
    cudaDeviceSynchronize ( );
    Synaptic_current_PTI <<< GRID_SIZE_PTI, BLOCK_SIZE >>> ( n_PTN, n_PTI );
    cudaDeviceSynchronize ( );
    Synaptic_current_Th <<< GRID_SIZE_Th, BLOCK_SIZE >>> ( n_GPi, n_PTN, n_Th );
    cudaDeviceSynchronize ( );
}