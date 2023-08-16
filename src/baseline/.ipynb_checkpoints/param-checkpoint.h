#include <math.h>
#include <stdlib.h>

#define BLOCK_SIZE        ( 32 )

#define GRID_SIZE_MSN_D1  ( ( ( N_MSN_D1 ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_MSN_D2  ( ( ( N_MSN_D2 ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_FSI     ( ( ( N_FSI ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_STN     ( ( ( N_STN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_GPe     ( ( ( N_GPe ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_GPi     ( ( ( N_GPi ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_SNc     ( ( ( N_SNc ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_PTI     ( ( ( N_PTI ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_PTN     ( ( ( N_PTN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_PSA     ( ( ( N_PSA ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_Th      ( ( ( N_Th  ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_CMPf    ( ( ( N_CMPf ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )   )

//チャネル毎のニューロン数
#define per_chanel_N_MSN_D1 ( 1003L )
#define per_chanel_N_MSN_D2 ( 1003L )
#define per_chanel_N_FSI    (   27L )
#define per_chanel_N_STN    (   38L )
#define per_chanel_N_GPe    (   57L )
#define per_chanel_N_GPi    (   22L )
#define per_chanel_N_SNc    (   20L )
#define per_chanel_N_PTI    (  100L )
#define per_chanel_N_PTN    (  100L )
#define per_chanel_N_PSA    (  100L )
#define per_chanel_N_Th     (  100L )
#define per_chanel_N_CMPf   (  100L )

//細胞腫毎の総ニューロン数
#define N_MSN_D1 ( per_chanel_N_MSN_D1 * N_chanel )
#define N_MSN_D2 ( per_chanel_N_MSN_D2 * N_chanel )
#define N_FSI    (    per_chanel_N_FSI * N_chanel )
#define N_STN    (    per_chanel_N_STN * N_chanel )
#define N_GPe    (    per_chanel_N_GPe * N_chanel )
#define N_GPi    (    per_chanel_N_GPi * N_chanel )
#define N_SNc    (    per_chanel_N_SNc * N_chanel )
#define N_PTI    (    per_chanel_N_PTI * N_chanel )
#define N_PTN    (    per_chanel_N_PTN * N_chanel )
#define N_PSA    (    per_chanel_N_PTN * N_chanel )
#define N_Th     (    per_chanel_N_PTN * N_chanel )
#define N_CMPf   (   per_chanel_N_CMPf * N_chanel )

//チャネル数(最大600)
#define N_chanel ( 20 )

#define N_i      ( 20 )
#define N_select ( 1000 )

//静止時の膜電位Er
#define Er_MSN_D1 ( -82.10 )
#define Er_MSN_D2 ( -82.20 )
#define Er_FSI    ( -68.22 )
#define Er_STN    ( -56.20 )
#define Er_GPe    ( -56.13 )
#define Er_GPi    ( -67.10 )
#define Er_SNc    ( -49.20 )
#define Er_PTN    ( -64.70 )
#define Er_PTI    ( -69.20 )
#define Er_Th     ( -56.70 )

//θ
#define theta_MSN_D1 ( -48.40 )
#define theta_MSN_D2 ( -53.0  )
#define theta_FSI    ( -42.71 )
#define theta_STN    ( -34.60 )
#define theta_GPe    ( -32.80 )
#define theta_GPi    ( -38.80 )
#define theta_SNc    ( -42.90 )
#define theta_PTN    ( -48.80 )
#define theta_PTI    ( -39.20 )
#define theta_Th     ( -37.80 )

//しきい値
#define THETA_MSN_D1 ( theta_MSN_D1 - Er_MSN_D1 )
#define THETA_MSN_D2 ( theta_MSN_D2 - Er_MSN_D2 )
#define THETA_FSI    (    theta_FSI - Er_FSI    )
#define THETA_STN    (    theta_STN - Er_STN    )
#define THETA_GPe    (    theta_GPe - Er_GPe    )
#define THETA_GPi    (    theta_GPi - Er_GPi    )
#define THETA_SNc    (    theta_SNc - Er_SNc    )
#define THETA_PTN    (    theta_PTN - Er_PTN    )
#define THETA_PTI    (    theta_PTI - Er_PTI    )
#define THETA_Th     (    theta_Th  - Er_Th     )

//初期膜電位
#define V_INIT  ( -20. )

//発火率
#define PHI_MIN_PSA     ( 0.00566   )
#define PHI_MAX_PSA     ( 0.046   )
#define PHI_CMPf    ( 0.004   )

//時定数
#define TAU_MSN_D1 (  7.0  )
#define TAU_MSN_D2 (  9.0  )
#define TAU_FSI    (  3.08 )
#define TAU_STN    ( 16.   )
#define TAU_GPe    ( 13.6  )
#define TAU_GPi    ( 52.0  )
#define TAU_SNc    ( 80.6  )
#define TAU_PTN    ( 23.6  )
#define TAU_PTI    (  5.43 )
#define TAU_Th     ( 20.7  )

#define V_REST  ( 0. ) //静止電位
#define V_RESET ( 0. ) //リセット電位

//入力電力
#define Vc_MSN_D1 ( 24.5 / N_MSN_D1 )
#define Vc_MSN_D2 ( 24.5 / N_MSN_D2 )
#define Vc_FSI    (  8.  / N_FSI    )
#define Vc_STN    (  9.5 / N_STN    )
#define Vc_GPe    ( 12.  / N_GPe    )
#define Vc_GPi    ( 11.  / N_GPi    )
#define Vc_SNc    (  6.5            )
#define Vc_PTN    ( 11.5            )
#define Vc_PTI    (  1. / N_PTI     )
#define Vc_Th     ( 10.5            )

