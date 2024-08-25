### 3.6.3
アトミックなPMAは、このアドレス領域でどのアトミック命令がサポートされているかを記述する。  
```
Atomicity PMAs describes which atomic instructions are supported in this address region. 
```
アトミック命令のためのサポートは2つのカテゴリーに分けられる(LR／SCとAMO)。  
```
Support for atomic instructions is divided into two categories: LR/SC and AMOs. 
```

> いくつかのプラットフォームは、キャッシュ可能なメインメモリのすべてが、接続されたプロセッサによって必要とされるすべてのアトミックな操作をサポートすることを義務付けている。  

#### 3.6.3.1
AMOには4つのサポートレベルがある(AMONone、AMOSwap、AMOLogical、AMOArithmetic)。  
```
Within AMOs, there are four levels of support: AMONone, AMOSwap, AMOLogical, and AMOArithmetic. 
```
AMONoneは、AMO演算がサポートされていないことを示す。  
```
AMONone indicates that no AMO operations are supported. 
```
AMOSwapは、このアドレス範囲でアモスワップ命令のみがサポートされていることを示す。  
```
AMOSwap indicates that only amoswap instructions are supported in this address range.
```
AMOLogical は、スワップ命令とすべての論理 AMO（amoand、amoor、amoxor）がサポートされていることを示します。  
```
AMOLogical indicates that swap instructions plus all the logical AMOs (amoand, amoor, amoxor) are supported.
```
AMOArithmeticは、すべてのRISC-V AMOがサポートされていることを示す。  
```
AMOArithmetic indicates that all RISC-V AMOs are supported.
```
各サポート・レベルでは、基礎となるメモリ領域がその幅の読み書きをサポートしていれば、指定された幅のナチュラル・アラインドAMOがサポートされる。  
```
For each level of support, naturally aligned AMOs of a given width are supported if the underlying memory region supports reads and writes of that width.
```
メイン・メモリおよびI/O領域は、プロセッサがサポートするアトミック演算のサブセットのみをサポートするか、まったくサポートしない場合があります。  
```
Main memory and I/O regions may only support a subset or none of the processor-supported atomic operations.
```
![figure](./image/スクリーンショット%202024-08-25%20231553.png)  

> 可能であれば、I／O領域に少なくともAMOLogicaサポートを提供することを推奨する。  

#### 3.6.3.2
LR／SCでは、予約性と偶発性の組み合わせを示す3つのサポートレベルがある(RsrvNone、RsrvNonEventual、RsrvEventua)。  
```
For LR/SC, there are three levels of support indicating combinations of the reservability and eventuality properties: RsrvNone, RsrvNonEventual, and RsrvEventual.
```
RsrvNoneは、LR／SC操作がサポートされていないことを示す(ロケーションは 予約不可)。  
```
RsrvNone indicates that no LR/SC operations are supported (the location is non-reservable).
```
RsrvNonEventualは、操作はサポートされている(場所は予約可能)が、非特権ISA 仕様に記述されている最終的な成功保証がないことを示す。  
```
RsrvNonEventual indicates that the operations are supported (the location is reservable), but without the eventual success guarantee described in the unprivileged ISA specification.
```
RsrvEventualは、操作がサポートされ、最終的な成功保証を提供することを示す。  
```
RsrvEventual indicates that the operations are supported and provide the eventual success guarantee. 
```
> 可能であれば、メインメモリ領域にRsrvEventualサポートを提供することを推奨する。    
> ほとんどの I／O 領域は LR／SC アクセスをサポートしない。    
> キャッシュコヒーレンシースキームの上に構築するのが最も便利だからである。  
> 
> LR／SCがRsrvNonEventualとマークされたメモリ位置に使用される場合、ソフトウェアは、進捗不足が検出されたときに使用される代替フォールバックメカニズムを提供すべきである。  

### 3.6.4
不整列原子性グラニュール PMA は、不整列 AMO を制約付きでサポートする。  
```
The misaligned atomicity granule PMA provides constrained support for misaligned AMOs. 
```
この PMA が存在する場合、ミスアラインド原子性グラニュールのサイズ（自然にアライメントされた 2 の累乗バイト数）を指定する。  
```
This PMA, if present, specifies the size of a misaligned atomicity granule, a naturally aligned power-of-two number of bytes.
```
この PMA でサポートされる具体的な値は MAGNN で表され、例えば MAG16 は、ずれた原子性グラニュールが少なくとも 16 バイトであることを示す。  
```
Specific supported values for this PMA are represented by MAGNN, e.g., MAG16 indicates the misaligned atomicity granule is at least 16 bytes. 
```
ミスアラインド・アトミシティ・グラニュール PMA は AMO、基本 ISA で定義されたロードとストア、および F、D、Q 拡張で定義された MXLEN ビット以下のロードとストアにのみ適用されます。  
```
The misaligned atomicity granule PMA applies only to AMOs, loads and stores defined in the base ISAs, and loads and stores of no more than MXLEN bits defined in the F, D, and Q extensions.
```
このセットの命令では、アクセスされるすべてのバイトが同じミスアラインメント原子性粒子内にある場合、その命令はアドレスアラインメントの理由で例外を発生させず、RVWMO の目的上、その命令は 1 回のメモリ操作しか発生させません。  
```
For an instruction in that set, if all accessed bytes lie within the same misaligned atomicity granule, the instruction will not raise an exception for reasons of address alignment, and the instruction will give rise to only one memory operation for the purposes of RVWMO—i.e., it will execute atomically.
```
ミスアラインメントされた AMO が、ミスアラインメントされた原子性グラニュール PMA を指定しない領域にアクセスした場合、またはアクセスされたすべてのバイトが同じミスアラインメントされた原子性グラニュール内にない場合、例外が発生する。  
```
If a misaligned AMO accesses a region that does not specify a misaligned atomicity granule PMA, or if not all accessed bytes lie within the same misaligned atomicity granule, then an exception is raised.
```
そのような領域にアクセスする、またはアクセスされるすべてのバイトが同じ原子性顆粒内にない通常のロードとストアについては、例外が発生するか、アクセスは進むが原子性は保証されない。  
```
For regular loads and stores that access such a region or for which not all accessed bytes lie within the same atomicity granule, then either an exception is raised, or the access proceeds but is not guaranteed to be atomic. 
```
実装は、いくつかのミスアラインメント・アクセスに対して、アドレス・ミスアラインメント例外の代わりにアクセス・フォールト例外を発生させるかもしれない。  これは、その命令がトラップ・ハンドラによってエミュレートされるべきではないことを示す。  
```
Implementations may raise access-fault exceptions instead of address-misaligned exceptions for some misaligned accesses, indicating the instruction should not be emulated by a trap handler.
```

