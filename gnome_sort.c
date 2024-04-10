#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM 100

void gnome_sort(int array[])
{

	int tmp = 0;
	int number_index = 0;
	while ( number_index < NUM )
	{

		if ( number_index == 0 )
			number_index++;

		if (array[ number_index ] < array[ number_index - 1 ])
		{
			tmp = array[ number_index ];
			array[ number_index ] = array[ number_index - 1 ];
			array[ number_index - 1 ] = tmp;
			number_index--;
		}
		else
			number_index++;
	}
}

int main(void)
{
	int array[NUM] = {0};
	int i, j;
	int min = 1;
	int range = NUM;

	srand((unsigned)time(NULL));

	for (i = 0; i < NUM; i++)
	{
		do
		{
			// 乱数生成
			array[i] = rand() % range + min;
			// 生成済みデータと比較
			for (j = 0; j < i; j++)
			{
				// 生成済みデータに含まれる場合再度乱数生成
				if (array[i] == array[j])
					break;
			}
		} while (i != j);
	}

	for (i = 0; i < NUM; i++)
	{
		printf("%d ", array[i]);
	}
	printf("\n");

	gnome_sort(array);

	for (i = 0; i < 50; i++)
	{
		printf("%d ", array[i]);
	}
	printf("\n");
	for (i = 50; i < NUM; i++)
	{
		printf("%d ", array[i]);
	}
	printf("\n");

	return 0;
}
