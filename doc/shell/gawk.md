
## Shell 工具之 gawk

`gawk` 程序是 Unix 中原 `awk` 程序的 GNU 版本。awk 程序在流编辑方面比 sed 编辑器更先进的是：它提供了一种编程语言而不仅仅是编辑器命令行。

### gawk 命令格式

    gawk options program file

**表：gawk 选项**

|  选项  |     描述    |
|--------|--------------------------------------------|
|-F fs	|指定描绘一行中数据字段的文件分隔符|
|-f file	|指定读取程序的文件名|
|-v var=value	|定义 gawk 程序中使用的变量和默认值|
|-mf N	|指定数据文件中要处理的字段的最大数目|
|-mr N	|指定数据文件中中的最大记录大小|
|-W keyword	|指定 gawk 的兼容模式或警告级别|
 

### 自命令行读取程序脚本
`gawk` 程序脚本由左大括号和右大括号定义。脚本命令必须放置在两个大括号之间。由于gawk命令行假定脚本是单个文本字符串，所以必须将脚本放到单引号内。

    $ gawk '{print "hello world"}'    
    hello
    hello world
    hi
    hello world

### 使用数据字段变量
`gawk` 将下面的变量分配给文本行中检测到的每个数据字段：
* $0代表整个文本行
* $1代表文本行中的第1个数据字段，$2等依次类推
gawk 的默认分隔符为空白字符。

    $ gawk '{print $1}' data1
    this

### 使用-F来指定字段分隔符

    $ gawk -F: '{print $1}' /etc/passwd                                   
    root
    bin
    daemon
    adm

### 在程序脚本中使用多个命令
要在命令行指定的程序脚本中使用多个命令，只需在各命令之间加一个分号;

    $ echo "this is a test" | gawk '{$4="gawk";print $0}'   
    this is a gawk

也可以使用次提示符每次输入一行程序脚本命令：

    $ gawk '{
    > $4="testing"
    > print $0 }' 
    This is not a good test.
    This is not testing good test.

### 从文件读取程序
`gawk` 编辑器允许您将程序保存在文件中并在命令行引用他们：

    //gawk程序中使用变量无需加美元符
    # cat gawktest 
    {
    text="'s home directory is "
    print $1 text $6
    }
    
    # gawk -F: -f gawktest passwd 
    root's home directory is /root
    bin's home directory is /bin
    daemon's home directory is /sbin
    adm's home directory is /var/adm

### 在处理数据之前/之后允许脚本
* BEGIN 关键字允许指定在读取数据之前 gawk 执行的程序脚本
* END 关键字允许指定在读取数据之后 gawk 执行的程序脚本
```shell
    # cat beginend 
    BEGIN {                                            //BEGIN处理数据前运行的脚本
    print "userid   shell"
    print "------   -----"
    FS=":"                                             //FS脚本中定义分隔符
    }

    {
    print $1 "      " $7                               //引号内为制表符，这样输出的结果才能对齐
    }

    END {                                              //END处理数据后运行的脚本
    print "end of list"
    }
```

    # gawk -f beginend passwd 
    userid  shell
    ------  -----
    root    /bin/bash
    bin     /sbin/nologin
    daemon  /sbin/nologin
    adm     /sbin/nologi
    ...
    end of list

 
### 使用变量
`gawk` 编程语言支持两种不同类型的变量：
* 内置变量
* 用户定义的变量

#### 内置变量
`gawk` 程序使用内置变量引用程序数据内的特定功能。

数据字段变量允许使用美元符号和数据字段在记录中的数字位置引用数据记录中的单个数据字段。如$1。可以使用FS内置变量更改字段分隔符号。

FS内置变量属于一组内置变量，用于控制 gawk 在输入数据和输出数据中处理字段和记录的方式。

**gawk数据字段和记录变量**

|   变量  |    描述     |
|----------|---------------------------------------|
|FIELDWIDTHS|以空格分隔的数字列表，用空格定义每个数据字段的精确宽度|
|FS|输入字段分隔符号|
|RS|输入记录分隔符号|
|OFS|输出字段分隔符号|
|ORS|输出记录分隔符号|

默认情况下，gawk将OFS变量设置为空格：

    [root@wh tmp]# cat data1
    data11,data12,data13,data14,data15
    data21,data22,data23,data24,data25
    data31,data32,data33,data34,data35
    [root@wh tmp]# gawk 'BEGIN{FS=","} {print $1,$2,$3}' data1
    data11 data12 data13
    data21 data22 data23
    data31 data32 data33
 