> LR／SC命令はこのPMAの影響を受けないため、ミスアラインメントが発生すると常に例外が発生します。    
> ベクタメモリアクセスも影響を受けないため、原子性がずれているグラニュールに含まれていても、非原子的に実行される可能性があります。    
> 暗黙的アクセスも同様にこの PMA の影響を受けません。  

### 3.6.5
アドレス空間の領域は、FENCE命令およびアトミック命令順序付けビットによる順序付けのために、メインメモリまたはI／Oのいずれかに分類される。  
```
Regions of the address space are classified as either main memory or I／O for the purposes of ordering by the FENCE instruction and atomic-instruction ordering bits. 
```

メイン・メモリ領域への1つのハートによるアクセスは、他のハートだけでなく、メイン・メモリ・システムで要求を開始する機能を持つ他のデバイス（例えば、DMAエンジン）からも観測可能である。  
```
Accesses by one hart to main memory regions are observable not only by other harts but also by other devices with the capability to initiate requests in the main memory system (e.g., DMA engines). 
```
コヒーレントなメインメモリ領域は、常にRVWMOまたはRVTSOメモリモデルを持つ。  
```
Coherent main memory regions always have either the RVWMO or RVTSO memory model.
```
インコヒーレントなメインメモリ領域は、実装定義メモリモデルを持つ。  
```
Incoherent main memory regions have an implementation-defined memory model. 
```

あるハートのI／O領域へのアクセスは、他のハートやバス・マスタリング・デバイスだけでなく、対象となるI／Oデバイスからも観測可能であり、I／O領域は、緩和順序でも強順序でもアクセスできる。  
```
Accesses by one hart to an I／O region are observable not only by other harts and bus mastering devices but also by the targeted I／O devices, and I／O regions may be accessed with either relaxed or strong ordering.
```
緩和順序によるI／O領域へのアクセスは、一般に、本仕様書第1巻のセクションA.4.2で論じたように、RVWMOメモリ領域へのアクセスの順序と同様の方法で、他のハートやバスマスタリングデバイスによって観測される。  
```
Accesses to an I／O region with relaxed ordering are generally observed by other harts and bus mastering devices in a manner similar to the ordering of accesses to an RVWMO memory region, as discussed in Section A.4.2 in Volume I of this specification.
```
対照的に、強い順序付けを持つI／O領域へのアクセスは、一般的にプログラム順序で他のハートやバス・マスタリング・デバイスによって観察される。  
```
By contrast, accesses to an I／O region with strong ordering are generally observed by other harts and bus mastering devices in program order.
```

各強順序I／O領域は、異なるI／O領域間で順序保証を提供できるメカニズムである番号付き順序チャネルを指定する。  
```
Each strongly ordered I／O region specifies a numbered ordering channel, which is a mechanism by which ordering guarantees can be provided between different I／O regions.
```
チャネル0は、ポイント・ツー・ポイントの強い順序付けのみを示すために使用され、関連する1つのI／O領域へのハートによるアクセスのみが強く順序付けされる。  
```
Channel 0 is used to indicate point-to-point strong ordering only, where only accesses by the hart to the single associated I／O region are strongly ordered.
```

チャネル1は、全てのI／O領域にわたるグローバルな強い順序付けを提供するために使用される。  
```
Channel 1 is used to provide global strong ordering across all I／O regions.
```
チャネル1に関連付けられたI／O領域へのハ ートによるアクセスは、他のすべてのハートとI／Oデバイスによって、緩和されたI／O 領域または異なるチャネル番号で強く順序付けられたI／O領域へのそのハートによるアクセスとの相対的な関係も含めて、プログラム順 に発生したことが観察されるだけである。  
```
Any accesses by a hart to any I／O region associated with channel 1 can only be observed to have occurred in program order by all other harts and I／O devices, including relative to accesses made by that hart to relaxed I／O regions or strongly ordered I／O regions with different channel numbers.
```
言い換えれば、チャネル1の領域へのアクセスは、その命令の前後でフェンスio,io命令を実行することと等価である。  
```
In other words, any access to a region in channel 1 is equivalent to executing a fence io,io instruction before and after the instruction.
```

