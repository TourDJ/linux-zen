- [Shell 基础知识](#shell_base)       
  - [Shell 概述](#shell_summary)       
    - [什么是shell](#shell_what)        
    - [几种流行的shell](#shell_kind)          
        
    
  

## <a id="shell_base">Shell 基础知识</a>

Shell 本身是一个用C语言编写的程序，它是用户使用Linux的桥梁。Shell既是一种命令语言，又是一种程序设计语言。作为命令语言，它交互式地解释和执行用户输入的命令；作为程序设计语言，它定义了各种变量和参数，并提供了许多在高级语言中才具有的控制结构，包括循环和分支。它虽然不是 Linux系统核心的一部分，但它调用了系统核心的大部分功能来执行程序、建立文件并以并行的方式协调各个程序的运行。因此，对于用户来说，shell是最重要的实用程序，深入了解和熟练掌握shell的特性及其使用方法，是用好Linux系统的关键。可以说，shell使用的熟练程度反映了用户对 Linux使用的熟练程度。
 

### <a id="shell_summary">Shell 概述</a>
 
#### <a id="shell_what">什么是shell</a>

当一个用户登录Linux系统之后，系统初始化程序init就为每一个用户运行一个称为shell(外壳)的程序。那么，shell是什么呢？确切一点说，shell就是一个命令行解释器，它为用户提供了一个向Linux内核发送请求以便运行程序的界面系统级程序，用户可以用shell来启动、挂起、停止甚至是编写一些程序。

当用户使用Linux时是通过命令来完成所需工作的。一个命令就是用户和shell之间对话的一个基本单位，它是由多个字符组成并以换行结束的字符串。shell解释用户输入的命令，就象DOS里的command.com所做的一样，所不同的是，在DOS中，command.com只有一个，而在Linux下比较流行的shell有好几个，每个shell都各有千秋。一般的Linux系统都将bash作为默认的shell。


#### <a id="shell_kind">几种流行的shell</a>

目前流行的shell有`ash`、`bash`、`ksh`、`csh`、`zsh`等，你可以用下面的命令来查看你自己的shell类型：

    #echo $SHELL
$SHELL是一个环境变量，它记录用户所使用的shell类型。你可以用命令：

    #shell-name
来转换到别的shell，这里shell-name是你想要尝试使用的shell的名称，如ash等。这个命令为用户又启动了一个shell，这个shell在最初登录的那个shell之后，称为下级的shell或子shell。使用命令：

    $exit
可以退出这个子shell。


使用不同的shell的原因在于它们各自都有自己的特点，下面作一个简单的介绍：

1. ash shell是由Kenneth Almquist编写的，Linux中占用系统资源最少的一个小shell，它只包含24个内部命令，因而使用起来很不方便。

2. bash 是Linux系统默认使用的shell，它由Brian Fox和Chet Ramey共同完成，是Bourne Again Shell的缩写，内部命令一共有40个。Linux使用它作为默认的shell是因为它有诸如以下的特色：

(1) 可以使用类似DOS下面的doskey的功能，用方向键查阅和快速输入并修改命令。

(2) 自动通过查找匹配的方式给出以某字符串开头的命令。

(3) 包含了自身的帮助功能，你只要在提示符下面键入help就可以得到相关的帮助。

3. ksh 是Korn shell的缩写，由Eric Gisin编写，共有42条内部命令。该shell最大的优点是几乎和商业发行版的ksh完全兼容，这样就可以在不用花钱购买商业版本的情况下尝试商业版本的性能了。

4. csh 是Linux比较大的内核，它由以William Joy为代表的共计47位作者编成，共有52个内部命令。该shell其实是指向/bin/tcsh这样的一个shell，也就是说，csh其实就是tcsh。

5. zch 是Linux最大的shell之一，由Paul Falstad完成，共有84个内部命令。如果只是一般的用途，是没有必要安装这样的shell的。

其实作为命令语言交互式地解释和执行用户输入的命令只是shell功能的一个方面，shell还可以用来进行程序设计，它提供了定义变量和参数的手段以及丰富的程序控制结构。使用shell编程类似于DOS中的批处理文件，称为shell script，又叫shell程序或shell命令文件。

 

基本语法
shell的基本语法主要就是如何输入命令运行程序以及如何在程序之间通过shell的一些参数提供便利手段来进行通讯。


1 shell文件开头
shell文件必须以下面的行开始（必须放在文件的第一行）： 

#!/bin/sh 
符号#!用来告诉系统它后面的参数是用来执行该文件的程序。在这个例子中我们使用/bin/sh来执行程序。 

当编辑好脚本时，如果要执行该脚本，还必须使其可执行。 要使脚本可执行：运行chmod +x filename 这样才能用./filename 来运行

执行shell程序文件有三种方法

# sh filename
# . filename
# source filename
 

2 注释 
在进行shell编程时，以#开头的句子表示注释，直到这一行的结束。我们建议您在程序中使用注释。如果您使用了注释，那么即使相当长的时间内没有使用该脚本，您也能在很短的时间内明白该脚本的作用及工作原理。


 

变量
像高级程序设计语言一样，shell也提供说明和使用变量的功能。对shell来讲，所有变量的取值都是一个字符串，shell程序采用$var的形式来引用名为var的变量的值。在shell编程中，不需要对变量进行声明，直接赋值就可以，应用变量的话，用$+变量名的形式。

Shell有以下几种基本类型的变量：

1 shell定义的环境变量

shell在开始执行时就已经定义了一些和系统的工作环境有关的变量，这些变量用户还可以重新定义，常用的shell环境变量有：


HOME：用于保存注册目录的完全路径名。
PATH：用于保存用冒号分隔的目录路径名，shell将按PATH变量中给出的顺序搜索这些目录，找到的第一个与命令名称一致的可执行文件将被执行。
TERM：终端的类型。
UID：当前用户的标识符，取值是由数字构成的字符串。
PWD：当前工作目录的绝对路径名，该变量的取值随cd命令的使用而变化。
PS1：主提示符，在特权用户下，缺省的主提示符是“#”，在普通用户下，缺省的主提示符是“$”。
PS2：在shell接收用户输入命令的过程中，如果用户在输入行的末尾输入“\”然后回车，或者当用户按回车键时shell判断出用户输入的命令没有结束时，显示这个辅助提示符，提示用户继续输入命令的其余部分，缺省的辅助提示符是“>”。
 

2 用户定义的变量

用户可以按照下面的语法规则定义自己的变量：


变量名=变量值
要注意的一点是，在定义变量时，变量名前不应加符号“$”，在引用变量的内容时则应在变量名前加“$”；在给变量赋值时，等号两边一定不能留空格，若变量中本身就包含了空格，则整个字符串都要用双引号括起来。

例如，要赋值给一个变量，您可以这样写： 

a="hello world" 
现在打印变量a的内容： 

echo "A is:" 
echo $a 
有时候变量名很容易与其他文字混淆，比如： 

num=2 
echo "this is the $numnd" 
这并不会打印出"this is the 2nd"，而仅仅打印"this is the "，因为shell会去搜索变量numnd的值，但是这个变量时没有值的。可以使用花括号来告诉shell我们要打印的是num变量： 

 

num=2 
echo "this is the ${num}nd" 
 

这将打印： this is the 2nd


在编写shell程序时，为了使变量名和命令名相区别，建议所有的变量名都用大写字母来表示。

有时我们想要在说明一个变量并对它设定为一个特定值后就不在改变它的值，这可以用下面的命令来保证一个变量的只读性：


readonly 变量名
在任何时候，建立的变量都只是当前shell的局部变量，所以不能被shell运行的其他命令或shell程序所利用，export命令可以将一局部变量提供给shell执行的其他命令使用，其格式为：

export 变量名
也可以在给变量赋值的同时使用export命令：

export 变量名=变量值
使用export说明的变量，在shell以后运行的所有命令或程序中都可以访问到。

 


3 位置变量(参数)

位置参数（positional parameters）指的是 shell 脚本的命令行参数（command line argument），同时也表示 shell 函数的函数参数。位置参数的名称是以单个整数来命名的。出于历史的原因，当这个整数大于 9 时（也就是包含两个或两个以上的阿拉伯数字），就应该使用花括号（{}）将其括起来。变量 ${nn} 表示第 nn 个位置参数；如不使用花括号，变量 $nn 的值不是第 nn 个位置参数的值，而是第 n 个位置参数的值后面加上 n。如变量 $1、$2、$9、${11} 分别表示第一个、第二个、第九个、第十一个位置参数，依次类推。位置参数是 shell 中唯一使用全部阿拉伯数字的特殊变量。

 

实例1：

假设 test.sh 文件的内容为：

#! /bin/bash

echo $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 ${10} ${11};
执行的命令行参数为：bash test.sh 1 2 3 4 5 6 7 8 9 11 12

执行后输出：

1 2 3 4 5 6 7 8 9 10 11 12

在这个结果中 $10=10，${10}=11，${11}=12。变量 $10 实际上是 $1 后面加一个 0，所以结果是 10。


和位置参数有关的几个特殊变量

$#

表示传递到 shell 脚本或函数的参数总数（也就是命令行参数或函数参数的总数）。当为了处理选项和参数而建立的循环时，这个变量非常有用。

 

$* $@

表示所有的命令行参数和函数参数。

 

"$*"

将所有的命令行参数和函数参数视为单个字符串。等同于 "$1 $2 ..."。

特殊变量 $IFS 的第一个字符用来作为分隔字符，通过不同的分隔字符来建立字符串。在使用 $IFS 时需要注意，这个变量是一个全局变量，在任何地方改变了其值，将立即生效。

 

"$@"

将所有的命令行参数和函数参数视为单个个体，也就是单独的字符串。等同于 "$1" "$2" ...。

这是将参数传递给其他程序（其他 shell 脚本、函数）的最佳方式，因为它会保留所有内嵌在每个位置参数里的任何空白。

 

实例1：

假设 test.sh 文件的内容为：

复制代码
#!/bin/bash
test_times=0;

test_positional_parameters()
{
printf "func \$test_times=%d\n" $((test_times++));
printf "func \$1=%s\n" $1;
printf "func \$2=%s\n" $2;
printf "func \$3=%s\n" $3;
printf "func \$#=%d\n" $#;
printf "func \$*=%s\n" $*;
printf "func \$@=%s\n" $@;
printf "func \$*=$*\n";
printf "func \"\$*\"=%s\n" "$*";
printf "func \"\$@\"=%s\n" "$@";
printf "====================\n";
}


test_positional_parameters $*;
test_positional_parameters $@;
test_positional_parameters "$*";
test_positional_parameters "$@";

printf "main \$1=%s\n" "$1";
printf "main \$2=%s\n" "$2";
printf "main \$3=%s\n" "$3";
printf "main \$#=%d\n" $#;
printf "main \$*=%s\n" $*;
printf "main \$@=%s\n" $@;
printf "main \$*=$*\n";
printf "main \"\$*\"=%s\n" "$*";
printf "main \"\$@\"=%s\n" "$@";
复制代码
 

运行 

[root@tang web_shell]# ./test.sh 1 4 5

func $test_times=0
func $1=1
func $2=4
func $3=5
func $#=3
func $*=1
func $*=4
func $*=5
func $@=1
func $@=4
func $@=5
func $*=1 4 5
func "$*"=1 4 5
func "$@"=1
func "$@"=4
func "$@"=5
====================
func $test_times=1
func $1=1
func $2=4
func $3=5
func $#=3
func $*=1
func $*=4
func $*=5
func $@=1
func $@=4
func $@=5
func $*=1 4 5
func "$*"=1 4 5
func "$@"=1
func "$@"=4
func "$@"=5
====================
func $test_times=2
func $1=1
func $1=4
func $1=5
func $2=
func $3=
func $#=1
func $*=1
func $*=4
func $*=5
func $@=1
func $@=4
func $@=5
func $*=1 4 5
func "$*"=1 4 5
func "$@"=1 4 5
====================
func $test_times=3
func $1=1
func $2=4
func $3=5
func $#=3
func $*=1
func $*=4
func $*=5
func $@=1
func $@=4
func $@=5
func $*=1 4 5
func "$*"=1 4 5
func "$@"=1
func "$@"=4
func "$@"=5
====================
main $1=1
main $2=4
main $3=5
main $#=3
main $*=1
main $*=4
main $*=5
main $@=1
main $@=4
main $@=5
main $*=1 4 5
main "$*"=1 4 5
main "$@"=1
main "$@"=4
main "$@"=5

 

4 预定义变量

预定义变量和环境变量相类似，也是在shell一开始时就定义了的变量，所不同的是，用户只能根据shell的定义来使用这些变量，而不能重定义它。所有预定义变量都是由$符和另一个符号组成的，常用的shell预定义变量有：

$# ： 传递到脚本的参数个数
$* ： 以一个单字符串显示所有向脚本传递的参数。与位置变量不同,此选项参数可超过 9个
$$ ： 脚本运行的当前进程 ID号
$! ： 后台运行的最后一个进程的进程 ID号
$@ ：与$*相同,但是使用时加引号,并在引号中返回每个参数
$- ： 显示shell使用的当前选项,与 set命令功能相同
$? ： 显示最后命令的退出状态。 0表示没有错误,其他任何值表明有错误。
$0 ： 当前执行的进程名
其中，“$?”用于检查上一个命令执行是否正确(在Linux中，命令退出状态为0表示该命令正确执行，任何非0值表示命令出错)。“$$”变量最常见的用途是用作临时文件的名字以保证临时文件不会重复。

复制代码
#!/bin/sh
#param.sh

# $0:文件完整路径名
echo "path of script : $0" 
# 利用basename命令文件路径获取文件名
echo "name of script : $(basename $0)"
# $1：参数1
echo "parameter 1 : $1"
# $2：参数2
echo "parameter 2 : $2"
# $3：参数3
echo "parameter 3 : $3"
# $4：参数4
echo "parameter 4 : $4"
# $5：参数5
echo "parameter 5 : $5"
# $#:传递到脚本的参数个数
echo "The number of arguments passed : $#"
# $*:显示所有参数内容i
echo "Show all arguments : $*"
# $:脚本当前运行的ID号
echo "Process ID : $"
# $?:回传码
echo "errors : $?"
复制代码
输入./param.sh hello world

复制代码
[firefox@fire Shell]$ ./param.sh hello world
path of script : ./param.sh
name of script : param.sh
parameter 1 : hello
parameter 2 : world
parameter 3 :
parameter 4 :
parameter 5 :
The number of arguments passed : 2
Show all arguments : hello world
Process ID : 5181
errors : 0
复制代码
 

 
引号
在向程序传递任何参数之前，程序会扩展通配符和变量。这里所谓扩展的意思是程序会把通配符（比如*）替换成合适的文件名，它变量替换成变量值。为了防 止程序作这种替换，您可以使用引号：让我们来看一个例子，假设在当前目录下有一些文件，两个jpg文件， mail.jpg 和tux.jpg。 
echo *.jpg
这将打印出"mail.jpg tux.jpg"的结果。 
引号 (单引号和双引号) 将防止这种通配符扩展： 
#!/bin/sh 
echo "*.jpg" 
echo '*.jpg' 
这将打印"*.jpg" 两次。 单引号更严格一些。它可以防止任何变量扩展。双引号可以防止通配符扩展但允许变量扩展。 

#!/bin/sh 
echo $SHELL 
echo "$SHELL" 
echo '$SHELL' 
运行结果为： 

/bin/bash 
/bin/bash 
$SHELL 
 
最后，还有一种防止这种扩展的方法，那就是使用转义字符——反斜杠： 
echo \*.jpg 
echo \$SHELL 
这将输出： 
*.jpg 
$SHELL
 
Here documents
HERE Document是bash里面定义块变量的途径之一。
定义的形式为： 

复制代码
命令<<HERE 

...

...

...

HERE
复制代码
它的作用即可以用来定义一段变量，会把命令和HERE之间的内容利用转向输入的方式交给该命令去处理。其中HERE相当于标记，可以是任何的字符串。

当要将几行文字传递给一个命令时，here documents是一种不错的方法。对每个脚本写一段帮助性的文字是很有用的，此时如果我们使用here documents技术就不必用echo函数一行行输出。 一个 Here document 以 << 开头，后面接上一个字符串(任意的)，假设是“robin”在你文本结束后，再用这个字符串(“robin”)追加一行，以表示文本结束。这个字符串我暂称之为边界区分字符串。
下面是一个例子：
复制代码
#!/bin/sh 
cat << HELP
ren -- renames a number of files using sed regular expressions 
USAGE: ren 'regexp' 'replacement' files... 
EXAMPLE: rename all *.HTM files in *.html: 
ren 'HTM$' 'html' *.HTM 
HELP
复制代码
 

函数
如果您写了一些稍微复杂一些的程序，您就会发现在程序中可能在几个地方使用了相同的代码，并且您也会发现，如果我们使用了函数，会方便很多。一个函数是这个样子的：
function name() 
{ 
　　# inside the body $1 is the first argument given to the function 
　　# $2 the second ... 
　　#body 
} 
 

您需要在每个程序的开始对函数进行声明。
下面是一个叫做xtitlebar的脚本，使用这个脚本您可以改变终端窗口的名称。这里使用了一个叫做help的函数。正如您可以看到的那样，这个定义的函数被使用了两次。 
复制代码
#!/bin/sh 
# vim: set sw=4 ts=4 et: 
help() 
{ 
cat << HELP
xtitlebar -- change the name of an xterm, gnome-terminal or kde konsole 
USAGE: xtitlebar [-h] "string_for_titelbar" 
OPTIONS: -h help text 
EXAMPLE: xtitlebar "cvs" 
HELP
exit 0 
} 
# in case of error or if -h is given we call the function help: 
[ -z "$1" ] && help 
[ "$1" = "-h" ] && help 
# send the escape sequence to change the xterm titelbar: 
echo $1
echo -e "33]0;"$1"07" 
#
复制代码
 

在脚本中提供帮助是一种很好的编程习惯，这样方便其他用户（和您）使用和理解脚本。命令行参数我们已经见过$* 和 $1, $2 ... $9 等特殊变量，这些特殊变量包含了用户从命令行输入的参数。迄今为止，我们仅仅了解了一些简单的命令行语法（比如一些强制性的参数和查看帮助的-h选项）。 但是在编写更复杂的程序时，您可能会发现您需要更多的自定义的选项。通常的惯例是在所有可选的参数之前加一个减号，后面再加上参数值 (比如文件名)。 有好多方法可以实现对输入参数的分析，但是下面的使用case表达式的例子无疑是一个不错的方法。 
文件test.sh
复制代码
#!/bin/sh 
help() 
{ 
cat << HELP
This is a generic command line parser demo. 
USAGE EXAMPLE: cmdparser -l hello -f somefile1 somefile2 
HELP
exit 0 
} 

while [ -n "$1" ]; do 
　　case $1 in 
　　-h) help;shift 1;; # function help is called 
　　-f) opt_f=1;shift 1;; # variable opt_f is set 
　　-l) opt_l=$2;shift 2;; # -l takes an argument -> shift by 2 
　　-*) echo "error: no such option $1. -h for help";exit 1;; 
　　*) break;; 
　　esac 
done


echo "opt_f is $opt_f" 
echo "opt_l is $opt_l" 
echo "first arg is $1" 
echo "2nd arg is $2" 
复制代码
您可以这样运行该脚本：

sh test.sh -l hello -f a b

返回的结果是： 

opt_f is 1
opt_l is hello
first arg is a
2nd arg is b
这个脚本是如何工作的呢？脚本首先在所有输入命令行参数中进行循环，将输入参数与case表达式进行比较，如果匹配则设置一个变量并且移除该参数。根据unix系统的惯例，首先输入的应该是包含减号的参数。
 
调试
最简单的调试命令当然是使用echo命令。您可以使用echo在任何怀疑出错的地方打印任何变量值。这也是绝大多数的shell程序员要花费80%的时间来调试程序的原因。Shell程序的好处在于不需要重新编译，插入一个echo命令也不需要多少时间。 
shell也有一个真实的调试模式。如果在脚本中有错误，您可以这样来进行调试： 
sh -x test.sh
这将执行该脚本并显示所有变量的值。 

shell还有一个不需要执行脚本只是检查语法的模式。可以这样使用：
sh -h test.sh
这将返回所有语法错误
