/* CH32F4P6マイクロコントローラのメモリレイアウト */
/* 1K = 1 KiBi = 1024バイト */
PROVIDE(_hart_stack_size = 1K);
MEMORY
{
	/* FLASH領域の開始位置と長さの定義 */
	FLASH(rx):	ORIGIN = 0x00000000, LENGTH = 16K
	/* RAM領域の開始位置と長さの定義 */
	RAM(rwx)	:	ORIGIN = 0x20000000, LENGTH = 2K
}

REGION_ALIAS("REGION_TEXT", FLASH);
REGION_ALIAS("REGION_RODATA", FLASH);
REGION_ALIAS("REGION_DATA", RAM);
REGION_ALIAS("REGION_BSS", RAM);
REGION_ALIAS("REGION_HEAP", RAM);
REGION_ALIAS("REGION_STACK", RAM);

/* エントリポイントをResetに設定
ENTRY(Reset);

/* 外部で定義したRESET_VECTORの宣言 */
/* EXTERN(RESET_VECTOR);

SECTIONS
{ */
	/* vector_tableセクションの定義 */
	/* FLASH領域に配置する */
	/* .vector_table ORIGIN(FLASH) :
	{ */
		/* 1つ目のエントリ。スタックポインタの初期値 */
		/* 一時的に使用する自動変数はスタックポインタから順に領域が確保される */
		/* RAM領域の末尾をとりあえず開始位置とする */
		/* LONG(ORIGIN(RAM) + LENGTH(RAM)); */

		/* 2つ目のエントリ。リセットベクタ */
		/* ベクターテーブルの最初の位置にRESET_VECTORのセクションを配置する */
		/* KEEPはリンク時に省略させない意味 */
		/* 最初のアスタリスクは全てのオブジェクトファイルのセクションを対象とする意味 */
		/* ()内にはリンク時にリンクするセクション名を列挙する */
		/* セクション名の末尾の*はワイルドカード */
		/* 中括弧の外の.vector_tableは最終的に生成するセクションの名前を表すため、 リンク対象のセクションとは関係ない*/
		/* KEEP(*(.vector_table.reset_vector));
	} > FLASH */

	/* textセクションの定義 */
	/* textセクションは実行コードを配置する領域 */
	/* FLASH領域に配置する */
	/* .text :
	{
		/* テキスト領域の最初の位置にtextのセクションを配置する */
		/* *(.text .text.*);
	} > FLASH */ 

	/* rodataセクションの定義 */
	/* rodataセクションは定数などリードオンリーのデータを配置する領域 */
	/* FLASH領域に配置する */
	/* .rodata :
	{
		*(.rodata .rodata.*);
	} > FLASH */

	/* dataセクションの定義 */
	/* dataセクションは初期値ありのグローバル変数など、値の初期化が必要なデータを配置する領域 */
	/* RAM領域に配置する */
	/* .data :
	{
		*(.data .data.*);
	} > RAM */


	/* bssセクションの定義 */
	/* bssセクションは初期値なしのグローバル変数など、値の初期化が不要なデータを配置する領域 */
	/* 初期値は0で埋められることが多い */
	/* RAM領域に配置する */
	/* .bss :
	{
		*(.bss .bss.*);
	} > RAM */

	/* heapセクションの定義 */
	/* heapセクションはアプリケーション側で動的に確保・開放するデータを配置する領域 */
	/* RAM領域に配置する */
	/* .heap :
	{
		*(.heap .heap.*);
	} > RAM */

/* }  */