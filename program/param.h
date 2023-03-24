#include <math.h>
#include <stdlib.h>

#define BLOCK_SIZE ( 32 )
#define GRID_SIZE_MSN  ( ( ( N_MSN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_FSI  ( ( ( N_FSI ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_STN  ( ( ( N_STN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_GPe  ( ( ( N_GPe ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_GPi  ( ( ( N_GPi ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_CSN  ( ( ( N_CSN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_PTN  ( ( ( N_PTN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_CMPf  ( ( ( N_CMPf ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )

//チャネル毎のニューロン数
#define per_chanel_N_MSN ( 10576L )
#define per_chanel_N_FSI ( 212L )
#define per_chanel_N_STN ( 32L )
#define per_chanel_N_GPe ( 100L )
#define per_chanel_N_GPi ( 56L )
#define per_chanel_N_CSN ( 500L )
#define per_chanel_N_PTN ( 500L )
#define per_chanel_N_CMPf ( 500L )

//細胞腫毎の総ニューロン数
#define N_MSN ( per_chanel_N_MSN * N_chanel )
#define N_FSI ( per_chanel_N_FSI * N_chanel )
#define N_STN ( per_chanel_N_STN * N_chanel )
#define N_GPe ( per_chanel_N_GPe * N_chanel )
#define N_GPi ( per_chanel_N_GPi * N_chanel )
#define N_CSN ( per_chanel_N_CSN * N_chanel )
#define N_PTN ( per_chanel_N_PTN * N_chanel )
#define N_CMPf ( per_chanel_N_CMPf * N_chanel )

//チャネル数
#define N_chanel ( 2 )

#define N_char ( 32 )

#define N_i ( 20 )

#define N_select ( 500 )

#define NumKindsNeuron ( 8 )

//θ
#define THETA_MSN ( 30. )
#define THETA_FSI ( 19.59355 )
#define THETA_STN ( 25.66785 )
#define THETA_GPe ( 9.7298 )
#define THETA_GPi ( 5.847905 )

//初期膜電位
#define V_INIT  ( -20. )

//発火率
#define PHI_MIN_CSN ( 0.002 )
#define PHI_MAX_CSN ( 0.02 )
#define PHI_MIN_PTN ( 0.015 )
#define PHI_MAX_PTN ( 0.046 )
#define PHI_CMPf ( 0.004 )


//時定数
#define TAU_MSN ( 13 )
#define TAU_FSI ( 16 )
#define TAU_STN ( 26 )
#define TAU_GPe ( 14 )
#define TAU_GPi ( 14 )

#define V_REST  ( 0. ) //静止電位
#define V_RESET ( 0. ) //リセット電位

//入力電力
#define Vc_MSN ( 24.5 / N_MSN )
#define Vc_FSI ( 8. / N_FSI )
#define Vc_STN ( 9.5 / N_STN )
#define Vc_GPe ( 12. / N_GPe )
#define Vc_GPi ( 11. / N_GPi )

//synaptic rise time
#define PSP_AMPA ( 5. )
#define PSP_GABA ( 5. )
#define PSP_NMDA ( 100 )

//膜の抵抗
#define R_M ( 20000 ) //Ω×cm^2
//細胞内抵抗
#define R_i ( 200 ) //Ω×cm^2

//cm
#define l_MSN ( 0.0619 )
#define l_FSI ( 0.0961 )
#define l_STN ( 0.0750 )
#define l_GPe ( 0.0865 )
#define l_GPi ( 0.1132 )

//直径cm
#define d_MSN ( 0.0001 )
#define d_FSI ( 0.00015 )
#define d_STN ( 0.00015 )
#define d_GPe ( 0.00017 )
#define d_GPi ( 0.00012 )

//% of 投射ニューロン
#define P_MSNGPi ( 0.82 )
#define P_STNGPe ( 0.83 )
#define P_STNGPi ( 0.72 )
#define P_STNMSN ( 0.17 )
#define P_STNFSI ( 0.17 )
#define P_GPeGPe ( 0.84 )
#define P_GPeGPi ( 0.84 )
#define P_GPeMSN ( 0.16 )
#define P_GPeFSI ( 0.16 )
#define P_other ( 1.0 )

