/// @file  retail.c
/// @brief ファイルの末尾10行を表示する。
/// @brief オプションでファイルが更新されるたびに末尾10行を表示して、ファイルを監視することができる。
/// @author 林 竜司
/// @date  2024/4/19

#include <stdio.h>
#include <unistd.h>    // ファイルの読み取み・出力・クローズの際に使用
#include <fcntl.h>     // ファイルを開く使用
#include <sys/stat.h>  // ファイルの情報を取得・使用する際に使用
#include <stdbool.h>   // 変更の有無をbool型で判定しているため使用
#include <string.h>    // 入力された文字列の判定で使用

#define BUFFER_SIZE     1024
#define LINES_TO_SHOW     10  //表示させる行数

// モードに関する列挙型
typedef enum enm {
	Descriptor = 0,
	Name
} mode_f;

/// @fn        Output
/// @brief     受け取ったファイルの情報からそのファイルの末尾10行を出力する
/// @param fd  末尾10行を出力させたいファイルのファイルディスクリプタ
/// @param fs  末尾10行を出力させたいファイルの状態
void Output( int fd, struct stat fs ){

	char buf[ BUFFER_SIZE ];
	char rbuf[ 10 ];             // 読み込み用のバッファ
	int bsize = sizeof( rbuf );  // 読み込み用のバッファのサイズ
	int lf_num = 0;              // 現状見つけた改行の数

	// ファイルを読み込み用のバッファのサイズ毎に参照
	for( int i = 0; i <= fs.st_size / bsize; i++ ){
        int size = bsize * ( i + 1 );                  // 読み込む総バイト数
        size = fs.st_size < size ? fs.st_size : size;  // 読み込む総バイト数がファイルサイズを超えていないかの判定。超えていた場合はファイルサイズに変える
        lseek( fd, -size, SEEK_END );                  // 参照位置を末尾からsize分手前にする
		// 読み込む総バイト数から読み込み用のバッファのサイズを割った余りを用いて
		// 読み込む総バイト数が読み込み用のバッファのサイズ大きいかを確認
		// ファイルサイズ以上に読み込もうとするとエラーが出るため
        size = size % bsize;
        size = size > 0 ? size : bsize;
		// 10バイト分読み込み( lenは実際に読み込んだバイト数 )
        int len = read( fd, rbuf, size );
        for( int j = 0; j < len; j++ ){
			// 一文字ずつ改行文字かどうかの判定
            if( rbuf[ len - j - 1 ] == '\n' ){
				// 最初の文字が改行の場合は行として含めないため
                if( !( ( i == 0 ) && ( j == 0 ) ) ){
                    lf_num++;
                }
				// 10行分の改行文字を見つけたかどうか
                if( lf_num == LINES_TO_SHOW ){
					size = bsize * i + j;          // 最後の改行文字を見つけるまでのバイト数
					lseek( fd, -size, SEEK_END );  // 参照位置を末尾から最後の改行文字までのバイト数分ずらす
					len = read( fd, buf, size );   // サイズ分読み込む
					write( 1, buf, len );          // 読み込んだものを出力
				}
           	}
       	}
		// ファイルの中身が10行より少ない場合
		if( ( ( i == fs.st_size / bsize ) && ( lf_num < LINES_TO_SHOW ) )){
			size = bsize * i + len;          // 最後の改行文字を見つけるまでのバイト数
			lseek( fd, -size, SEEK_END );  // 参照位置を末尾から最後の改行文字までのバイト数分ずらす
			len = read( fd, buf, size );   // サイズ分読み込む
			write( 1, buf, len );          // 読み込んだものを出力
		}
	}
}

