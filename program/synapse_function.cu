#include <stdio.h>
#include <math.h>
#include <SFMT.h>
#include "param.h"

//γ
__device__ float DistanceDecay( int x, int y ){

    float r;
    if ( x == MSN ){

        if ( y == CSN ){

            r = cosh ( L_MSN * ( 1 - p_CSNMSN ) ) / cosh ( L_MSN );
            return r;
        }
        else if ( y == PTN ){

            r = cosh ( L_MSN * ( 1 - p_PTNMSN ) ) / cosh ( L_MSN );
            return r;
        }
        else if ( y == MSN ){

            r = cosh ( L_MSN * ( 1 - p_MSNMSN ) ) / cosh ( L_MSN );
            return r;
        }
        else if ( y == FSI ){

            r = cosh ( L_MSN * ( 1 - p_FSIMSN ) ) / cosh ( L_MSN );
            return r;
        }
        else if ( y == STN ){

            r = cosh ( L_MSN * ( 1 - p_STNMSN ) ) / cosh ( L_MSN );
            return r;
        }
        else if ( y == GPe ){

            r = cosh ( L_MSN * ( 1 - p_GPeMSN ) ) / cosh ( L_MSN );
            return r;
        }
        else {

            r = cosh ( L_MSN * ( 1 - p_CMPfMSN ) ) / cosh ( L_MSN );
            return r;
        }
    }
    else if ( x == FSI ){

        if ( y == CSN ){

            r = cosh ( L_FSI * ( 1 - p_CSNFSI ) ) / cosh ( L_FSI );
            return r;
        }
        else if ( y == PTN ){

            r = cosh ( L_FSI * ( 1 - p_PTNFSI ) ) / cosh ( L_FSI );
            return r;
        }
        else if ( y == FSI ){

            r = cosh ( L_FSI * ( 1 - p_FSIFSI ) ) / cosh ( L_FSI );
            return r;
        }
        else if ( y == STN ){

            r = cosh ( L_FSI * ( 1 - p_STNFSI ) ) / cosh ( L_FSI );
            return r;
        }
        else if ( y == GPe ){

            r = cosh ( L_FSI * ( 1 - p_GPeFSI ) ) / cosh ( L_FSI );
            return r;
        }
        else {

            r = cosh ( L_FSI * ( 1 - p_CMPfFSI ) ) / cosh ( L_FSI );
            return r;
        }
    }
    else if ( x == STN ){

        if ( y == PTN ){

            r = cosh ( L_STN * ( 1 - p_PTNSTN ) ) / cosh ( L_STN );
            return r;
        }
        else if ( y == GPe ){

            r = cosh ( L_STN * ( 1 - p_GPeSTN ) ) / cosh ( L_STN );
            return r;
        }
        else {

            r = cosh ( L_STN * ( 1 - p_CMPfSTN ) ) / cosh ( L_STN );
            return r;
        }
    }
    else if ( x == GPe ){

        if ( y == MSN ){

            r = cosh ( L_GPe * ( 1 - p_MSNGPe ) ) / cosh ( L_GPe );
            return r;
        }
        else if ( y == STN ){

            r = cosh ( L_GPe * ( 1 - p_STNGPe ) ) / cosh ( L_GPe );
            return r;
        }
        else if ( y == GPe ){

            r = cosh ( L_GPe * ( 1 - p_GPeGPe ) ) / cosh ( L_GPe );
            return r;
        }
        else {

            r = cosh ( L_GPe * ( 1 - p_CMPfGPe ) ) / cosh ( L_GPe );
            return r;
        }
    }
    else{

        if ( y == MSN ){

            r = cosh ( L_GPi * ( 1 - p_MSNGPi ) ) / cosh ( L_GPi );
            return r;
        }
        else if ( y == STN ){

            r = cosh ( L_GPi * ( 1 - p_STNGPi ) ) / cosh ( L_GPi );
            return r;
        }
        else if ( y == GPe ){

            r = cosh ( L_GPi * ( 1 - p_GPeGPi ) ) / cosh ( L_GPi );
            return r;
        }
        else {

            r = cosh ( L_GPi * ( 1 - p_CMPfGPi ) ) / cosh ( L_GPi );
            return r;
        }
    }
}