他の大きなチャネル番号は、同じチャネル番号を持つすべての領域にわたって、そのハートによるアクセスにプログラム順序を提供する。  
```
Other larger channel numbers provide program ordering to accesses by that hart across any regions with the same channel number.
```

システムは、各メモリ領域の順序プロパティの動的構成をサポートするかもしれない。  
```
Systems might support dynamic configuration of ordering properties on each memory region.
```

> 強い順序付けは、レガシー・デバイス・ドライバ・コードとの互換性を向上させるためや、 アクセスの順序を変更しない実装が知られている場合に、明示的な順序付け命令を挿入するよりもパフォーマンスを向上させるために使用できます。  
> 
> ローカル・ストロング・オーダリング（チャネル0）は、ハートとI／Oデバイス間の通信パスが1つしかない場合、ストロング・オーダリングのデフォルトです。  
> 
> 一般的に、異なる強オーダリングされたI／O領域は、同じインターコネクト経路を共有し、その経路がリクエストを並べ替えない場合、オーダリングハードウェアを追加することなく、同じオーダリングチャネルを共有することができる。  

### 3.6.6
コヒーレンスは、1つの物理アドレスに対して定義されるプロパティで、あるエージェントによるそのアドレスへの書き込みが、最終的にはシステム内の他のコヒーレントなエージェントにも見えるようになることを示します。  
```
Coherence is a property defined for a single physical address, and indicates that writes to that address by one agent will eventually be made visible to other coherent agents in the system.
```
コヒーレンスは、システムのメモリ一貫性モデルと混同しないでください。メモリ一貫性モデルは、メモリ・システム全体に対する以前の読み取りと書き込みの履歴を考慮して、メモリ読み取りがどのような値を返すかを定義します。  
```
Coherence is not to be confused with the memory consistency model of a system, which defines what values a memory read can return given the previous history of reads and writes to the entire memory system.
```
RISC-Vプラットフォームでは、ソフトウェアの複雑さ、性能、エネルギーへの影響から、ハードウェア・インコヒーレント領域の使用は推奨されていません。  
```
In RISC-V platforms, the use of hardware-incoherent regions is discouraged due to software complexity, performance, and energy impacts.
```

メモリ領域のキャッシュ可能性は、メイン・メモリと I/O の分類、メモリ順序、サポートされるアクセスとアトミック操作、コヒーレンスなど、他の PMA に反映される違いを除いて、その領域のソフトウェア的な見方に影響を与えるべきではありません。  
```
The cacheability of a memory region should not affect the software view of the region except for differences reflected in other PMAs, such as main memory versus I/O classification, memory ordering, supported accesses and atomic operations, and coherence.
```
このため、キャッシュ可能性はマシン・モード・ソフトウェアによってのみ管理されるプラットフォーム・レベルの設定として扱います。  
```
For this reason, we treat cacheability as a platform-level setting managed by machine-mode software only.
```

プラットフォームがメモリ領域に対して設定可能なキャッシュ可能性設定をサポートしている場合、プラットフォーム固有のマシン・モード・ルーチンが設定を変更し、必要に応じてキャッシュをフラッシュします。  
```
Where a platform supports configurable cacheability settings for a memory region, a platform-specific machine-mode routine will change the settings and flush caches if necessary, so the system is only incoherent during the transition between cacheability settings.
```
この一時的な状態は、下位の特権レベルからは見えないようにすべきである。  
```
This transitory state should not be visible to lower privilege levels.
```
> コヒーレンスは、どのエージェントにもキャッシュされない共有メモリ領域を提供するのは簡単です。  
> このような領域の PMA は、単にプライベート・キャッシュまたは共有キャッシュにキャッシュされるべきではないことを示します。  
>
> コヒーレンスは、キャッシュ・コヒーレンス・スキームを必要とせず、複数のエージェントによって安全にキャッシュされる読み取り専用領域に対しても簡単です。  
> このリージョンの PMA はキャッシュはできるが、書き込みはサポートされていないことを示す。  
>
> いくつかの読み書き可能な領域は単一のエージェントによってのみアクセスされるかもしれない。  
> そのような領域の PMA はキャッシュ可能であることを示す。  
> 他のエージェントがその領域にアクセスしないように、データは共有キャッシュにキャッシュすることもできます。  
>
> エージェントが他のエージェントがアクセス可能な読み書き可能領域をキャッシュできる場合、キャッシュする、しないに関わらず、古い値の使用を避けるためにキャッシュ・コヒーレンス・スキームが必要です。  
> ハードウェア・キャッシュ・コヒーレンシがない領域（ハードウェア・インコヒーレント領域）では、キャッシュ・コヒーレンシを完全にソフトウェアで実装することができますが、ソフトウェア・コヒーレンシ方式は正しく実装するのが難しいことで知られており、保守的なソフトウェア指向のキャッシュ・フラッシュが必要なため、パフォーマンスに深刻な影響を与えることがよくあります。  ハードウェア・キャッシュ・コヒーレンス方式は、より複雑なハードウェアを必要とし、キャッシュ・コヒーレンス・プローブによって性能に影響を与える可能性がありますが、それ以外はソフトウェアからは見えません。  
> 
> ハードウェア・キャッシュ・コヒーレント領域ごとに、PMAはその領域がコヒーレントであることと、システムに複数のコヒーレンス・コントローラがある場合にどのハードウェア・コヒーレンス・コントローラを使用するかを示します。  
> システムによっては、コヒーレンシ・コントローラは外側レベルの共有キャッシュであり、それ自体がさらに外側レベルのキャッシュ・コヒーレンシ・コントローラに階層的にアクセスする場合もあります。  
> 
> プラットフォーム内のほとんどのメモリ領域は、未キャッシュ、読み取り専用、ハードウェア・キャッシュ・コヒーレント、または1つのエージェントによってのみアクセスされるように固定されているため、ソフトウェアに対してコヒーレントです。  