/// @fn         GetOneLine
/// @brief      受け取ったファイルの情報からそのファイルの末尾1行を読み込む
/// @param fd   末尾を読み込みたいファイルのファイルディスクリプタ
/// @param fs   末尾を読み込みたいファイルの状態
/// @param tmp  読み込んだ末尾一行を格納するポインタ
int GetOneLine( int fd, struct stat fs, char tmp[] ){

	char rbuf[ 10 ];             // 読み込み用のバッファ
	int bsize = sizeof( rbuf );  // 読み込み用のバッファのサイズ

	// 読み込み用のバッファのサイズ
	for( int i = 0; i <= fs.st_size / bsize; i++ ){
        int size = bsize * ( i + 1 );                  // 読み込む総バイト数
        size = fs.st_size < size ? fs.st_size : size;  // 読み込む総バイト数がファイルサイズを超えていないかの判定。超えていた場合はファイルサイズに変える
        lseek( fd, -size, SEEK_END );                  // 参照位置を末尾からsize分手前にする
		// 読み込む総バイト数から読み込み用のバッファのサイズを割った余りを用いて
		// 読み込む総バイト数が読み込み用のバッファのサイズ大きいかを確認
		// ファイルサイズ以上に読み込もうとするとエラーが出るため
        size = size % bsize;
        size = size > 0 ? size : bsize;
		// 10バイト分読み込み( lenは実際に読み込んだバイト数 )
        int len = read( fd, rbuf, size );
        for( int j = 0; j < len; j++ ){
			// 一文字ずつ改行文字かどうかの判定（最初の文字が改行の場合は行として含めない）
        	if( rbuf[ len - j - 1 ] == '\n' && !( ( i == 0 ) && ( j == 0 ) ) ){
				size = bsize * i + j;          // 最後の改行文字を見つけるまでのバイト数
				lseek( fd, -size, SEEK_END );  // 参照位置を末尾から最後の改行文字までのバイト数分ずらす
				len = read( fd, tmp, size );   // サイズ分読み込む
				return 0;
			}
        }
    }
	return 1;
}

/// @fn               JudgeChange
/// @brief            受け取ったファイルの情報からそのファイルに変更があったかを判定する
/// @param fd         判定したいファイルのファイルディスクリプタ
/// @param buf        前回の判定の時の末尾一行の文字列
/// @param fs         判定したいファイルの現在の状態
/// @param before_fs  前回の判定の時のファイルの状態
/// @return           変更があった場合にtrue、なかったらfalseを返す
bool JudgeChange( int fd, char *buf, struct stat fs, struct stat before_fs ){

	char tmp[ BUFFER_SIZE ];  // 判定したいファイルの末尾一行を格納するための仮ポインタ

	// 変更があったかの確認
    if ( fs.st_size != before_fs.st_size || fs.st_mtime != before_fs.st_mtime ){

		// ファイルの末尾一行を取得
		GetOneLine( fd, fs, tmp );

		// 末尾一行が前回と変わっていないか
		if( strcmp( buf, tmp ) != 0 ){
			// ファイルサイズが増えていないか
			if ( fs.st_size <= before_fs.st_size ) {
				// 末尾が違い、ファイルのサイズが増えていない場合は減分があったことがわかるためメッセージの出力
				printf( "changes to the file except at the end\n" );
			}
			strcpy( buf, tmp );  // 前回の文を更新
		}else{
			// ファイルの変更があり、末尾が同じ場合は末尾以外で変更があったことがわかるためメッセージの出力
			printf( "changes to the file except at the end\n" );
		}
		return true;
	}else{
		return false;
	}
}

