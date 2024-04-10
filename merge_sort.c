#include<stdio.h>
#include <stdlib.h>
#include <time.h>

void merge( int array[], int leftmost, int middle, int rightmost ){

	int work[ rightmost - leftmost + 1 ];
	int position_left = 0;
	int position_right = rightmost - leftmost;

	for ( int i = middle; i >= leftmost; i-- ){
		work[ i - leftmost ] = array[ i ];
	} // 左半分
    for ( int i = middle + 1; i <= rightmost; i++ ){
    	work[ rightmost - ( i - ( middle + 1 ) ) - leftmost ] = array[ i ]; // 右半分を逆順
    }
    for ( int i = leftmost; i <= rightmost; i++ ){
    	if ( work[ position_left ] < work[ position_right ]){
			array[ i ] = work[ position_left++ ];
		}
    	else{
			array[ i ] = work[ position_right-- ];
		}
    }
}

/* マージソート */
void merge_sort ( int array[], int leftmost, int rightmost ) {

  if ( leftmost < rightmost ){
	int i, j , k;
	int work[100];
    int middle = ( leftmost + rightmost ) / 2; // 真ん中
    merge_sort( array, leftmost, middle );  // 左を整列
    merge_sort( array, middle + 1, rightmost );  // 右を整列
	merge( array, leftmost, middle, rightmost );
  }
}

int main (void) {
  int array[100] = { 0 };
  int i, j;
  int min = 1;
  int range = 100;

  srand((unsigned)time(NULL));

  for( i = 0; i < 100; i++ ){
    do{
      // 乱数生成
      array[i] = rand() % range + min;
      // 生成済みデータと比較
      for ( j = 0; j < i; j++){
        // 生成済みデータに含まれる場合再度乱数生成
        if (array[i] == array[j]) break;
      }
    } while (i != j);
  }

  for (i = 0; i < 100; i++) { printf("%d ", array[i]); }
  printf("\n");

  merge_sort(array, 0, 99);

  for (i = 0; i < 50; i++) { printf("%d ", array[i]); }
  printf("\n");
  for (i = 50; i < 100; i++) { printf("%d ", array[i]); }
  printf("\n");

  return 0;
}