__device__ void ExcSynapse ( int nt, long i, neuron_t *preneuron ){

    preneuron -> alpha_AMPA[ i ] = ( float ) tauAMPA * preneuron -> alpha_AMPA[ i ];
    preneuron -> alpha_NMDA[ i ] = ( float ) tauNMDA * preneuron -> alpha_NMDA[ i ] + W_NMDA * ( preneuron -> ts[ i ] + DELAY == nt );;
}
__device__ void InhSynapse ( int nt, long i, neuron_t *preneuron ){

    preneuron -> alpha_GABA[ i ] = ( float ) tauGABA * preneuron -> alpha_GABA[ i ];
}

__global__ void updateSynapse_MSN ( int nt, neuron_t *n_MSN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_MSN ){
        InhSynapse ( nt, i, n_MSN );
    }
}
__global__ void updateSynapse_FSI ( int nt, neuron_t *n_FSI ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_FSI ){
        InhSynapse ( nt, i, n_FSI );
    }
}
__global__ void updateSynapse_STN ( int nt, neuron_t *n_STN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_STN ){
        ExcSynapse ( nt, i, n_STN );
    }
}
__global__ void updateSynapse_GPe ( int nt, neuron_t *n_GPe ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_GPe ){
        InhSynapse ( nt, i, n_GPe );
    }
}
__global__ void updateSynapse_CSN ( int nt, neuron_t *n_CSN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_CSN ){
        ExcSynapse ( nt, i, n_CSN );
    }
}
__global__ void updateSynapse_PTN ( int nt, neuron_t *n_PTN ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    if ( i < N_PTN ){
        ExcSynapse ( nt, i, n_PTN );
    }
}
__global__ void updateSynapse_CMPf ( int nt, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;

    if ( i < N_CMPf ){
        ExcSynapse ( nt, i, n_CMPf );
    }
}
void updateSynapse ( int nt, neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

    updateSynapse_MSN <<< GRID_SIZE_MSN, BLOCK_SIZE >>> ( nt, n_MSN );
    cudaDeviceSynchronize ( );
    updateSynapse_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( nt, n_FSI );
    cudaDeviceSynchronize ( );
    updateSynapse_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( nt, n_STN );
    cudaDeviceSynchronize ( );
    updateSynapse_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( nt, n_GPe );
    cudaDeviceSynchronize ( );
    updateSynapse_CSN <<< GRID_SIZE_CSN, BLOCK_SIZE >>> ( nt, n_CSN );
    cudaDeviceSynchronize ( );
    updateSynapse_PTN <<< GRID_SIZE_PTN, BLOCK_SIZE >>> ( nt, n_PTN );
    cudaDeviceSynchronize ( );
    updateSynapse_CMPf <<< GRID_SIZE_CMPf, BLOCK_SIZE >>> ( nt, n_CMPf );
    cudaDeviceSynchronize ( );
}

