#include <math.h>
#include <stdlib.h>

// 1ブロックあたりのスレッド数
#define BLOCK_SIZE          (   32        )

// GPUで並列化する際の各ニューロンの必要なブロック数
#define GRID_SIZE_MSN_D1    ( ( ( N_MSN_D1 ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_MSN_D2    ( ( ( N_MSN_D2 ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE ) )
#define GRID_SIZE_FSI       ( ( ( N_FSI ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_STN       ( ( ( N_STN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_GPe       ( ( ( N_GPe ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_GPi       ( ( ( N_GPi ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_SNc       ( ( ( N_SNc ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_PTI       ( ( ( N_PTI ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_PTN       ( ( ( N_PTN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_PSN       ( ( ( N_PSN ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_Th        ( ( ( N_Th  ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )    )
#define GRID_SIZE_CMPf      ( ( ( N_CMPf ) + ( BLOCK_SIZE ) - 1 ) / ( BLOCK_SIZE )   )

// chanel(選択肢)毎のニューロン数
#define per_chanel_N_MSN_D1 ( 1003L       )
#define per_chanel_N_MSN_D2 ( 1003L       )
#define per_chanel_N_FSI    (   27L       )
#define per_chanel_N_STN    (   38L       )
#define per_chanel_N_GPe    (   57L       )
#define per_chanel_N_GPi    (   22L       )
#define per_chanel_N_SNc    (   20L       )
#define per_chanel_N_PTI    (  100L       )
#define per_chanel_N_PTN    (  100L       )
#define per_chanel_N_PSN    (  100L       )
#define per_chanel_N_Th     (  100L       )
#define per_chanel_N_CMPf   (  100L       )

//chanel(選択肢)数(最大600)
#define N_chanel            (   20        )

// 変化させる発火率の尺度(入力のニューロンの最大の発火率と最小の発火率の間を何等分するか)
#define N_change            (   20        )

// 発火率を変化させる入力のニューロンの数
#define N_select            ( 1000        )

// 各ニューロンの毎の総数
#define N_MSN_D1            ( per_chanel_N_MSN_D1 * N_chanel )
#define N_MSN_D2            ( per_chanel_N_MSN_D2 * N_chanel )
#define N_FSI               (    per_chanel_N_FSI * N_chanel )
#define N_STN               (    per_chanel_N_STN * N_chanel )
#define N_GPe               (    per_chanel_N_GPe * N_chanel )
#define N_GPi               (    per_chanel_N_GPi * N_chanel )
#define N_SNc               (    per_chanel_N_SNc * N_chanel )
#define N_PTI               (    per_chanel_N_PTI * N_chanel )
#define N_PTN               (    per_chanel_N_PTN * N_chanel )
#define N_PSN               (    per_chanel_N_PTN * N_chanel )
#define N_Th                (    per_chanel_N_PTN * N_chanel )
#define N_CMPf              (   per_chanel_N_CMPf * N_chanel )

// 各ニューロンの静止時の膜電位Er
#define Er_MSN_D1           (  -82.10     )
#define Er_MSN_D2           (  -82.20     )
#define Er_FSI              (  -68.22     )
#define Er_STN              (  -56.20     )
#define Er_GPe              (  -56.13     )
#define Er_GPi              (  -67.10     )
#define Er_SNc              (  -49.20     )
#define Er_PTN              (  -64.70     )
#define Er_PTI              (  -69.20     )
#define Er_Th               (  -56.70     )

// 各ニューロンの発火しきい値
#define THETA_MSN_D1        (  -48.40     )
#define THETA_MSN_D2        (  -53.0      )
#define THETA_FSI           (  -42.71     )
#define THETA_STN           (  -34.60     )
#define THETA_GPe           (  -32.80     )
#define THETA_GPi           (  -38.80     )
#define THETA_SNc           (  -42.90     )
#define THETA_PTN           (  -48.80     )
#define THETA_PTI           (  -39.20     )
#define THETA_Th            (  -37.80     )

