#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

// ニューロンについて発火の総数をニューロン数で割り、平均発火率を計算し標準出力する関数
void outputFiringRate ( neuron_t *n_GPi ){

    float mean = 0;

    //GPi
     mean = 0;
    for ( int i = per_chanel_N_GPi * 9; i < per_chanel_N_GPi * 10; i++ ){
    mean += n_GPi -> counter[ i ];
    }
    mean = mean / per_chanel_N_GPi;
    fprintf ( n_GPi -> file1, "%f\n", mean );
    mean = 0;
    for ( int i = per_chanel_N_GPi * 10; i < per_chanel_N_GPi * 11; i++ ){
    mean += n_GPi -> counter[ i ];
    }
    mean = mean / per_chanel_N_GPi;
    fprintf ( n_GPi -> file2, "%f\n", mean );
}