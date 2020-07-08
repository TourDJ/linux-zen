
## Shell 常用特性
  
### 管道(|)

管道 (|)： 将一个命令的输出作为另外一个命令的输入。
 
管道同样可以在标准输入输出和标准错误输出间做代替工作，这样一来，可以将某一个程序的输出送到另一个程序的输入，其语法如下：

    command1| command2 [| command3...]

也可以连同标准错误输出一起送入管道：

    command1| &command2[|& command3...]
 
例如：

    grep "hello" file.txt | wc -l 
在file.txt中搜索包含有”hello”的行并计算其行数。 在这里grep命令的输出作为wc命令的输入。当然您可以使用多个命令。 

### 输入输出重定向
 
在Linux中，每一个进程都有三个特殊的文件描述指针：
* 标准输入(standard input，文件描述指针为0)
* 标准输出(standard output，文件描述指针为1)
* 标准错误输出(standard error，文件描述指针为2)
 
这三个特殊的文件描述指针使进程在一般情况下接收标准输入终端的输入，同时由标准终端来显示输出，Linux同时也向使用者提供可以使用普通的文件或管道来取代这些标准输入输出设备。在shell中，使用者可以利用“>”和“<”来进行输入输出重定向。
 
重定向：将命令的结果输出到文件，而不是标准输出（屏幕）。如：
* command>file：将命令的输出结果重定向到一个文件。
* command>&file：将命令的标准错误输出一起重定向到一个文件。
* command>>file：将标准输出的结果追加到文件中。
* command>>&file：将标准输出和标准错误输出的结构都追加到文件中。

例如：

    find /etc -name passwd 1> stdout 将标准输出存入stdout文件中，默认为1可以不写

    find /etc -name passwd 2>errs 1>output 将错误输出存入errs文件中，标准输出存入output文件中

    find /etc -name passwd >alloutlput 2>&1 将标准输出、错误输出都存入到alloutout文件中

    find /etc -name passwd &>alloutlput1 将所有信息存入到alloutput1文件中
 

### 常用特殊符号
 

1 反引号
 
使用反引号("\`")可以将一个命令的输出作为另外一个命令的一个命令行参数。
命令： 

    find . -mtime -1 -type f -print 