PMAがキャッシュ不可能を示す場合、その領域へのアクセスは、キャッシュではなくメモリ自体によって満たされなければならない。  
```
If a PMA indicates non-cacheability, then accesses to that region must be satisfied by the memory itself, not by any caches.
```

> キャッシュ可能性を制御するメカニズムを持つ実装では、現在キャッシュに常駐しているメモリ・ロケーションに、プログラムがキャッシュ不可能な形でアクセスするという状況が発生する可能性がある。  
> このような状況では、キャッシュされたコピーは無視されなければならない。  
> この制約は、より特権的なモードの投機的なキャッシュ補充が、より特権的でないモードのキャッシュ不可能なアクセスの動作に影響を与えないようにするために必要である。  

### 3.6.7
べき等性 PMA はアドレス領域への読み書きがべき等であるかどうかを記述する。メインメモリ領域はべき等であると仮定される。  
```
Idempotency PMAs describe whether reads and writes to an address region are idempotent. Main memory regions are assumed to be idempotent. 
```
I／O領域では、リードとライトのべき等性は別々に指定することができる（例えば、リードはべき等であるが、ライトはべき等ではない）。  
```
For I／O regions, idempotency on reads and writes can be specified separately (e.g., reads are idempotent but writes are not). 
```
アクセスが非べき等である場合、すなわち、どのような読み出しまたは書き込みアクセスにも副作用がある可能性がある場合、投機的または冗長なアクセスは避けなければならない。  
```
If accesses are non-idempotent, i.e., there is potentially a side effect on any read or write access, then speculative or redundant accesses must be avoided. 
```
べき等性 PMA を定義する目的のために、冗長アクセスによって観測されるメモリ順序の変化は副作用とはみなされません。  
```
For the purposes of defining the idempotency PMAs, changes in observed memory ordering created by redundant accesses are not considered a side effect.
```

> ハードウェアは常に、非アイデンポテントとマークされたメモリ領域への投機的アクセスや冗長アクセスを避けるように設計されるべきですが、ソフトウェアやコンパイラの最適化によって非アイデンポテントメモリ領域へのスプリアスアクセスが発生しないようにすることも必要です。  
> 
> 非べき等領域はミスアラインメント・アクセスをサポートしない場合があります。    
> このような領域へのミスアラインメント・アクセスは、アドレス・ミスアラインメント例外ではなく、アクセス・フォールト例外を発生させるべきであり、これはソフトウェアが複数の小さなアクセスを使ってミスアラインメント・アクセスをエミュレートすべきではないことを示しています。  

非べき等領域では、暗黙的読み出しと書き込みは、以下の例外を除いて、早期または投機的に実行してはならない。
```
For non-idempotent regions, implicit reads and writes must not be performed early or speculatively, with the following exceptions. 
```
投機的でない暗黙の読み出しが実行される場合、実装は、投機的でない暗黙の読み出しのアドレスを含む、自然に整列されたべき乗 2 領域内の任意のバイトを追加で読み出すことが許可される。
```
When a non-speculative implicit read is performed, an implementation is permitted to additionally read any of the bytes within a naturally aligned power-of-2 region containing the address of the non-speculative implicit read.
```
さらに、非累積命令フェッチが実行された場合、実装は、同じサイズの次の自然に整列されたべき乗2領域内の任意のバイトを追加で読み出すことが許可される（領域のアドレスは$2^XLEN$をモジュロしたものとする）。
```
Furthermore, when a non-speculative instruction fetch is performed, an implementation is permitted to additionally read any of the bytes within the next naturally aligned power-of-2 region of the same size with the address of the region taken modulo 2XLEN.
```
これらの追加読み出しの結果は、後続の早期暗黙読み出しまたは投機的暗黙読み出しを満たすために使用することができる。
```
The results of these additional reads may be used to satisfy subsequent early or speculative implicit reads.
```
これらの自然に整列されたpower-of-2領域のサイズは実装で定義されるが、ページベースの仮想メモリを持つシステムでは、サポートされる最小のページサイズを超えてはならない。
```
The size of these naturally aligned power-of-2 regions is implementationdefined, but, for systems with page-based virtual memory, must not exceed the smallest supported page size.
```

## 3.7
安全な処理をサポートし、フォールトを抑制するためには、ハート上で動作するソフトウェアがアクセスできる物理アドレスを制限することが望ましい。
```
To support secure processing and contain faults, it is desirable to limit the physical addresses accessible by software running on a hart.
```
オプションの物理メモリ保護（PMP）ユニットは、物理メモリ・アクセス権限（読み出し、書き込み、実行）を物理メモリ領域ごとに指定できるように、ハートごとのマシン・モード制御レジスタを提供する。
```
An optional physical memory protection (PMP) unit provides per-hart machine-mode control registers to allow physical memory access privileges (read, write, execute) to be specified for each physical memory region.
```
PMP 値は、セクション 3.6 で説明する PMA チェックと並行してチェックされる。
```
The PMP values are checked in parallel with the PMA checks described in Section 3.6.
```