__global__ void InputSynapsePotential_MSN ( int nt, neuron_t *n_MSN, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    neuron_kind x, y;

    if ( i < N_MSN ){
        float r = 0;
        int t = 0;
        x = MSN;
        y = MSN;
        for ( int j = 0; j < N_MSN; j++ ){
            r -= ( n_MSN -> alpha_GABA[ j ] + W_MSNMSN * ( n_MSN -> ts[ j ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;

        y = FSI;
        for ( int j = 0; j < ( n_MSN -> num_pre [ i + ( t * N_MSN ) ] - n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ); j++ ){ 
            r -= ( n_FSI -> alpha_GABA [ n_MSN -> post [ j + n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ] - SynapseFSI ] + W_FSIMSN * ( n_FSI -> ts [ n_MSN -> post [ j + n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ] - SynapseFSI ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;

        y = STN;
        for ( int j = 0; j < ( n_MSN -> num_pre [ i + ( t * N_MSN ) ] - n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ); j++ ){ 
            r += ( ( n_STN -> alpha_AMPA [ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapseSTN ] + W_STNMSN * ( n_STN -> ts [ n_MSN -> post [ j + n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ] - SynapseSTN ] + DELAY == nt ) ) + n_STN -> alpha_NMDA[ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapseSTN ] ) * DistanceDecay ( x, y );
        }
        t++;

        y = GPe;
        for ( int j = 0; j < ( n_MSN -> num_pre [ i + ( t * N_MSN ) ] - n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ); j++ ){ 
            r -= ( n_GPe -> alpha_GABA [ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapseGPe ] + W_GPeMSN * ( n_GPe -> ts [ n_MSN -> post [ j + n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ] - SynapseGPe ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;

        y = CSN;
        for ( int j = 0; j < ( n_MSN -> num_pre[ i + ( t * N_MSN ) ] - n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ); j++ ){ 
            r += ( ( n_CSN -> alpha_AMPA[ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapseCSN ] + W_CSNMSN * ( n_CSN -> ts [ n_MSN -> post [ j + n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ] - SynapseCSN ] + DELAY == nt ) ) + n_CSN -> alpha_NMDA[ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapseCSN ] ) * DistanceDecay ( x, y );
        }
        t++;

        y = PTN;
        for ( int j = 0; j < ( n_MSN -> num_pre[ i + ( t * N_MSN ) ] - n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ); j++ ){ 
            r += ( ( n_PTN -> alpha_AMPA[ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapsePTN ] + W_PTNMSN * ( n_PTN -> ts [ n_MSN -> post [ j + n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ] - SynapsePTN ] + DELAY == nt ) ) + n_PTN -> alpha_NMDA[ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapsePTN ] ) * DistanceDecay ( x, y );
        }
        t++;

        y = CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( ( n_CMPf -> alpha_AMPA[ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapseCMPf ] + W_CMPfMSN * ( n_CMPf -> ts [ n_MSN -> post [ j + n_MSN -> num_pre [ i + ( t * N_MSN ) - 1 ] ] - SynapseCMPf ] + DELAY == nt ) ) + n_CMPf -> alpha_NMDA[ n_MSN -> post [ j + n_MSN -> num_pre[ i + ( t * N_MSN ) - 1 ] ] - SynapsePTN  ] ) * DistanceDecay ( x, y );
        }
        n_MSN -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_FSI ( int nt, neuron_t *n_FSI, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){
    
    long i = threadIdx.x + blockIdx.x * blockDim.x;
    neuron_kind x, y;

    if ( i < N_FSI ) {
        float r = 0;
        int t = 0;
        x = FSI;
        y = FSI;
        for ( int j = 0; j < N_FSI; j++ ){ 
            r -= ( n_FSI -> alpha_GABA[ j ] + W_FSIFSI * ( n_FSI -> ts[ j ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;

        y = STN;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += ( ( n_STN -> alpha_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseSTN ] + W_STNFSI * ( n_STN -> ts [ n_FSI -> post [ j + n_FSI -> num_pre [ i + ( t * N_FSI ) - 1 ] ] - SynapseSTN ] + DELAY == nt ) ) + n_STN -> alpha_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseSTN ] ) * DistanceDecay ( x, y );
        }
        t++;

        y = GPe;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r -= ( n_GPe -> alpha_GABA[ n_FSI -> post[ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseGPe ]  + W_GPeFSI * ( n_GPe -> ts [ n_FSI -> post [ j + n_FSI -> num_pre [ i + ( t * N_FSI ) - 1 ] ] - SynapseGPe ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;

        y = CSN;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += ( ( n_CSN -> alpha_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseCSN ] + W_CSNFSI * ( n_CSN -> ts [ n_FSI -> post [ j + n_FSI -> num_pre [ i + ( t * N_FSI ) - 1 ] ] - SynapseCSN ] + DELAY == nt ) ) + n_CSN -> alpha_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseCSN ] ) * DistanceDecay ( x, y );
        }
        t++;

        y = PTN;
        for ( int j = 0; j < ( n_FSI -> num_pre[ i + ( t * N_FSI ) ] - n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ); j++ ){ 
            r += ( ( n_PTN -> alpha_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN ] + W_PTNFSI * ( n_PTN -> ts [ n_FSI -> post [ j + n_FSI -> num_pre [ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN ] + DELAY == nt ) ) + n_PTN -> alpha_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN ] ) * DistanceDecay ( x, y );
        }
        t++;

        y = CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( ( n_CMPf -> alpha_AMPA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapseCMPf ] + W_CMPfFSI * ( n_CMPf -> ts [ n_FSI -> post [ j + n_FSI -> num_pre [ i + ( t * N_FSI ) - 1 ] ] - SynapseCMPf ] + DELAY == nt ) ) + n_CMPf -> alpha_NMDA[ n_FSI -> post [ j + n_FSI -> num_pre[ i + ( t * N_FSI ) - 1 ] ] - SynapsePTN  ] ) * DistanceDecay ( x, y );
        }
        n_FSI -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_STN ( int nt, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_PTN, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    neuron_kind x, y;

    if ( i < N_STN ){
        float r = 0;
        int t = 0;
        x = STN;
        y = GPe;
        for ( int j = 0; j < N_GPe; j++ ){ 
            r -= ( n_GPe -> alpha_GABA [ j ] + W_GPeSTN * ( n_GPe -> ts [ j ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;
        y = PTN;
        for ( int j = 0; j < ( n_STN -> num_pre[ i + ( t * N_STN ) ] - n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ); j++ ){ 
            r += ( ( n_PTN -> alpha_AMPA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapsePTN ] + W_PTNSTN * ( n_PTN -> ts [ n_STN -> post [ j + n_STN -> num_pre [ i + ( t * N_STN ) - 1 ] ] - SynapsePTN ] + DELAY == nt ) ) + n_PTN -> alpha_NMDA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapsePTN ] ) * DistanceDecay ( x, y );
        }
        t++;
        y = CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( ( n_CMPf -> alpha_AMPA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapseCMPf ] + W_CMPfSTN * ( n_CMPf -> ts [ n_STN -> post [ j + n_STN -> num_pre [ i + ( t * N_STN ) - 1 ] ] - SynapseCMPf ] + DELAY == nt ) ) + n_CMPf -> alpha_NMDA[ n_STN -> post [ j + n_STN -> num_pre[ i + ( t * N_STN ) - 1 ] ] - SynapsePTN  ] ) * DistanceDecay ( x, y );
        }
        n_STN -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_GPe ( int nt, neuron_t *n_MSN, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    neuron_kind x, y;

    if ( i < N_GPe ){
        float r = 0;
        int t = 0;
        x = GPe;
        y = MSN;
        for ( int j = 0; j < N_MSN; j++ ){
            r -= ( n_MSN -> alpha_GABA[ j ] + W_MSNGPe * ( n_MSN -> ts[ j ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;
        y = STN;
        for ( int j = 0; j < ( n_GPe -> num_pre [ i + ( t * N_GPe ) ] - n_GPe -> num_pre [ i + ( t * N_GPe ) - 1 ] ); j++ ){ 
            r += ( ( n_STN -> alpha_AMPA [ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseSTN ] + W_STNGPe * ( n_STN -> ts [ n_GPe -> post [ j + n_GPe -> num_pre [ i + ( t * N_GPe ) - 1 ] ] - SynapseSTN ] + DELAY == nt ) ) + n_STN -> alpha_NMDA[ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseSTN ] ) * DistanceDecay ( x, y );
        }
        t++;
        y = GPe;
        for ( int j = 0; j < ( n_GPe -> num_pre [ i + ( t * N_GPe ) ] - n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ); j++ ){ 
            r -= ( n_GPe -> alpha_GABA [ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseGPe ] + W_GPeGPe * ( n_GPe -> ts [ n_GPe -> post [ j + n_GPe -> num_pre [ i + ( t * N_GPe ) - 1 ] ] - SynapseGPe ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;
        y = CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( ( n_CMPf -> alpha_AMPA[ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapseCMPf ] + W_CMPfGPe * ( n_CMPf -> ts [ n_GPe -> post [ j + n_GPe -> num_pre [ i + ( t * N_GPe ) - 1 ] ] - SynapseCMPf ] + DELAY == nt ) ) + n_CMPf -> alpha_NMDA[ n_GPe -> post [ j + n_GPe -> num_pre[ i + ( t * N_GPe ) - 1 ] ] - SynapsePTN  ] ) * DistanceDecay ( x, y );
        }
        n_GPe -> ig[ i ] = r;
    }
}
__global__ void InputSynapsePotential_GPi ( int nt, neuron_t *n_MSN, neuron_t *n_STN, neuron_t *n_GPe, neuron_t *n_GPi, neuron_t *n_CMPf ){

    long i = threadIdx.x + blockIdx.x * blockDim.x;
    neuron_kind x, y;

    if ( i < N_GPi ){
        float r = 0;
        int t = 0;
        x = GPi;
        y = CMPf;
        for ( int j = 0; j < N_CMPf; j++ ){ 
            r += ( ( n_CMPf -> alpha_AMPA[ j ] + W_CMPfGPi * ( n_CMPf -> ts [ j ] + DELAY == nt ) ) + n_CMPf -> alpha_NMDA[ j ] ) * DistanceDecay ( x, y );
        }
        t++;
        y = STN;
        for ( int j = 0; j < ( n_GPi -> num_pre [ i + ( t * N_GPi ) ] - n_GPi -> num_pre [ i + ( t * N_GPi ) - 1 ] ); j++ ){ 
            r += ( ( n_STN -> alpha_AMPA [ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseSTN ] + W_STNGPi * ( n_STN -> ts [ n_GPi -> post [ j + n_GPi -> num_pre [ i + ( t * N_GPi ) - 1 ] ] - SynapseSTN ] + DELAY == nt ) ) + n_STN -> alpha_NMDA[ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseSTN ] ) * DistanceDecay ( x, y );
        }
        t++;
        y = GPe;
        for ( int j = 0; j < ( n_GPi -> num_pre [ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){ 
            r -= ( n_GPe -> alpha_GABA [ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseGPe ] + W_GPeGPi * ( n_GPe -> ts [ n_GPi -> post [ j + n_GPi -> num_pre [ i + ( t * N_GPi ) - 1 ] ] - SynapseGPe ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        t++;
        y = MSN;
        for ( int j = 0; j < ( n_GPi -> num_pre [ i + ( t * N_GPi ) ] - n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ); j++ ){
            r -= ( n_MSN -> alpha_GABA[ n_GPi -> post [ j + n_GPi -> num_pre[ i + ( t * N_GPi ) - 1 ] ] - SynapseMSN ] + W_MSNGPi * ( n_MSN -> ts[ n_GPi -> post [ j + n_GPi -> num_pre [ i + ( t * N_GPi ) - 1 ] ] - SynapseMSN ] + DELAY == nt ) ) * DistanceDecay ( x, y );
        }
        n_GPi -> ig[ i ] = r;
    }
}
void InputSynapsePotential ( int nt, neuron_t *n_MSN , neuron_t *n_FSI , neuron_t *n_STN , neuron_t *n_GPe , neuron_t *n_GPi, neuron_t *n_CSN, neuron_t *n_PTN, neuron_t *n_CMPf ){

    InputSynapsePotential_MSN <<< GRID_SIZE_MSN, BLOCK_SIZE >>> ( nt, n_MSN, n_FSI, n_STN, n_GPe, n_CSN, n_PTN, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_FSI <<< GRID_SIZE_FSI, BLOCK_SIZE >>> ( nt, n_FSI, n_STN, n_GPe, n_CSN, n_PTN, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_STN <<< GRID_SIZE_STN, BLOCK_SIZE >>> ( nt, n_STN, n_GPe, n_PTN, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_GPe <<< GRID_SIZE_GPe, BLOCK_SIZE >>> ( nt, n_MSN, n_STN, n_GPe, n_CMPf );
    cudaDeviceSynchronize ( );
    InputSynapsePotential_GPi <<< GRID_SIZE_GPi, BLOCK_SIZE >>> ( nt, n_MSN, n_STN, n_GPe, n_GPi, n_CMPf );
    cudaDeviceSynchronize ( );
}