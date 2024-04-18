#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <string.h>   // 入力された文字列の判定で使用

#define BUFFER_SIZE 1024

void Output( int fd, struct stat fs ){

	char buf[ BUFFER_SIZE ];
	char rbuf[ 10 ];
	int bsize = sizeof(rbuf);
	int lf_num = 0;
	int req_lines = 10;

	for( int i = 0; i <= fs.st_size / bsize; i++ ){
        int size = bsize * ( i + 1 );
        size = fs.st_size < size ? fs.st_size : size;
        lseek( fd, -size, SEEK_END );
        size = size % bsize;
        size = size > 0 ? size : bsize;
        int len = read( fd, rbuf, size );
        for( int j = 0; j < len; j++ ){
            if( rbuf[ len - j - 1 ] == '\n' ){
                if( !( ( i == 0 ) && ( j == 0 ) ) ){
                    lf_num++;
                }
                if( lf_num == req_lines ){
					size = bsize * i + j;
					lseek( fd, -size, SEEK_END );
					len = read( fd, buf, size );
					write( 1, buf, len );
				}
           	}
       	}
	}
}

int GetOneLine( int fd, struct stat fs, char tmp[] ){

	char rbuf[ 10 ];
	int bsize = sizeof( rbuf );

	for( int i = 0; i <= fs.st_size / bsize; i++ ){
        int size = bsize * ( i + 1 );
        size = fs.st_size < size ? fs.st_size : size;
        lseek( fd, -size, SEEK_END );
        size = size % bsize;
        size = size > 0 ? size : bsize;
        int len = read( fd, rbuf, size );
        for( int j = 0; j < len; j++ ){
        	if( rbuf[ len - j - 1 ] == '\n' && !( ( i == 0 ) && ( j == 0 ) ) ){
				size = bsize * i + j;
				lseek( fd, -size, SEEK_END );
				len = read( fd, tmp, size );
				return 0;
			}
        }
    }
	return 1;
}

bool JudgeChange( int fd, char *buf, struct stat fs, struct stat before_fs ){

	int n;
	char tmp[ BUFFER_SIZE ];

	// 変更があったかの確認
    if ( fs.st_size != before_fs.st_size || fs.st_mtime != before_fs.st_mtime ){

		GetOneLine( fd, fs, tmp );

		printf("tmp:%s\n",tmp);
		printf("buf:%s\n",buf);
		if( strcmp( buf, tmp ) != 0 ){
			if ( fs.st_size <= before_fs.st_size ) {
				printf( "1changes to the file except at the end\n" );
			}
			strcpy( buf, tmp );
			printf("%s\n",buf);
		}
		else if( strcmp( buf, tmp ) == 0 ){
			printf( "2changes to the file except at the end\n" );
		}
		return true;
	}
	else return false;
}

int main( int argc, char **argv ){

	int fd;
	struct stat fs;
	struct stat before_fs;
	int n;
	char buf[BUFFER_SIZE];
    ssize_t bytes_read;
    ssize_t total_bytes_read = 0;

	// -fなし
	if( argc == 2 ){
        if( access( argv[ 1 ], R_OK ) == -1 ){
            fprintf( stderr, "No such file\n" );
            return 1;
        }
        if( ( fd = open( argv[ 1 ], O_RDONLY ) ) == -1 ){
            fprintf( stderr, "Error opening file\n" );
            return 1;
        }
		fstat( fd, &fs );
		Output( fd, fs );
    }
	// -fあり
    else if( argc == 3 ){

		if( strcmp( argv[ 1 ], "-f" ) != 0 && strcmp( argv[ 1 ], "-f=descriptor" ) != 0 && strcmp( argv[ 1 ], "-f=name" ) != 0 ){
			fprintf( stderr, "ERROR\n" );
			fprintf( stderr, "使い方: %s [オプション] <FILE> \n", argv[ 0 ] );
			fprintf( stderr, "オプション: -f{=name|=descriptor}\n" );
			fprintf( stderr, "FILE: ファイル名またはパス\n" );
			fprintf( stderr, "ファイルから末尾10行までを表示します。オプションがある場合にはファイルを監視します。\n");
			return 1;
		}

        if( access( argv[ 2 ], R_OK ) == -1 ){
            fprintf( stderr, "No such file\n" );
			return 1;
        }
        if( ( fd = open( argv[ 2 ], O_RDONLY ) ) == -1 ){
            fprintf( stderr, "Error opening file\n" );
            return 1;
        }
		fstat( fd, &fs );
		fstat( fd, &before_fs );
		GetOneLine( fd, fs, buf );
		for (;;) {
			fstat( fd, &fs );
			if( JudgeChange( fd, buf, fs, before_fs ) ){
				Output( fd, fs );
				before_fs = fs;
			}
			sleep( 1 );
			if( strcmp( argv[ 1 ], "-f=name" ) == 0 ){
				close( fd );
				if( ( fd = open( argv[ 2 ], O_RDONLY ) ) == -1 ){
            		fprintf( stdout, "file has been renamed or deleted\n" );
            		return 0;
				}
        	}
		}
	}
    else{
		// 標準エラー出力にエラー理由と使い方を表示
		fprintf( stderr, "ERROR\n" );
		fprintf( stderr, "使い方: %s [オプション] <FILE> \n", argv[ 0 ] );
		fprintf( stderr, "オプション:-f{=name|=descriptor}\n" );
		fprintf( stderr, "<FILE>:ファイル名またはパス\n" );
		fprintf( stderr, "ファイルから末尾10行までを表示します。オプションがある場合にはファイルを監視します。\n");
        return 1;
    }
	close( fd );
	return 0;
}