PMPのアクセス制御設定の粒度はプラットフォーム固有ですが、標準のPMPエンコーディングは4バイトの小さな領域をサポートしています。
```
The granularity of PMP access control settings are platform-specific, but the standard PMP encoding supports regions as small as four bytes.
```
例えば、あるリージョンはマシンモードでのみ表示され、より低い権限のレイヤーでは表示されないかもしれません。
```
Certain regions’ privileges can be hardwired—for example, some regions might only ever be visible in machine mode but in no lower-privilege layers.
```
> プラットフォームによって物理メモリ保護に対する要求は大きく異なり、このセクションで説明するスキームに加えて、あるいはその代わりに、他のPMP構造を提供するプラットフォームもあるかもしれない。

PMPチェックは、実効特権モードがSまたはUであるすべてのアクセスに適用される。これには、SモードとUモードでの命令フェッチとデータ・アクセス、およびmstatusのMPRVビットが設定され、mstatusのMPPフィールドにSまたはUが含まれている場合のMモードでのデータ・アクセスが含まれる。
```
PMP checks are applied to all accesses whose effective privilege mode is S or U, including instruction fetches and data accesses in S and U mode, and data accesses in M-mode when the MPRV bit in mstatus is set and the MPP field in mstatus contains S or U.
```
PMPチェックは、仮想アドレス変換のためのページ・テーブル・アクセスにも適用され、この場合の実効特権モードはSである。
```
PMP checks are also applied to page-table accesses for virtual-address translation, for which the effective privilege mode is S.
```
オプションとして、PMPチェックはMモード・アクセスにも適用することができる。この場合、PMPレジスタ自体がロックされるため、Mモード・ソフトウェアであってもハートがリセットされるまでレジスタを変更することはできない。
```
Optionally, PMP checks may additionally apply to M-mode accesses, in which case the PMP registers themselves are locked, so that even M-mode software cannot change them until the hart is reset.
```
事実上、PMPは、デフォルトでは何も持たないSモードとUモードにパーミッションを与えることができ、デフォルトでフルパーミッションを持つMmモードからパーミッションを取り消すことができる。
```
In effect, PMP can grant permissions to S and U modes, which by default have none, and can revoke permissions from Mmode, which by default has full permissions.
```

PMP違反は常にプロセッサーで正確にトラップされる。
```
PMP violations are always trapped precisely at the processor.
```
### 3.7.1
PMP エントリは 8 ビットのコンフィギュレーション・レジスタと 1 つの MXLEN ビットのアドレス・レジスタによって記述される。
```
PMP entries are described by an 8-bit configuration register and one MXLEN-bit address register.
```
いくつかの PMP 設定は、さらに前の PMP エントリーに関連するアドレス・レジスタを使用します。
```
Some PMP settings additionally use the address register associated with the preceding PMP entry. 
```
最大 64 PMP エントリがサポートされる。実装では、0、16、または 64 の PMP エントリを実装することができる。PMP CSRフィールドはすべてWARLであり、読み取り専用でゼロであってもよい。PMP CSRはMモードからのみアクセス可能である。
```
Up to 64 PMP entries are supported. Implementations may implement zero, 16, or 64 PMP entries; the lowest-numbered PMP entries must be implemented first. All PMP CSR fields are WARL and may be read-only zero. PMP CSRs are only accessible to M-mode.
```

PMPコンフィギュレーション・レジスタは、コンテキスト・スイッチ時間を最小化するためにCSRに密集して配置されています。
```
The PMP configuration registers are densely packed into CSRs to minimize context-switch time.
```
RV32の場合、図30に示すように、ppmcfg0～ppmcfg15の16個のCSRが64個のPMPエントリ用のコンフィギュレーションppm0cfg～ppm63cfgを保持します。
```
For RV32, sixteen CSRs, pmpcfg0–pmpcfg15, hold the configurations pmp0cfg–pmp63cfg for the 64 PMP entries, as shown in Figure 30.
```
RV64の場合、図31に示すように、8つの偶数番目のCSR、ppmcfg0、ppmcfg2、...、ppmcfg14が64個のPMPエントリのコンフィグレーションを保持します。
```
For RV64, eight even-numbered CSRs, pmpcfg0, pmpcfg2, …, pmpcfg14, hold the configurations for the 64 PMP entries, as shown in Figure 31.
```
RV64の場合、奇数番目のコンフィギュレーション・レジスタであるppcfg1、ppcfg3、...、ppcfg15は不正です。
```
For RV64, the odd-numbered configuration registers, pmpcfg1, pmpcfg3, …, pmpcfg15, are illegal.
```

> RV64ハートはPMPエントリ815の設定を保持するために、ppmcfg1ではなくppmcfg2を使用します。  
> この設計では、RV32とRV64の両方でPMPエントリ8～11のコンフィギュレーションがppmcfg2[31:0]に表示されるため、複数のMXLEN値をサポートするコストが削減されます。

![figure](./image/スクリーンショット%202024-08-26%20002815.png)  