//synaptic rise time
#define PSP_AMPA (   5. )
#define PSP_GABA (   5. )
#define PSP_DOPA (   5. )

//% of 投射ニューロン
//postMSND1
#define P_MSND1MSND1 ( 0.07   )
#define P_MSND2MSND1 ( 0.13   )
#define P_FSIMSND1   ( 0.53   )
#define P_STNMSND1   ( 0.0683 )
#define P_GPeMSND1   ( 0.6211 )
#define P_SNcMSND1   ( 0.0115 )
//postMSND2
#define P_MSND1MSND2 ( 0.045  )
#define P_MSND2MSND2 ( 0.23   )
#define P_FSIMSND2   ( 0.36   )
#define P_STNMSND2   ( 0.0683 )
#define P_GPeMSND2   ( 0.6211 )
#define P_SNcMSND2   ( 0.0115 )
//postFSI
#define P_FSIFSI     ( 0.58   )
#define P_STNFSI     ( 0.0683 )
#define P_GPeFSI     ( 0.6211 )
//postSTN
#define P_GPeSTN     ( 0.0145 )
#define P_SNcSTN     ( 0.229  )
//postGPe
#define P_MSND1GPe   ( 0.7036 )
#define P_MSND2GPe   ( 0.7036 )
#define P_STNGPe     ( 0.0379 )
#define P_GPeGPe     ( 0.84   )
#define P_SNcGPe     ( 0.0086 )
//postGPi
#define P_MSND1GPi   ( 0.264  )
#define P_MSND2GPi   ( 0.264  )
#define P_STNGPi     ( 0.5766 )
#define P_GPeGPi     ( 0.3614 )
//postSNc
#define P_MSND1SNc   ( 0.0067 )
#define P_MSND2SNc   ( 0.0067 )

#define P_other      ( 1.000  )

#define FreeRun   ( 100  )
#define T         ( 1000 )
#define DT        ( 1.   )
#define NT        ( 500 )
#define NT_action ( 700 )
#define NT2        ( 1100 )

//冗長性
#define rho ( 3. )

//PSP振幅
//postMSND1
#define W_MSND1MSND1 (  5.       )
#define W_MSND2MSND1 (  5.       )
#define W_FSIMSND1   (  0.25      )
#define W_STNMSND1   (  1.5      )
#define W_GPeMSND1   (  0.25      )
#define W_SNcMSND1   (  5.       )
#define W_PTNMSND1   (  1.4      )
#define W_PSAMSND1   (  1.4      )
#define W_CMPfMSND1  (  0.01   )
//postMSND2
#define W_MSND1MSND2 (  5.      )
#define W_MSND2MSND2 (  5.      )
#define W_FSIMSND2   (  0.25     )
#define W_STNMSND2   (  3.     )
#define W_GPeMSND2   (  0.25      )
#define W_SNcMSND2   (  5.1      )
#define W_PTNMSND2   (  1.7      )
#define W_PSAMSND2   (  1.7      )
#define W_CMPfMSND2  (  0.02  )
//postFSI
#define W_FSIFSI     ( 0.25     )
#define W_STNFSI     ( 2.    )
#define W_GPeFSI     ( 0.2    )
#define W_PTNFSI     ( 1.5   )
#define W_PSAFSI     ( 1.5   )
#define W_CMPfFSI    ( 0.1    )
//postSTN
#define W_GPeSTN     ( 0.2 )
#define W_PTNSTN     ( 0.776 )
#define W_CMPfSTN    ( 0.001 )
//postGPe
#define W_MSND1GPe   ( 0.1 )
#define W_MSND2GPe   ( 0.1 )
#define W_STNGPe     ( 6.  )
#define W_GPeGPe     ( 0.1 )
#define W_CMPfGPe    ( 3.5 )
//postGPi
#define W_MSND1GPi   (  2.   )
#define W_MSND2GPi   (  2.   )
#define W_STNGPi     (  2.5 )
#define W_GPeGPi     (  0.1   )
#define W_CMPfGPi    (  1.   )
//postSNc
#define W_MSND1SNc   ( 0.02 )
#define W_MSND2SNc   ( 0.0175 )
//postPTI
#define W_PTNPTI     ( 0.8 )
//postPTN
#define W_PTIPTN     (  0.51    )
#define W_PSAPTN     (  5.1   )
#define W_ThPTN      (  0.2 )
//postTh
#define W_GPiTh      (  1.05  )
#define W_PTNTh      (  0.31 )

//不応期
#define T_REFR ( 2. )

//遅延
#define DELAY ( 1 )

#define SynapseMSN_D1 ( 0 )
#define SynapseMSN_D2 ( N_MSN_D1 )
#define SynapseFSI    ( N_MSN_D1 + N_MSN_D2 )
#define SynapseSTN    ( N_MSN_D1 + N_MSN_D2 + N_FSI )
#define SynapseGPe    ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN )
#define SynapseGPi    ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe )
#define SynapseSNc    ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi )
#define SynapsePTN    ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc )
#define SynapsePTI    ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTN )
#define SynapsePSA    ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTN + N_PTI )
#define SynapseTh     ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTI + N_PTN + N_PSA )
#define SynapseCMPf   ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTI + N_PTN + N_PSA + N_Th )

//時定数
#define tauAMPA ( exp ( - DT / PSP_AMPA ) )
#define tauGABA ( exp ( - DT / PSP_GABA ) )
#define tauDOPA ( exp ( - DT / PSP_DOPA ) )