
## Shell 语法之用户输入
bash shell 提供了一些不同的方法从用户处获取数据，这些方法包括命令行参数、命令行选项和直接读取键盘输入。

 

命令行参数
bash shell 将在命令行中输入的所有参数赋值给一些特殊变量，称为位置参数，通过标准数据表示，其中$0为程序名称，$1为第一个参数，$2为第二个参数，依此类推，直到$9为第九个参数。在第九个变量之后，必须使用大括号将变量括起来，如${10}。

示例

#!/bin/bash
# using one command line parameter

factorial=1
for (( number=1; number<=$1; number++ ))
do
  factorial=$[ factorial * $number ]
done
echo The factorial of $1 is $factorial

 

调用：$ ./test1 5

The factorial of 5 is 120

 

读取程序名称

使用参数$0可以确定 shell 从命令行启动的程序的名称。

示例

#!/bin/bash
# testing the $0 parameter

echo The command entered is : $0

 

调用：./test5

 

如果需要去除通过命令行运行脚本时使用的所有路径，使用 basename 命令。

示例

#!/bin/bash
# using basename with the $0 parameter

name=`basename $0`
echo The command entered is: $name

 

调用：./test5b

The command entered is : ./test11-5

 

参数计数变量

特殊变量 $# 中存储执行脚本时包含的命令行参数的个数。

示例

#!/bin/bash
# testing parameters

if [ $# -ne 2 ]
then
  echo Uage: test11-9 a b
else
  total=$[ $1 + $2 ]
  echo The total is $total
fi

另外，使用变量 ${!#} 可以得到最后一个命令行参数值。注意不能使用 ${$#} 这种格式，否则会得到错误的结果。

 

调用：./test9 ×

调用：./test9 10 ×

调用：./test9 10 15 20  ×

Uage: test11-9 a b

调用：./test9 10 15  √ 

The total is 25

 

获取所有数据变量

变量 $* 将命令行中提供的所有参数作为一个单词处理。这个单词中包含出现在命令行中的每一个参数值。

变量 $@ 将命令行中提供的所有参数作为同一个字符串中的多个单词处理。允许对其中的值进行迭代，分隔开所提供的不同参数。

示例

#!/bin/bash
# testing $* and $@

count=1
for param in "$*"
do
  echo "\$* Parameter #$count= $param"
  count=$[ $count + 1 ]
done

count=1
for param in "$@"
do
  echo "\$@ Parameter #$count=$param"
  count=$[ $count + 1 ]
done

 

调用：./test12 rich barbara katie jessica

$*  Parameter #1=rich barbara katie jessica
$@ Parameter #1=rich
$@ Parameter #2=barbara
$@ Parameter #3=katie
$@ Parameter #4=jessica

 

 

命令行选项
选项是由破折号引导的单个字母，它更改命令的行为。

执行 shell 脚本时经常会遇到既需要使用选项又需要使用参数的情况。在 Linux 中的标准方式是使用特殊符号双破折号(--)将二者分开，这个特殊字符号码告诉脚本选项结束和普通参数开始的位置。

示例

#!/bin/bash
# extracting options and parameters

while [ -n "$1" ]
do
  case "$1" in
  -a) echo "Found the -a option" ;;
  -b) param="$2"
    echo "Found the -b option, with parameter value $param"
    shift 1 ;;
  -c) echo "Found the -c option" ;;
  --) shift
    break ;;
  *) echo "$1 is not an option" ;;
  esac
  shift
done

count=1
for param in $@
do
  echo "Parameter #$count: $param"
  count=$[ $count + 1 ]
done

 

调用：./test16 -c -a -b test1 test2 test3

Found the -c option
Found the -a option
Found the -b option, with parameter value test1
test2 is not an option
test3 is not an option

调用：./test16 -c -a -b -- test1 test2 test3

Found the -c option
Found the -a option
Found the -b option, with parameter value --
test1 is not an option
test2 is not an option
test3 is not an option

 

使用 getopt 命令

getopt 命令可以接受任意形式的命令行选项和参数列表，并自动将这些选项和参数转换为适当的格式。

格式：

  getopt options optstring parameters

optstring ：选项字符串，定义命令行中的有效选项字母。在每个需要参数值的选项字母后面放置一个冒号，如：

  getopt ab:cd -a -b test1 -cd -test2 -test3

当执行 getopt 命令时，会监测提供的参数列表，然后基于提供的选项字符串对列表进行解析。

  -a -b test1 -c -d test2 test3

如果指定的选项不在选项字符串中，默认会生成一个错误消息。

 getopt ab:cd -a -b test1 -cde test2 test3

getopt: invalid option -- e

-a -b test1 -c -d test2 test3

 

在脚本中使用 getopt

将原始脚本命令行参数送给 getopt 命令，然后将 getopt 命令的输出送给 set 命令：

 set -- `getopt -q ab:cd "$@"`

set 命令的一个选项是双破折号，表示将命令行参数变量替换为 set 命令的命令行中的值。

示例

#!/bin/bash
# extracting command line options and values with getopt

set -- `getopt -q ab:c "$@"`
while [ -n "$1" ]
do
case "$1" in
-a) echo "Found the -a option" ;;
-b) param="$2"
echo "Found the -b option, with parameter value $param"
shift ;;
-c) echo "Found the -c option" ;;
--) shift
break;;
*) echo "$1 is not an option";;
esac
shift
done