PMPアドレス・レジスタはpmpaddr0～pmpaddr63というCSRである。
```
The PMP address registers are CSRs named pmpaddr0-pmpaddr63. 
```
図32に示すように、各PMPアドレス・レジスタはRV32の34ビット物理アドレスの33-2ビットをエンコードします。
```
Each PMP address register encodes bits 33-2 of a 34-bit physical address for RV32, as shown in Figure 32. 
```
RV64の場合、図33に示すように、各PMPアドレスレジスタは56ビット物理アドレスの55-2ビットをエンコードします。
```
For RV64, each PMP address register encodes bits 55-2 of a 56-bit physical address, as shown in Figure 33.
```
全ての物理アドレス・ビットが実装されるとは限らないので、ppmaddrレジスタはWARLです。
```
Not all physical address bits may be implemented, and so the pmpaddr registers are WARL.
```
> セクション10.3で説明したSv32ページベース仮想メモリ方式はRV32の34ビット物理アドレスをサポートしているため、PMP方式はRV32のXLENより広いアドレスをサポートしなければなりません。
> 第10.4節と第10.5節で説明したSv39とSv48のページベース仮想メモリ方式は56ビットの物理アドレス空間をサポートするので、RV64のPMPアドレスレジスタは同じ制限を課します。
![figure](./image/スクリーンショット%202024-08-26%20003204.png)  

図 34 に PMP コンフィギュレーション・レジスタのレイアウトを示す。
```
Figure 34 shows the layout of a PMP configuration register. 
```
R、W、および X ビットは、セットされると、それぞれ PMP エントリがリード、ライト、および命令実行を許可することを示します。
```
The R, W, and X bits, when set, indicate that the PMP entry permits read, write, and instruction execution, respectively.
```
これらのビットのいずれかがクリアされると、対応するアクセス・タイプが拒否されます。
```
When one of these bits is clear, the corresponding access type is denied. 
```
R、W、Xフィールドは、R=0、W=1の組み合わせが予約されたWARLフィールドを形成します。
```
The R, W, and X fields form a collective WARL field for which the combinations with R=0 and W=1 are reserved.
```
残りの2つのフィールドAおよびLについては、以下のセクションで説明する。
```
The remaining two fields, A and L, are described in the following sections.
```
![figure](./image/スクリーンショット%202024-08-26%20003543.png)

実行権限のない PMP 領域から命令をフェッチしようとすると、命令アクセス・フォールト例外が発生します。
```
Attempting to fetch an instruction from a PMP region that does not have execute permissions raises an instruction access-fault exception. 
```
読み込み許可のない PMP 領域内の物理アドレスにアクセスするロード命令またはロード予約命令を実行しようとすると、ロード・アクセス・フォールト例外が発生します。
```
Attempting to execute a load or load-reserved instruction which accesses a physical address within a PMP region without read permissions raises a load access-fault exception. 
```
書き込み権限のない PMP 領域内の物理アドレスにアクセスするストア命令、ストア条件命令、または AMO 命令を実行しようとすると、ストア・アクセス・フォルト例外が発生します。
```
Attempting to execute a store, store-conditional, or AMO instruction which accesses a physical address within a PMP region without write permissions raises a store access-fault exception.
```
#### 3.7.1.1
PMPエントリーのコンフィギュレーション・レジスタのAフィールドは、関連するPMPアドレス・レジスタのアドレス・マッチング・モードをエンコードする。
```
The A field in a PMP entry’s configuration register encodes the address-matching mode of the associated PMP address register. 
```
このフィールドのエンコーディングを表 18 に示す。A=0の時、このPMPエントリーは無効で、アドレス・マッチングを行わない。
```
The encoding of this field is shown in Table 18. When A=0, this PMP entry is disabled and matches no addresses. 
```
他の2つのアドレス・マッチング・モードがサポートされている：自然に整列された4バイト領域(NA4)の特殊なケースを含む自然に整列された2乗領域(NAPOT)、および任意範囲の最上位境界(TOR)。
```
Two other address-matching modes are supported: naturally aligned power-of-2 regions (NAPOT), including the special case of naturally aligned fourbyte regions (NA4); and the top boundary of an arbitrary range (TOR). 
```
これらのモードは4バイトの粒度をサポートする。
```
These modes support four-byte granularity.
```
![figure](./image/スクリーンショット%202024-08-26%20004037.png)  

NAPOTレンジは、表19に示すように、関連するアドレス・レジスタの下位ビットを使用してレンジのサイズをエンコードする。
```
NAPOT ranges make use of the low-order bits of the associated address register to encode the size of the range, as shown in Table 19.
```
![figure](./image/スクリーンショット%202024-08-26%20005000.png)  

TORが選択された場合、関連するアドレスレジスタがアドレス範囲の先頭を形成し、先行するPMPアドレスレジスタがアドレス範囲の末尾を形成する。
```
If TOR is selected, the associated address register forms the top of the address range, and the preceding PMP address register forms the bottom of the address range. 
```
PMPエントリiのAフィールドがTORに設定されている場合、そのエントリは（$ppmcfg_{i-1}$の値に関係なく）$ppmaddr_{i-1}≦y＜ppmaddr_i$となるような任意のアドレスyにマッチする。
```
If PMP entry i's A field is set to TOR, the entry matches any address y such that pmpaddri-1≤y<pmpaddri (irrespective of the value of pmpcfgi-1). 
```
PMPエントリ0のAフィールドがTORに設定されている場合、下界には0が使用されるため、任意のアドレス$y<pmpaddr_0$にマッチします。
```
If PMP entry 0’s A field is set to TOR, zero is used for the lower bound, and so it matches any address y<pmpaddr0.
```
> $pmpaddr_{i-1}≧pmpaddr_i$ かつ$pmpcfg_i.A=TOR$ならば、PMP エントリ i はどのアドレスにもマッチしない。