用来查找过去24小时（-mtime –2则表示过去48小时）内修改过的文件。如果您想将所有查找到的文件打一个包，则可以使用以下脚本： 
```shell
#!/bin/sh 
# The ticks are backticks (`) not normal quotes ('): 
tar -zcvf lastmod.tar.gz `find . -mtime -1 -type f -print` 
``` 

 
2 前台和后台

在shell下面，一个新产生的进程可以通过用命令后面的符号“;”和“&”来分别以前台和后台的方式来执行，语法如下：

    command

产生一个前台的进程，下一个命令须等该命令运行结束后才能输入。
 
    command &

产生一个后台的进程，此进程在后台运行的同时，可以输入其他的命令。
 
 
3 文件名代换（Globbing）

* 、?、 [] 这些用于匹配的字符称为通配符（Wildcard），具体如下：

**表 - 通配符**

|符号| 说明 |
|----|-------------------------------------------|
|\*|	匹配0个或多个任意字符|
|?|	匹配一个任意字符|
|[若干字符]|	匹配方括号中任意一个字符的一次出现|
|[^若干字符]|	匹配任意一个字符的一次出现除了方括号中列出的|
```shell
$ ls /dev/ttyS* 
$ ls ch0?.doc 
$ ls ch0[0-2].doc 
$ ls ch[012][0-9].doc
```
注意，Globbing所匹配的文件名是由Shell展开的，也就是说在参数还没传给程序之前已经展开了，比如上述ls ch0[012].doc命令，如果当前目录下有ch00.doc和ch02.doc，则传给ls命令的参数实际上是这两个文件名，而不是一个匹配字符串。

 
4 命令代换：\`或 $() 

 

由反引号括起来的也是一条命令，Shell先执行该命令，然后将输出结果立刻代换到当前命令行中。例如定义一个变量存放date命令的输出：

$ DATE=`date` 
$ echo $DATE
 

命令代换也可以用$()表示：

$ DATE=$(date)
 

 
5 转义字符\ 

 

和C语言类似，\在Shell中被用作转义字符，用于去除紧跟其后的单个字符的特殊意义（回车除外），换句话说，紧跟其后的字符取字面值。例如：

$ echo $SHELL /bin/bash 
$ echo \$SHELL $SHELL 
$ echo \\ \
 

比如创建一个文件名为“$ $”的文件可以这样：

$ touch \$\ \$
 

还有一个字符虽然不具有特殊含义，但是要用它做文件名也很麻烦，就是-号。如果要创建一个文件名以-号开头的文件，这样是不行的：

$ touch -hello 

touch: invalid option -- h 
Try `touch --help' for more information.
即使加上\转义也还是报错：

$ touch \-hello 
touch: invalid option -- h 
Try `touch --help' for more information.
 

因为各种UNIX命令都把-号开头的命令行参数当作命令的选项，而不会当作文件名。如果非要处理以-号开头的文件名，可以有两种办法：

$ touch ./-hello
 

或者

$ touch -- -hello
 

\还有一种用法，在\后敲回车表示续行，Shell并不会立刻执行命令，而是把光标移到下一行，给出一个续行提示符>，等待用户继续输入，最后把所有的续行接到一起当作一个命令执行。例如：

$ ls \ 
> -l （ls -l命令的输出）
 

 

6 单引号 

 

和C语言不一样，Shell脚本中的单引号和双引号一样都是字符串的界定符（双引号下一节介绍），而不是字符的界定符。单引号用于保持引号内所有字符的字面值，即使引号内的\和回车也不例外，但是字符串中不能出现单引号。如果引号没有配对就输入回车，Shell会给出续行提示符，要求用户把引号配上对。例如：

 

$ echo '$SHELL' $SHELL 
$ echo 'ABC\（回车） > DE'（再按一次回车结束命令） ABC\ DE
 

 

7 双引号

 

双引号用于保持引号内所有字符的字面值（回车也不例外），但以下情况除外：

* $加变量名可以取变量的值
* 反引号仍表示命令替换
* \$表示$的字面值
* \`表示\`的字面值
* \"表示"的字面值
* \\表示\的字面值 
* ！

除以上情况之外，在其它字符前面的\无特殊含义，只表示字面值

    $ echo "$SHELL" 
      /bin/bash 

    $ echo "`date`" 
      Sun Apr 20 11:22:06 CEST 2003 

    $ echo "I'd say: \"Go for it\"" 
      I'd say: "Go for it" 

    $ echo "\"（回车） >"（再按一次回车结束命令） 
      "  

    $ echo "\\" 
      \

 

### 运算符
 

1 算术代换：$(()) 和 $[]

 

用于算术计算，$(())中的Shell变量取值将转换成整数，例如：

$ VAR=45 
$ echo $(($VAR+3))
$ echo $[$VAR+4]
$(())中只能用+-*/%和()运算符，并且只能做整数运算。

 

2 expr 和 let 命令

 
expr 命令允许处理命令行中的等式。
expr [1+5]
 
 
3 declare 命令
功能说明：声明 shell 变量。

语　　法：declare [+/-][rxi][变量名称＝设置值] 或 declare -f

补充说明：declare为shell指令，在第一种语法中可用来声明变量并设置变量的属性([rix]即为变量的属性），在第二种语法中可用来显示shell函数。若不加上任何参数，则会显示全部的shell变量与函数(与执行set指令的效果相同)。

参　　数：
　+/- 　"-"可用来指定变量的属性，"+"则是取消变量所设的属性。
　-f 　仅显示函数。
　r 　将变量设置为只读。
　x 　指定的变量会成为环境变量，可供shell以外的程序来使用。
　i 　[设置值]可以是数值，字符串或运算式。

  a   将变量声明为数组型

  p   显示指定变量的被声明的类型

 

declare -i cc = $aa +$bb

 

4 变量测试

 



 

 

bc(bash 计算器)
 
bash 计算器实际上是一种编程语言，该语言允许在命令行中输入浮点表达式，然后解释表达式并计算它们。
 
bc 命令:
     bc 命令是用于命令行计算器。 它类似基本的计算器。 使用这个计算器可以做基本的数学运算。

语法:
  语法是 
     bc [命令开关]

命令开关:
     
-c	仅通过编译。 bc命令的输出被发送到标准输出。
-l	定义数学函数并且初始化值为20，取代默认值0。
filename	文件名，它包含用于计算的计算器命令，这不是必须的命令。


 
bash 计算器可以识别：
数字（整数和浮点）
变量
注释
表达式
编程语句
函数
示例

    [root@localhost ~]# bc
    bc 1.06
    Copyright 1991-1994,1997,1998,2000 Free Software Foundation,Inc.
    This is free software with ABSOLUTELY NO WARRANTY.
    For details type `warranty'.

     9*2
    18
上述命令是来做数学运算。

 

[root@localhost ~]# bc -l

bc 1.06 Copyright 1991-1994,1997,1998,2000 Free Software Foundation,Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
 
1+2
3
上述命令是求'1+2'的和。

 

[root@localhost ~]# bc calc.txt

bc 1.06 Copyright 1991-1994,1997,1998,2000 Free Software Foundation,Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
 
3
'calc.txt' 这个文件有代码:1+2。 从文件输入并且显示输出结果。

 
 
浮点算术被称为 scale 的内置变量控制。必须把这个值设置为想要的十进制小数位数。
例如
$ bc -q
3.44/5
0
scale=4
3.44/5
.6880
quit
$
 
在脚本中使用 bc
variable='echo "options; expression" | bc'
例如
var1='echo "  scale=4; 3.44 / 5"  | bc'
 
 
编码转换
 

在Linux中执行.sh脚本，异常提示/bin/sh^M: bad interpreter: No such file or directory。这是不同系统编码格式引起的：在windows系统中编辑的.sh文件可能有不可见字符，所以在Linux系统下执行会报以上异常信息。


1）在windows下转换： 
利用一些编辑器如UltraEdit或EditPlus等工具先将脚本编码转换，再放到Linux中执行。转换方式如下（UltraEdit）：File-->Conversions-->DOS->UNIX即可。 
或者按Ctrl+H，将文本内容转换为十六进制，然后其中的0D 0A（Dos下的回车）替换为0A（Unix下的回车），但是这种方式还是要注意修改后保存时文本的类型，比较推荐的是下面第二种方式。

2）也可在Linux中转换： 
首先要确保文件有可执行权限 
#sh>chmod a+x filename

然后修改文件格式 
#sh>vi filename

利用如下命令查看文件格式 
:set ff 或 :set fileformat

可以看到如下信息 
fileformat=dos 或 fileformat=unix

利用如下命令修改文件格式 
:set ff=unix 或 :set fileformat=unix

:wq (存盘退出)

最后再执行文件 
#sh>./filename