通过设置OFS变量，可以使用任何字符串分隔符输出中的数据字段：

    [root@wh tmp]# gawk 'BEGIN{FS=",";OFS="-"} {print $1,$2,$3}' data1
    data11-data12-data13
    data21-data22-data23
    data31-data32-data33

    [root@wh tmp]# gawk 'BEGIN{FS=",";OFS="--"} {print $1,$2,$3}' data1
    data11--data12--data13
    data21--data22--data23
    data31--data32--data33

    [root@wh tmp]# gawk 'BEGIN{FS=",";OFS="<-->"} {print $1,$2,$3}' data1
    data11<-->data12<-->data13
    data21<-->data22<-->data23
    data31<-->data32<-->data33
 

**更多gawk内置变量**

|  变量  |     描述      |
|---------|-----------------------------------------------------|
|ARGC|出现的命令行参数的个数|
|ARGIND|当前正在处理的文件在ARGV中的索引|
|ARGV|命令行参数数组|
|CONVFMT|数字的转换格式（参见printf语句）。默认值为%.6g|
|ENVIRON|当前shell环境变量及其值的关联数组|
|ERRNO|当读取或关闭输入文件时发生错误时的系统错误|
|FILENAME|用于输入到gawk程序的数据文件的文件名|
|FNR|数据文件的当前记录号|
|IGNORECASE|如果设置为非0，则忽略gawk命令中使用的字符串的大小写|
|NF|数据文件中数据字段的个数|
|NR|已处理的输入记录的个数|
|OFMT|显示数字的输出格式。默认为%,6g|
|RLENGTH|匹配函数中匹配上的子字符串的长度|
|RSTART|匹配函数中匹配上的子字符串的开始索引|

    [root@wh tmp]# gawk 'BEGIN {print ARGC,ARGV[1]}' data1
    2 data1

ARGC变量表示命令行上有两个参数。这包括gawk命令和data1参数（注意，程序脚本不是参数）。ARGV数组以索引0开始，它表示命令。第一个数组值是gawk命令后的第一个命令行参数。与shell变量不同的是在脚本中引用gawk变量时，不需要再变量名称前加美元符号。

 

FNR、NF和NR变量在gawk程序中用于跟踪数据字段和记录。有时，你可能不知道记录中具体有多少个数据字段。NF变量允许指出记录中的最后一个数据字段而不需要知道它的位置：

[root@wh tmp]# gawk 'BEGIN{FS=":"; OFS=":"} {print $1,$NF}' /etc/passwd

root:/bin/bash

bin:/sbin/nologin

daemon:/sbin/nologin

adm:/sbin/nologin

lp:/sbin/nologin

sync:/bin/sync

 

NF变量包含数据文件中最后一个数据字段的数值。通过在前面加美元符号，可以将其作为数据字段变量使用。

 

FNR和NR变量相类似，只是略有不同。FNR变量包含当前数据文件中处理的记录数。NR变量包含已经处理的记录的总数。让我们看几个例子来了解它们的不同之处：

[root@wh tmp]# gawk 'BEGIN{FS=",";} {print $1,"FNR="FNR}' data1 data1

data11 FNR=1

data21 FNR=2

data31 FNR=3

data11 FNR=1

data21 FNR=2

data31 FNR=3

 

本例中，gawk程序命令行定义了两个输入文件（它两次都指定了同一输入文件）。脚本打印第一个数据字段的值和FNR变量的当前值。请注意，FNR变量在gawk程序处理第二个数据文件时被重新设置为1。

现在，让我们添加NR变量，看看结果是什么：

[root@wh tmp]# gawk 'BEGIN{FS=",";} {print $1,"FNR="FNR,"NR="NR} END {print "There were",NR,"records processed"}' data1 data1

data11 FNR=1 NR=1

data21 FNR=2 NR=2

data31 FNR=3 NR=3

data11 FNR=1 NR=4

data21 FNR=2 NR=5

data31 FNR=3 NR=6

There were 6 records processed

 

FNR变量值在gawk处理第二个数据文件时被重置，但NR变量在处理第二个数据文件时仍然继续增加。也就是说，如果只使用一个 文件作为输入，则FNR和NR值将是相同的。如果使用多个数据文件作为输入，则FNR值在每次处理新的数据文件时重置，而NR值对所有数据文件进行累计计数。

 

使用数组

定义数组变量

格式：

var[index] = element

var 是变量的名称， index 是关联数组的索引值， element 是数组元素值

capital["Illinois"] = "Springfield"

在引用数组变量时，必须包括索引值才能检索相应的数据元素值。

$ gawk 'BEGIN{

> capital["Illinois"] = "Springfield"

> print capital["Illinois"]

> }'

Springfield

 

在数组变量中递归

可以使用特殊格式的 for 语句

for {var in array}

{

　　statements

}

示例

$ gawk 'BEGIN{

> var["a"] = 1

> var["g"] = 2

> var["m"] = 3