PMP メカニズムは 4 バイトの小さな領域をサポートしますが、プラットフォームはより粗い PMP 領域を指定することができます。
```
Although the PMP mechanism supports regions as small as four bytes, platforms may specify coarser PMP regions.
```
一般的に、PMPの粒度は2G+2バイトであり、全てのPMP領域で同じでなければならない。
```
In general, the PMP grain is 2 G+2 bytes and must be the same across all PMP regions.
```
G > 1の場合、NA4モードは選択できない。
```
When G > 1, the NA4 mode is not selectable. 
```
G > 2 で pmpcfgi.A[1] が設定されている場合、つまりモードが NAPOT の場合、ビット [G-2:0] はすべて 1 として読み込まれる。
```
When G > 2 and pmpcfgi.A[1] is set, i.e. the mode is NAPOT, then bits [G-2:0] read as all ones.
```
G > 1 で pmpcfgi.A[1]がクリア、すなわちモードが OFF または TOR の場合、ビット pmpaddri[G-1:0]はすべて 0 として読み出される。pmpaddri[G-1:0] ビットは TOR アドレス・マッチング・ロジックに影響を与えない。
```
When G > 1 and pmpcfgi.A[1] is clear, i.e. the mode is OFF or TOR, then bits pmpaddri[G-1:0] read as all zeros. Bits pmpaddri[G-1:0] do not affect the TOR addressmatching logic.
```
特に、ppmaddri[G-1] は pmpcfgi.A が NAPOT から TOR／OFF に変更され、その後 NAPOT に戻っ ても元の値を保持する。
```
Although changing pmpcfgi.A[1] affects the value read from pmpaddri, it does not affect the underlying value stored in that register—in particular, pmpaddri[G-1] retains its original value when pmpcfgi.A is changed from NAPOT to TOR／OFF then back to NAPOT.
```

> ソフトウェアは、 pmp0cfgに0を書き込み、pmpaddr0に1をすべて書き込み、pmpaddr0を読み出すことで、PMPの粒度を決定することができる。  
> Gがセットされた最下位ビットのインデックスである場合、PMPの粒度は$2^{G+2}$バイトである。

現在のXLENがMXLENより大きい場合、アドレスマッチングのためにPMPアドレスレジスタはMXLENからXLENビットまでゼロ拡張されます。
```
If the current XLEN is greater than MXLEN, the PMP address registers are zero-extended from MXLEN to XLEN bits for the purposes of address matching.
```
#### 3.7.1.2
すなわち、コンフィギュレーション・レジスタおよび関連するアドレス・レジスタへの書き込みは無視される。
```
The L bit indicates that the PMP entry is locked, i.e., writes to the configuration register and associated address registers are ignored.
```
ロックされた PMP エントリは、ハートがリセットされるまでロックされたままである。
```
Locked PMP entries remain locked until the hart is reset.
```
PMP エントリー i がロックされている場合、 pmpicfg と pmpaddri への書き込みは無視される。
```
If PMP entry i is locked, writes to pmpicfg and pmpaddri are ignored.
```
さらに、PMPエントリーiがロックされ、ppm icfg.AがTORに設定されている場合、ppmaddri-1への書き込みは無視される。
```
Additionally, if PMP entry i is locked and pmp icfg.A is set to TOR, writes to pmpaddri-1 are ignored.
```
> Lビットを設定すると、AフィールドがOFFに設定されていてもPMPエントリーはロックされる。

Lビットは、PMPエントリーのロックに加えて、Mモードのアクセスに対してR／W／Xパーミッションが強制されるかどうかを示します。
```
In addition to locking the PMP entry, the L bit indicates whether the R/W/X permissions are enforced on M-mode accesses.
```
Lビットがセットされている場合、これらのパーミッションはすべての特権モードに対して強制される。
```
When the L bit is set, these permissions are enforced for all privilege modes.
```
Lビットがクリアされると、PMPエントリと一致するMモードアクセスは成功し、R／W／XパーミッションはSモードとUモードにのみ適用される。
```
When the L bit is clear, any M-mode access matching the PMP entry will succeed; the R/W/X permissions apply only to S and U modes. 
```

#### 3.7.1.3
PMPエントリーは静的に優先順位付けされる。
```
PMP entries are statically prioritized. 
```
PMPエントリは静的に優先順位付けされ、アクセスのいずれかのバイトにマッチする最下 位のPMPエントリが、そのアクセスの成否を決定する。
```
The lowest-numbered PMP entry that matches any byte of an access determines whether that access succeeds or fails. 
```
一致するPMPエントリーは、L、R、W、およびXビットに関係なく、アクセスのすべてのバイトに一致しなければならない。
```
The matching PMP entry must match all bytes of an access, or the access fails, irrespective of the L, R, W, and X bits.
```
例えば、あるPMPエントリーが4バイトの範囲0xC-0xFに一致するように設定されている場合、そのPMPエントリーがそれらのアドレスに一致する最も優先順位の高いエントリーであるとして、範囲0x8-0xFへの8バイトのアクセスは失敗する。
```
For example, if a PMP entry is configured to match the four-byte range 0xC–0xF, then an 8-byte access to the range 0x8–0xF will fail, assuming that PMP entry is the highest-priority entry that matches those addresses. 
```