/// @fn          main
/// @brief       メイン関数
/// @param argc  コマンドライン引数の数
/// @param argv  コマンドライン引数のそれぞれの文字列
/// @return      プログラムの終了コード(0: 正常、1: エラー)
int main( int argc, char **argv ){

	int fd;                 // 参照したいファイルのファイルディスクリプタ
	struct stat fs;         // 参照したいファイルの状態
	struct stat before_fs;  // 変更の有無の判定の際に用いる前のファイルの状態
	char buf[BUFFER_SIZE];  // 変更の有無の判定の際に用いる前のファイルの末尾一行

	// -fがない場合
	if( argc == 2 ){
		// ファイルが存在しアクセスできるか
        if( access( argv[ 1 ], R_OK ) == -1 ){
            fprintf( stderr, "No such file\n" );  // エラーメッセージを表示
            return 1;                             // エラーによる終了
        }
		// ファイルが開けるか
        if( ( fd = open( argv[ 1 ], O_RDONLY ) ) == -1 ){
            fprintf( stderr, "Error opening file\n" );  // エラーメッセージを表示
            return 1;                                   // エラーによる終了
        }
		fstat( fd, &fs );  // ファイルの状態を取得
		Output( fd, fs );  // 末尾10行を表示
    }else if( argc == 3 ){  // -fある場合

		int mode = Descriptor;               // モードの判定(nameかdescriptor、デフォルトはdescriptor)

		// コマンドライン引数でのエラーがないかとモードの確認
		if( strcmp( argv[ 1 ], "-f" ) != 0 && strcmp( argv[ 1 ], "-f=descriptor" ) != 0 && strcmp( argv[ 1 ], "-f=name" ) != 0 ){
			// 標準エラー出力にエラーと使い方を表示
			fprintf( stderr, "ERROR\n" );
			fprintf( stderr, "使い方: %s [オプション] <FILE> \n", argv[ 0 ] );
			fprintf( stderr, "オプション: -f{=name|=descriptor}\n" );
			fprintf( stderr, "FILE: ファイル名またはパス\n" );
			fprintf( stderr, "ファイルから末尾10行までを表示します。オプションがある場合にはファイルを監視します。\n");
			return 1;  // エラーによる終了
		}else if( strcmp( argv[ 1 ], "-f=name" ) == 0 ){
			mode = Name;
		}

        // ファイルが存在しアクセスできるか
		if( access( argv[ 2 ], R_OK ) == -1 ){
            fprintf( stderr, "No such file\n" );    // エラーメッセージを表示
			return 1;                               // エラーによる終了
        }
		// ファイルが開けるか
        if( ( fd = open( argv[ 2 ], O_RDONLY ) ) == -1 ){
            fprintf( stderr, "Error opening file\n" );    // エラーメッセージを表示
            return 1;                                     // エラーによる終了
        }
		fstat( fd, &before_fs );    // ファイルの状態を取得し、前のファイル状態として記録
		GetOneLine( fd, fs, buf );  // 末尾10行を表示
		for( ; ; ) {
			fstat( fd, &fs );  // ファイルの状態を取得
			// 変更があったかの確認
			if( JudgeChange( fd, buf, fs, before_fs ) ){
				// あった場合は末尾10行を出力し、前のファイル状態を更新
				Output( fd, fs );
				before_fs = fs;
			}
			// オプションにおけるモードの確認
			if( mode == Name ){
				// ファイルを一度クローズして再度オープン
				// オープンできない場合はメッセージを出力し、終了
				close( fd );
				if( ( fd = open( argv[ 2 ], O_RDONLY ) ) == -1 ){
            		fprintf( stdout, "file has been renamed or deleted\n" );
            		return 0;
				}
        	}
			// 変更の確認を繰り返し行う際にそれぞれ1秒開ける
			sleep( 1 );
		}
	}else{  // コマンドライン引数でのエラーがないかの確認
		// 標準エラー出力にエラーと使い方を表示
		fprintf( stderr, "ERROR\n" );
		fprintf( stderr, "使い方: %s [オプション] <FILE> \n", argv[ 0 ] );
		fprintf( stderr, "オプション:-f{=name|=descriptor}\n" );
		fprintf( stderr, "<FILE>:ファイル名またはパス\n" );
		fprintf( stderr, "ファイルから末尾10行までを表示します。オプションがある場合にはファイルを監視します。\n");
        return 1;
    }
	close( fd );  // ファイルをクローズする
	return 0;
}