// 各ニューロンの発火率(ポアソンモデル)
#define PHI_MIN_PSN         (    0.00566  )     //最小値
#define PHI_MAX_PSN         (    0.046    )     //最大値
#define PHI_CMPf            (    0.004    )

// 各ニューロンの入力の発火率の増加度合い
#define chanel1             (    0        )
#define chanel2             (    0        )
#define chanel3             (    0        )
#define chanel4             (    0        )
#define chanel5             (    0        )
#define chanel6             (    0        )
#define chanel7             (    0        )
#define chanel8             (    0        )
#define chanel9             (    0        )
#define chanel10            (   10        )
#define chanel11            (   10        )
#define chanel12            (    0        )
#define chanel13            (    0        )
#define chanel14            (    0        )
#define chanel15            (    0        )
#define chanel16            (    0        )
#define chanel17            (    0        )
#define chanel18            (    0        )
#define chanel19            (    0        )
#define chanel20            (    0        )

// 各ニューロンの膜時定数
#define TAU_MSN_D1          (    7.0      )
#define TAU_MSN_D2          (    9.0      )
#define TAU_FSI             (    3.08     )
#define TAU_STN             (   16.       )
#define TAU_GPe             (   13.6      )
#define TAU_GPi             (   52.0      )
#define TAU_SNc             (   80.6      )
#define TAU_PTN             (   23.6      )
#define TAU_PTI             (    5.43     )
#define TAU_Th              (   20.7      )

// シナプス後電位リセット用
#define PSP_RESET           (    0.       )

// 各ニューロンの定数の入力電力(シミュレーションで考慮されていない脳内の化学物質が原因の電位等)
#define Vc_MSN_D1           (   12.5      )
#define Vc_MSN_D2           (   12.5      )
#define Vc_FSI              (    8.       )
#define Vc_STN              (    3.5      )
#define Vc_GPe              (   12.       )
#define Vc_GPi              (   11.       )
#define Vc_SNc              (    6.5      )
#define Vc_PTN              (    5.       )
#define Vc_PTI              (    0.1      )
#define Vc_Th               (    0.5      )

// 各神経伝達物質のときのシナプス後電位の減衰時間
#define PSP_AMPA            (    5.       )
#define PSP_NMDA            (  100.       )
#define PSP_GABA            (    5.       )
#define PSP_DOPA            (    5.       )

// 各神経伝達物質のときのシナプス時定数
#define tauAMPA             ( exp ( - DT / PSP_AMPA ) )
#define tauNMDA             ( exp ( - DT / PSP_NMDA ) )
#define tauGABA             ( exp ( - DT / PSP_GABA ) )
#define tauDOPA             ( exp ( - DT / PSP_DOPA ) )