PMPエントリーがアクセスの全バイトにマッチする場合、L、R、W、Xビットがアクセスの成否を決定する。
```
If a PMP entry matches all bytes of an access, then the L, R, W, and X bits determine whether the access succeeds or fails.
```
Lビットがクリアで、アクセスの特権モードがMの場合、アクセスは成功する。
```
If the L bit is clear and the privilege mode of the access is M, the access succeeds.
```
それ以外の場合、Lビットがセットされているか、アクセスの特権モードがSまたはUであれば、アクセスタイプに対応するR、W、Xビットがセットされている場合のみ、アクセスは成功する。
```
Otherwise, if the L bit is set or the privilege mode of the access is S or U, then the access succeeds only if the R, W, or X bit corresponding to the access type is set. 
```
Mモードのアクセスに一致するPMP項目がない場合、アクセスは成功する。
```
If no PMP entry matches an M-mode access, the access succeeds.
```

SモードまたはUモードのアクセスに一致するPMPエントリがないが、少なくとも1つのPMPエントリが実装されている場合、そのアクセスは失敗する。
```
If no PMP entry matches an S-mode or U-mode access, but at least one PMP entry is implemented, the access fails.
```
> 少なくとも1つのPMPエントリが実装されているが、すべてのPMPエントリのAフィールドがOFFに設定されている場合、すべてのSモードおよびUモードのメモリアクセスは失敗する。

失敗したアクセスは、命令、ロード、ストアのアクセス・フォールト例外を生成する。
```
Failed accesses generate an instruction, load, or store access-fault exception. 
```
1つの命令が複数のアクセスを発生させることがあり、そのアクセスは相互にアトミックでない場合があることに注意してください。
```
Note that a single instruction may generate multiple accesses, which may not be mutually atomic.
```
アクセス・フォールト例外は、命令によって生成された少なくとも1つのアクセスが失敗した場合に生成されますが、その命令によって生成された他のアクセスが、目に見える副作用を伴って成功することもあります。
```
An access-fault exception is generated if at least one access generated by an instruction fails, though other accesses generated by that instruction may succeed with visible side effects.
```
特に、仮想メモリを参照する命令は、複数のアクセスに分解されます。
```
Notably, instructions that reference virtual memory are decomposed into multiple accesses.
```

一部の実装では、不整列ロード、ストア、および命令フェッチも複数のアクセスに分解されることがあり、そのうちのいくつかは、アクセス・フォールト例外が発生する前に成功することがあります。
```
On some implementations, misaligned loads, stores, and instruction fetches may also be decomposed into multiple accesses, some of which may succeed before an access-fault exception occurs.
```
特に、ミスアラインメントされたストアのうち、PMPチェックに合格した部分は、別の部分がPMPチェックに不合格であっても、可視になる可能性があります。
```
In particular, a portion of a misaligned store that passes the PMP check may become visible, even if another portion fails the PMP check.
```
同じ動作は、ストア・アドレスが自然にアラインされている場合でも、XLENビットより幅の広いストア（RV32DのFSD命令など）に対して現れることがあります。
```
The same behavior may manifest for stores wider than XLEN bits (e.g., the FSD instruction in RV32D), even when the store address is naturally aligned. 
```
### 3.7.2
物理メモリ保護メカニズムは、第 10 章で説明したページベースの仮想メモリ・システム と組み合わせるように設計されている。
```
The Physical Memory Protection mechanism is designed to compose with the page-based virtual memory systems described in Chapter 10. 
```
ページングが有効になっている場合、仮想メモリにアクセスする命令は、ページテーブ ルへの暗黙的な参照を含む複数の物理メモリ・アクセスになる可能性があります。
```
When paging is enabled, instructions that access virtual memory may result in multiple physical-memory accesses, including implicit references to the page tables. The PMP checks apply to all of these accesses.
```
PMPチェックはこれらのアクセスすべてに適用されます。
```
The effective privilege mode for implicit pagetable accesses is S.
```

仮想メモリを使用する実装では、明示的なメモリ・アクセスで必要とされるよりも早く、投機的にアドレス変換を実行し、アドレス変換キャッシュ構造にキャッシュすることが許可されます。
```
Implementations with virtual memory are permitted to perform address translations speculatively and earlier than required by an explicit memory access, and are permitted to cache them in address translation cache structures—including possibly caching the identity mappings from effective address to physical address used in Bare translation modes and M-mode.
```
その結果得られる物理アドレスの PMP 設定は、アドレス変換と明示的なメモリアクセスの間のどの時点でもチェックされる可能性がある（キャッシュされる可能性もある）。
```
The PMP settings for the resulting physical address may be checked (and possibly cached) at any point between the address translation and the explicit memory access. 
```
そのため、PMP設定が変更された場合、Mモード・ソフトウェアはPMP設定を仮想メモリ・システムおよびPMPまたはアドレス変換キャッシュと同期させる必要があります。
```
Hence, when the PMP settings are modified, M-mode software must synchronize the PMP settings with the virtual memory system and any PMP or address-translation caches. 
```
これは、PMP CSRが書き込まれた後に、rs1=x0、rs2=x0でSFENCE.VMA命令を実行することで達成される。
```
This is accomplished by executing an SFENCE.VMA instruction with rs1=x0 and rs2=x0, after the PMP CSRs are written.
```
ハイパーバイザ・エクステンションが実装されている場合の追加の同期要件については、セクション 18.5.3 を参照してください。
```
See Section 18.5.3 for additional synchronization requirements when the hypervisor extension is implemented.
```

ページベースの仮想メモリが実装されていない場合、メモリアクセスは PMP 設定を同期的にチェックするため、SFENCE.VMA は必要ありません。
```
If page-based virtual memory is not implemented, memory accesses check the PMP settings synchronously, so no SFENCE.VMA is needed.
```