//受容体の位置(樹状突起の長さの比)%
#define p_CSNMSN ( 0.958512 )
#define p_PTNMSN ( 1 )
#define p_MSNMSN ( 0.801696 )
#define p_FSIMSN ( 0.159272 )
#define p_STNMSN ( 0.162429 )
#define p_GPeMSN ( 0 )
#define p_CMPfMSN ( 0.455054 )
#define p_CSNFSI ( 0.923131 )
#define p_PTNFSI ( 0.815 )
#define p_FSIFSI ( 0.393372 )
#define p_STNFSI ( 0.264905 )
#define p_GPeFSI ( 0.36304 )
#define p_CMPfFSI ( 0 )
#define p_PTNSTN ( 0.839873 )
#define p_GPeSTN ( 0.288587 )
#define p_CMPfSTN ( 0.480341 )
#define p_MSNGPe ( 0.54 )
#define p_STNGPe ( 0.485093 )
#define p_GPeGPe ( 0 )
#define p_CMPfGPe ( 0.179685 )
#define p_MSNGPi ( 0.490618 )
#define p_STNGPi ( 0.542013 )
#define p_GPeGPi ( 0.0958386 )
#define p_CMPfGPi ( 0.425297 )

#define FreeRun       ( 100 )
#define T       ( 1000 )
#define DT      ( 1.   )
#define NT      ( 1000 )

//冗長性
#define rho ( 3. )

//PSP振幅
#define W_NMDA ( 0.025 )
#define W_MSNMSN ( 1.0 )
#define W_FSIMSN ( 1. )
#define W_STNMSN ( 0.25 )
#define W_GPeMSN ( 0.75 )
#define W_CSNMSN ( 0.5 )
#define W_PTNMSN ( 0.5 )
#define W_CMPfMSN ( 0.2 )
#define W_FSIFSI ( 1.0 )
#define W_STNFSI ( 0.1 )
#define W_GPeFSI ( 0.85 )
#define W_CSNFSI ( 0.25 )
#define W_PTNFSI ( 0.25 )
#define W_CMPfFSI ( 0.1 )
#define W_GPeSTN ( 0.25 )
#define W_PTNSTN ( 0.3 )
#define W_CMPfSTN ( 0.3 )
#define W_MSNGPe ( 0.1 )
#define W_STNGPe ( 1.0 )
#define W_GPeGPe ( 0.1 )
#define W_CMPfGPe ( 1.5 )
#define W_MSNGPi ( 0.65 )
#define W_STNGPi ( 1.0 )
#define W_GPeGPi ( 0.35 )
#define W_CMPfGPi ( 1. )

//不応期
#define T_REFR ( 2. )

//遅延
#define DELAY ( 1 )

#define SynapseMSN ( 0 )
#define SynapseFSI ( N_MSN )
#define SynapseSTN ( N_MSN + N_FSI )
#define SynapseGPe ( N_MSN + N_FSI + N_STN )
#define SynapseGPi ( N_MSN + N_FSI + N_STN + N_GPe )
#define SynapseCSN ( N_MSN + N_FSI + N_STN + N_GPe + N_GPi )
#define SynapsePTN ( N_MSN + N_FSI + N_STN + N_GPe + N_GPi + N_CSN )
#define SynapseCMPf ( N_MSN + N_FSI + N_STN + N_GPe + N_GPi + N_CSN + N_PTN )

//時定数
#define tauAMPA ( exp ( - DT / PSP_AMPA ) )
#define tauNMDA ( exp ( - DT / PSP_NMDA ) )
#define tauGABA ( exp ( - DT / PSP_GABA ) )

#define L_MSN ( l_MSN * sqrt( ( 4 * R_i ) / ( d_MSN * R_M ) ) )
#define L_FSI ( l_FSI * sqrt( ( 4 * R_i ) / ( d_FSI * R_M ) ) )
#define L_STN ( l_STN * sqrt( ( 4 * R_i ) / ( d_STN * R_M ) ) )
#define L_GPe ( l_GPe * sqrt( ( 4 * R_i ) / ( d_GPe * R_M ) ) )
#define L_GPi ( l_GPi * sqrt( ( 4 * R_i ) / ( d_GPi * R_M ) ) )s