> var["u"] = 4

> for (test in var)

> {

>　　print "Index:", test," - Value:", var[test]

> }

> }'

Index: u - Value: 4

Index: m - Value: 3

Index: a - Value: 1

Index: g - Value: 2

注意：索引值不是以一定的顺序返回的。

 

删除数组变量

格式：

delete array[index]

delete 命令从数组删除关联索引值和关联的数组元素值。

 

使用模式

正则表达式

$ gawk 'BEGIN{FS=","} /11/{print $1}' data1

 

匹配操作符(~)

匹配操作符允许限制正则表达式匹配记录中的特定数据字段。

格式：

$1 ~ /^data/

用于在数据文件中搜索特定的数据元素

$ gawk -F: '$1 ~ /rich/{print $1, $NF}' /etc/passwd

rich /bin/bash

此示例在第一个数据字段中搜索文本 rich，当找到模式时，打印出记录的第一个和最后一个数据字段。

 

数学表达式

常用的数学比较表达式

◆  x == y  值 x 等于 y

◆  x <= y 值 x 小于等于 y

◆  x < y 值 x 小于 y

◆  x > y 值 x 大于 y

◆  x >= y 值 x 大于等于 y

$ gawk -F, '$1 == "data"{print $1}' data1

 

结构化命令

if 语句

格式:
  if (condition)

　　statement1

或者

  if (condition)  statement1

示例

[root@tang sh19]# gawk '{
> if($1 > 20)
> {
> x = $1 * 2
> print x
> }
> }' data4
100
68

 

if-else 语句

格式

  if (condition)

　　statement1

  else

　　statement2

或者

  if (condition) statement1; else statement2

示例

[root@tang sh19]# gawk '{
> if($1 >20)
> {
> x = $1 * 2
> print x
> } else
> {
> x = $1 / 2
> print x
> }
> }' data4
5
2.5
6.5
100
68

 

while 语句

while 语句为 gawk 程序提供了基本的循环功能。

格式

while (condition)

{

　　statements

}

示例

[root@tang sh19]# gawk '{
> total = 0
> i = 1
> while (i < 4)
> {
> total += $i
> i++
> }
> avg = total / 3
> print "Average:", avg
> }' data5
Average: 176.667
Average: 137.667
Average: 128.333

另外，gawk 支持在while循环中使用 break 和 continue 语句。

 

do-while 语句

格式

do

{

　　statements

} while (condition)

示例

[root@tang sh19]# gawk '{
> total = 0
> i = 1
> do
> {
> total += $i
> i++
> } while (total < 150)
> print total
> }' data5
315
160
250

 

for 语句

gawk 支持C 语言形式的 for 循环

格式

for( variable assignment; condition; iteration process)

示例

[root@tang sh19]# gawk '{
> total = 0
> for (i=1; i<4; i++)
> {
> total += $i
> }
> avg = total / 3
> print "Average:", avg
> }' data5
Average: 176.667
Average: 137.667
Average: 128.333

 

格式化打印

printf 命令的格式

printf "format string", var1, var2 ...

formate string是格式化输出的关键。它使用文本元素和格式化说明符说明了格式化后输出的显示方式。

格式化说明符格式：

%[modifier]control-letter

control-letter 表示要显示的数据值类型的字符代码

modifer 定义可选的格式化功能

格式化说明符控制字

控制字	描述	控制字	描述
c	将数据显示为ASCII字符	g	以科学计数法和浮点数的较短者显示数字
d	显示整数值	o	显示八进制数值
i	显示整数值（与d相同）	s	显示文本字符串
e	用科学计数法显示数字	x	显示十六进制数值
f	显示浮点数值	X	显示十六进制数值，但对A到F使用大写字母
除了控制字以外，还可以使用3中修饰符更多地控制输出。

width：指定输出字段最新宽度的数字值。

prec：指定浮点数中十进制数小数点右侧位数的数值，或者文本字符串中显示的最大字符数。

-(减号) ：表示在将数据放到格式化空间时不使用右对齐，而是使用左对齐。

示例

$ gawk '{

> total = 0

> for (i=1; i<4; i++)

> {

>      total += $i;

> }

> avg = total / 3;

> printf "Average: $%5.1f\n", avg

> }' data5

 

内置函数

数学函数

字符串函数

时间函数

 

除了标准的数学函数，gawk 还提供了一些函数用于数据的位操作处理

and(v1, v2) 执行 v1 和 v2 的于操作

compl(val) 执行对 val 的补位

lshift(val, count) 将值 val 向左移动 count 位

or(v1, v2) 执行 v1 和 v2 的或操作

rshift(val, count) 将值 val 向右移动 count 位

xor(v1, v2) 执行 v1 和 v2 的异或操作