// シナプス結合の投射確率(%/100)
#define P_MSND1MSND1        (    0.07     )    // D1受容体を発現するMSNからD1受容体を発現するMSNへの結合の投射確率
#define P_MSND2MSND1        (    0.13     )    // D2受容体を発現するMSNからD1受容体を発現するMSNへの結合の投射確率
#define P_FSIMSND1          (    0.53     )    // FSIからD1受容体を発現するMSNへの結合の投射確率
#define P_STNMSND1          (    0.0683   )    // STNからD1受容体を発現するMSNへの結合の投射確率
#define P_GPeMSND1          (    0.6211   )    // GPeからD1受容体を発現するMSNへの結合の投射確率
#define P_SNcMSND1          (    0.0115   )    // SNcからD1受容体を発現するMSNへの結合の投射確率
#define P_MSND1MSND2        (    0.045    )    // D1受容体を発現するMSNからD2受容体を発現するMSNへの結合の投射確率
#define P_MSND2MSND2        (    0.23     )    // D2受容体を発現するMSNからD2受容体を発現するMSNへの結合の投射確率
#define P_FSIMSND2          (    0.36     )    // FSIからD2容体を発現するMSNへの結合の投射確率
#define P_STNMSND2          (    0.0683   )    // STNからD2容体を発現するMSNへの結合の投射確率
#define P_GPeMSND2          (    0.6211   )    // GPeからD2容体を発現するMSNへの結合の投射確率
#define P_SNcMSND2          (    0.0115   )    // SNcからD2容体を発現するMSNへの結合の投射確率
#define P_FSIFSI            (    0.58     )    // FSIからFSIへの結合の投射確率
#define P_STNFSI            (    0.0683   )    // STNからFSIへの結合の投射確率
#define P_GPeFSI            (    0.6211   )    // GPeからFSIへの結合の投射確率
#define P_GPeSTN            (    0.0145   )    // STNからSTNへの結合の投射確率
#define P_MSND1GPe          (    0.7036   )    // D1受容体を発現するMSNからGPeへの結合の投射確率
#define P_MSND2GPe          (    0.7036   )    // D2受容体を発現するMSNからGPeへの結合の投射確率
#define P_STNGPe            (    0.0379   )    // STNからGPeへの結合の投射確率
#define P_GPeGPe            (    0.84     )    // GPeからGPeへの結合の投射確率
#define P_MSND1GPi          (    0.264    )    // D1受容体を発現するMSNからGPiへの結合の投射確率
#define P_MSND2GPi          (    0.264    )    // D2受容体を発現するMSNからGPiへの結合の投射確率
#define P_STNGPi            (    0.5766   )    // STNからGPiへの結合の投射確率
#define P_GPeGPi            (    0.3614   )    // GPeからGPiへの結合の投射確率
#define P_MSND1SNc          (    0.0067   )    // D1受容体を発現するMSNからSNcへの結合の投射確率
#define P_MSND2SNc          (    0.0067   )    // D2受容体を発現するMSNからSNcへの結合の投射確率
#define P_other             (    1.000    )    // その他の結合の結合確率

// シミュレーション時間
#define FreeRun             (  100        )    // 初期化時のランダム性から影響を受けないようにするためのフリーランの時間(0~100ms)
#define T                   ( 1000        )    // シミュレーション時間
#define DT                  (    1.       )    // 単位時間
#define NT                  (  500        )    // フリーラン後から行動選択のために発火率を変化させる手前までの時間(101~500ms)
#define NT_action           (  700        )    // 行動選択のために発火率を変化させる時間(501ms~700ms)
#define NT2                 ( 1100        )    // 発火率を変化させてからもとに戻したときの時間(701ms~1100ms)

// 一つの結合においてシナプスが複数存在するような冗長性
#define rho                 (    3.       )

// 各神経伝達物質のときのシナプス後電位の振幅
#define PSP_amplitudes_AMPA (    1.0      )
#define PSP_amplitudes_GABA (    0.25     )
#define PSP_amplitudes_NMDA (    0.025    )
#define PSP_amplitudes_DOPA (    0.25     )

// 各神経伝達物質のときの反転電位
#define rev_potential_AMPA  (    0.       )
#define rev_potential_GABA  (  -70.       )
#define rev_potential_NMDA  (    0.       )
#define rev_potential_DOPA  (    0.       )