count=1
for param in "$@"
do
echo "Parameter #$count: $param"
count=$[ $count + 1 ]
done

 

调用：./test18 -ac

Found the -a option
Found the -c option

调用：./test18 -a -b test1 -cd test2 test3 test4

Found the -a option
Found the -b option, with parameter value 'test1'
Found the -c option
Parameter #1: 'test2'
Parameter #2: 'test3'
Parameter #3: 'test4'

 

高级的 getopts 命令

getopts 命令顺序的对现有的 shell 参数变量进行处理。非常适宜用在循环中解析所有命令行参数。

getopts 命令的格式为：

   getopts optstring variable

optstring 与 getopt 中的相似。如果要禁止输出错误消息，那么使选项字符串以冒号开头。

getopts 使用两个环境变量：

  OPTARG：包含需要参数值的选项要使用的值

  OPTIND：包含的值表示 getopts 停止处理时在参数列表中的位置

示例

#!/bin/bash
# processing options and parameters with getopts

while getopts :ab:cd opt
do
case "$opt" in
a) echo "Found the -a option" ;;
b) echo "Found the -b option, with value $OPTARG" ;;
c) echo "Found the -c option" ;;
d) echo "Found the -d option" ;;
*) echo "Unknown option: $opt" ;;
esac
done
shift $[ $OPTIND - 1 ]

count=1
for param in "$@"
do
echo "Parameter $count: $param"
count=$[ $count + 1 ]
done

 

调用：./test20 -a -b test1 -d test2 test3 test4

Found the -a option
Found the -b option, with value test1
Found the -d option
Parameter 1: test2
Parameter 2: test3
Parameter 3: test4

 

getopt 与 getopts 区别

getopt是个外部binary文件，而getopts是built-in。getopts 有两个参数，第一个参数是一个字符串，包括字符和“：”，每一个字符都是一个有效的选项，如果字符后面带有“：”，表示这个字符有自己的参数。 getopts从命令中获取这些参数，并且删去了“-”，并将其赋值在第二个参数中，如果带有自己参数，这个参数赋值在“OPTARG”中。提供getopts的shell内置了OPTARG这个变量，getopts修改了这个变量。而getopt则不能。因此getopt必须使用set来重新设定位置参数$1,$2....，然后在getopt中用shift的方式依次来获取。基本上，如果参数中可能含有空格，那么必须用getopts。否则仅仅从使用上看，他们没有区别。

键盘输入
 read 命令接受标准输入（键盘）的输入，或其他文件描述符的输入。

示例

#!/bin/bash
# testing the read command

echo -n "Enter your name: "
read name
echo "Hello $name, welcome to my program."

 

调用：./test21

Enter your name: vian
Hello vian, welcome to my program.

 

在 read 命令包含 -p 选项，允许在 read 命令行中直接指定一个提示

示例

#!/bin/bash
# testing the read -p option

read -p "Please enter your age: " age
days=$[ $age * 365 ]
echo "That makes you over $days days old!"

 

调用：./test22

Please enter your age: 18
That makes you over 6570 days old!

 

在 read 命令行中也可以不指定变量。如果不指定变量，那么 read 命令会将接收到的数据放置在环境变量 REPLY 中

示例

#!/bin/bash
# testing the REPLY environment variable

read -p "Enter a number:"
factorial=1
for (( count=1; count<= $REPLY; count++ ))
do
factorial=$[ $factorial * $count ]
done
echo "The factorial of $REPLY is $factorial"

 

调用：./test24

Enter a number:12
The factorial of 12 is 479001600

 

计时功能

使用 -t 选项指定 一个计时器。

示例

#!/bin/bash
# timing the data entry

if read -t 5 -p "Please enter your name: " name
then
echo "Hello $name, welcome to my script"
else
#echo
echo "Sorry, too slow!"
fi

 

调用：./test25

Please enter your name: ivan
Hello ivan, welcome to my script

 

除了输入时间计时，还可以设置 read 命令计数输入的字符。

示例

#!/bin/bash
# getting just one character of input

read -n1 -p "Do you want to continue [Y/N]? " answer
case $answer in
Y | y) echo
echo "fine, continue on..." ;;
N | n) echo
echo "OK, goodbye"
exit;;
esac
echo "This is the end of the script"

 

调用：./test26

Do you want to continue [Y/N]? y
fine, continue on...
This is the end of the script

 

默读

-s 选项能够使输入数据不显示在屏幕上。

示例

#!/bin/bash
# hiding input data from the monitor

read -s -p "Enter your password: " pass
echo
echo "Is your password really $pass?"

 

调用：./test27

Enter your password:
Is your password really abc?

 

读取文件

读取文件的关键是如何将文件中的数据传送给 read 命令。

示例

#!/bin/bash
# reading data from a file

count=1
cat states | while read line
do
echo "Line $count: $line"
count=$[ $count + 1 ]
done
echo "Finished processing the file"

 

调用：./test28

Line 1: Alabama
Line 2: Alaska
Line 3: Arizona
Line 4: Arkansas
Line 5: Colorado
Line 6: Connecticut
Line 7: Florida
Line 8: Georgia
Finished processing the file