//各結合の各神経伝達物質のときのシナプス荷重
#define W_MSND1MSND1        (    0.01     )
#define W_MSND2MSND1        (    0.01     )
#define W_FSIMSND1          (    0.009    )
#define W_STNMSND1_AMPA     (    0.005    )
#define W_STNMSND1_NMDA     (    0.005    )
#define W_GPeMSND1          (    0.01     )
#define W_SNcMSND1          (    0.001    )
#define W_PTNMSND1_AMPA     (    0.0037   )
#define W_PTNMSND1_NMDA     (    0.0037   )
#define W_PSNMSND1_AMPA     (    0.0036   )
#define W_PSNMSND1_NMDA     (    0.0036   )
#define W_CMPfMSND1_AMPA    (    0.001    )
#define W_CMPfMSND1_NMDA    (    0.001    )
#define W_MSND1MSND2        (    0.01     )
#define W_MSND2MSND2        (    0.01     )
#define W_FSIMSND2          (    0.01     )
#define W_STNMSND2_AMPA     (    0.002    )
#define W_STNMSND2_NMDA     (    0.002    )
#define W_GPeMSND2          (    0.01     )
#define W_SNcMSND2          (    0.001    )
#define W_PTNMSND2_AMPA     (    0.00285  )
#define W_PTNMSND2_NMDA     (    0.0028   )
#define W_PSNMSND2_AMPA     (    0.0028   )
#define W_PSNMSND2_NMDA     (    0.0028   )
#define W_CMPfMSND2_AMPA    (    0.001    )
#define W_CMPfMSND2_NMDA    (    0.001    )
#define W_FSIFSI            (    0.003    )
#define W_STNFSI_AMPA       (    0.0075   )
#define W_STNFSI_NMDA       (    0.0075   )
#define W_GPeFSI            (    0.001    )
#define W_PTNFSI_AMPA       (    0.002    )
#define W_PTNFSI_NMDA       (    0.002    )
#define W_PSNFSI_AMPA       (    0.002    )
#define W_PSNFSI_NMDA       (    0.002    )
#define W_CMPfFSI_AMPA      (    0.001    )
#define W_CMPfFSI_NMDA      (    0.001    )
#define W_GPeSTN            (    0.0025   )
#define W_PTNSTN_AMPA       (    0.01     )
#define W_PTNSTN_NMDA       (    0.01     )
#define W_CMPfSTN_AMPA      (    0.00012  )
#define W_CMPfSTN_NMDA      (    0.00012  )
#define W_MSND1GPe          (    0.0005   )
#define W_MSND2GPe          (    0.0005   )
#define W_STNGPe_AMPA       (    0.05     )
#define W_STNGPe_NMDA       (    0.05     )
#define W_GPeGPe            (    0.0005   )
#define W_CMPfGPe_AMPA      (    0.002    )
#define W_CMPfGPe_NMDA      (    0.002    )
#define W_MSND1GPi          (    0.05     )
#define W_MSND2GPi          (    0.05     )
#define W_STNGPi_AMPA       (    0.008    )
#define W_STNGPi_NMDA       (    0.008    )
#define W_GPeGPi            (    0.002    )
#define W_CMPfGPi_AMPA      (    0.005    )
#define W_CMPfGPi_NMDA      (    0.005    )
#define W_MSND1SNc          (    0.003    )
#define W_MSND2SNc          (    0.003    )
#define W_PTNPTI_AMPA       (    0.008    )
#define W_PTNPTI_NMDA       (    0.008    )
#define W_PTIPTN            (    0.00033  )
#define W_PSNPTN_AMPA       (    0.01467  )
#define W_PSNPTN_NMDA       (    0.01467  )
#define W_ThPTN_AMPA        (    0.001    )
#define W_ThPTN_NMDA        (    0.001    )
#define W_GPiTh             (    0.005    )
#define W_PTNTh_AMPA        (    0.0069   )
#define W_PTNTh_NMDA        (    0.0069   )

// ニューロンの不応期(ニューロンが発火したあと反応しない時間)
#define T_REFR              (    2.       )

// シナプスの遅延(ニューロンが発火し信号を送ってから届くまでのラグ)
#define DELAY               (    1.       )

// 計算するときなどのシナプスとニューロン番号のズレの調整
#define SynapseMSN_D1       (                                                                                          0 )
#define SynapseMSN_D2       (                                                                                   N_MSN_D1 )
#define SynapseFSI          (                                                                        N_MSN_D1 + N_MSN_D2 )
#define SynapseSTN          (                                                                N_MSN_D1 + N_MSN_D2 + N_FSI )
#define SynapseGPe          (                                                        N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN )
#define SynapseGPi          (                                                N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe )
#define SynapseSNc          (                                        N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi )
#define SynapsePTN          (                                N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc )
#define SynapsePTI          (                        N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTN )
#define SynapsePSN          (                N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTN + N_PTI )
#define SynapseTh           (        N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTI + N_PTN + N_PSN )
#define SynapseCMPf         ( N_MSN_D1 + N_MSN_D2 + N_FSI + N_STN + N_GPe + N_GPi + N_SNc + N_PTI + N_PTN + N_PSN + N_Th )