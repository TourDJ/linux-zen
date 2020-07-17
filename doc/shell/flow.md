
## Shell 语法之结构化命令(流程控制)
许多程序在脚本命令之间需要某种逻辑流控制，允许脚本根据变量值的条件或者其他命令的结果路过一些命令或者循环执行这些命令。这些命令通常被称为结构化命令。和其他高级程序设计语言一样，shell提供了用来控制程序执行流程的命令，包括条件分支和循环结构，用户可以用这些命令建立非常复杂的程序。与传统的语言不同的是，shell用于指定条件值的不是布尔表达式而是命令和字符串。
 
### 分支条件
 
Linux 提供 \$? 特殊变量来保存最后一条命令执行结束的退出状态。如果想核对一条命令的退出状态，必须在这条命令运行完成后立即查看或使用变量 $?。一条命令成功完成的退出状态是 0，如果命令执行错误，那么退出状态就会是一个正整数。
Linux退出状态代码
代码  　　　　描述
0 　　　　命令成功完成
1 　　　　通常的未知错误
2 　　　　误用 shell 命令
126 　　  命令无法执行
127 　　  没有找到命令
128 　　  无效的退出参数
128+x 　 Linux 信号 x 的致使错误
255 　　  规范外的退出状态
 
 
if-then语句
在其他编程语言中，if 语句后面的对象是一个值为 TRUE 或 FALSE 的等式。 bash shell脚本中的 if 语句不是这样的。 bash shell 中的 if 语句运行在 if 行定义的命令。如果命令的退出状态是0(成功执行命令)，将执行 then 后面的所有命令。如果命令的退出状态是0以外的其他值，那么then后面的命令将不会执行， bash shell 会移动到脚本的下一条命令。
 
格式：
  if command
  then
       commands
  fi
 
示例
#!/bin/bash
#  testing multiple commands in the then section
testuser=rich
if grep $testuser /etc/passwd
then
  echo The bash files for user $testuser are :
  ls -a /home/$testuser/.b*
fi

注意：在一些脚本中，可能会看到 if-then 语句的另一种形式：
if command; then
  commands
fi
在计值的命令末尾使用一个分号，可以将 then 语句包含在此行中，这更像是在其他一些编程语言中处理 if-then 语句的方式。
 
if-then-else
格式：
if command
then
    commands
else
    commands
fi
示例 
#!/bin/bash
#testing multiple commands in the then section
testuser=rich
if grep $testuser /etc/passwd
then
  echo The bash files for user $testuser are:
  ls -a /home/$testuser/.b*
else
  echo "The user name $testuser doesn't exist on this system"
fi

 

嵌套 if 语句
格式：
if command1
then
  commands
elif  command2
then
  more commands
fi
示例
#!/bin/bash
# looking for a possible value
 
if [ $USER = "rich" ]
then
  echo "Welcome $USER"
  echo "Please enjoy your visit"
elif [ $USER = barbara ]
then
  echo "Special testing account" 
else
  echo "Sorry, you're not allowed here" 
fi
 
 
test命令
test命令提供一种检测 if-then 语句中不同条件的方法。如果test命令中的条件评估值为true，test命令以0退出状态代码退出，如果条件为false，则test命令退出。
 
test 命令格式：
  test condition
condition 是一系列 test命令评估的参数和值。
 
在 if-then 语句中使用时，test命令如下所示：
if test condition
then
  commands
fi
 
bash shell 提供一种在 if-then 语句中声明 test 命令的另一种方法：
if [ condition ]
then
   commands
fi
方括号定义在 test 命令中使用的条件。注意，在前半个方括号的后面和后半个方括号的前面必须都有一个空格，否则会得到错误信息。
 
test 命令能够评估以下3类条件：

(1)数值比较：
n1 -eq n2：检查 n1 是否等于 n2
n1 -ge n2：检查 n1 是否大于或等于 n2
n1 -gt n2：检查 n1 是否大于 n2
n1 -le n2： 检查 n1 是否小于或等于 n2
n1 -lt n2： 检查 n1 是否小于 n2
n1 -ne n2：检查 n1 是否不等于 n2
示例
#!/bin/bash
# testing floating point numbers
val1=` echo "scale=4; 10 / 3 " | bc`
echo "The test value is $val1"
if [ $val1 -gt 3 ]
then
   echo "The result is larger than 3"
fi
注意：test 命令无法处理存储在变量 val1 中的浮点值。

(2)字符串比较：
str1 = str2：检查 str1 与 str2 是否相同
str1 != str2：检查 str1 与 str2 是否不同
str1 < str2：检查 str1 是否小于 str2
str1 > str2: 检查 str1 是否大于 str2
-n str1：检查 str1 的长度是否大于0
-z str1：检查 str1 的长度是否为0
字符串相等
示例
#!/bin/bash
# testing string equality
testuser=rich
 
if [ $USER = $testuser ]
then
   echo "Welcom $ testuser"
fi
 
字符串顺序
大于和小于符号一定要转义，否则 shell 会将它们当作重定向符号，将字符串值看作文件名。
大于和小于顺序与在 sort 命令中的顺序不同。
示例
#!/bin/bash
# mis-using string comparisons
 
var1=baseball
var2=hockkey
 
if [ $val1 > $ val2 ]
then
   echo "$val1 is greater than $var2"
else
   echo "$val1 is less than $var2"
fi
 
字符串大小
示例
#!/bin/bash
# testing string length
val1=testing
val2=''
 
if [ -n $val1 ]
then
   echo "The string '$val1' is not empty"
else
   echo "The string '$val1' is empty"
fi
 
if [ -z $val2 ]
then
   echo "The string '$val2' is not empty"
else
   echo "The string '$val2' is empty"
fi
 
if [ -z $val3 ]
then
   echo "The string '$val3' is not empty"
else
   echo "The string '$val3' is empty"
fi
空变量和没有初始化的变量长度为0。
 

(3)文件比较：
-d 文件名：  如果文件存在且为目录则为真
-e 文件名：   如果文件存在则为真
-f 文件名：  如果文件存在且为普通文件则为真
-r 文件名：　如果文件存在且可读则为真
-s 文件名：  如果文件存在且至少有一个字符则为真
-w 文件名：  如果文件存在且可写则为真
-x 文件名：  如果文件存在且可执行则为真
-o file ： 检查 file 是否存在并且被当前用户拥有
-G file：检查 file 是否存在并且默认组是否为当前用户组
-c 文件名：  如果文件存在且为字符型特殊文件则为真
-b 文件名：  如果文件存在且为块特殊文件则为真
file1 -ot file2 若 file 旧于 file2，则条件成立
 
示例 
 #!/bin/bash
# check if a file
if [ -e $HOME ]
then 
   echo "The object exists, is it a file?"
   if [ -f $HOME]
   then
     echo "Yes, it's a file!"
   else
     echo "No, it's not a file!"
     if [ -f $HOME/.bash_history]
     then
       echo "But this is a file!"
     fi
  fi
else
   echo "Sorry, the object doesn't exists"
fi
 
复合条件检查 
  [ condition1 ] && [ condition2 ]

两个条件必须都满足才能执行 then 部分

  [ condition1 ] || [ condition2 ] 

如果任意一个条件评估为 true，那么就会执行 then 部分

示例
#!/bin/sh 
mailfolder=/var/spool/mail/james 
[ -r "$mailfolder" ]||{ echo "Can not read $mailfolder" ; exit 1; } 
echo "$mailfolder has mail from:" 
grep "^From " $mailfolder
该脚本首先判断mailfolder是否可读。如果可读则打印该文件中的"From" 一行。如果不可读则或操作生效，打印错误信息后脚本退出。这里有个问题，那就是我们必须有两个命令： 
  -打印错误信息 
  -退出程序 
我们使用花括号以匿名函数的形式将两个命令放到一起作为一个命令使用。一般函数将在下文提及。 不用与和或操作符，我们也可以用if表达式作任何事情，但是使用与或操作符会更便利很多。
 
 
if-then 高级特征
双圆括号
((  expression ))
表示数学表达数，允许在比较中包含高级数学公式。除了 test 命令使用的标准数学操作符，还包括：
 符号     　　描述
val++ 　　后增量
val--  　　后减量
++val 　　前增量
--val  　　前减量
! 　　　　逻辑否定
~ 　　　  逐位取反
** 　　　 取幂
<< 　　   左移
>> 　　   右移
&           
|
&& 　　   逻辑与
||  　　    逻辑或
 
示例
if (( $val1 ** 2 > 90 ))
then
   (( val2 = $val1 ** 2 ))
   echo "The square of $val1 is $val2"
fi
 
双方括号
[[ expression ]]
双括号命令提供了模式匹配。
示例
if [[ $USER == r* ]]
then
  echo "Hello $USER"
else
  echo "Sorry, I don't know you"
fi
 
case命令
case 命令以列表导向格式检查单个变量的多个值。
case variable in 
pattern1 | pattern2) commands1 ;; 
pattern3) commands2;;
*) default commands;;
esac
case 命令将指定的变量与不同的模式进行比较。如果变量与模式匹配，shell 执行为该模式指定的命令。可以在一行中列出多个模式，使用竖条操作符将每个模式分开。星号是任何列出的模式都不匹配的所有值。

以下是一个使用case的实例：

dirs=`ls $sourceRoot/android | tr '\n' ' '`
for i in $dirs
do
sourceFold=$sourceRoot/android/${i}
case ${i} in 
out)
echo "skip ${i}";;
kernel|frameworks|vendor|build)
cp -rfu $sourceFold $workRoot/android
echo "copy ${i}";;
*) 
ln -sf $sourceFold $workRoot/android
echo "linking ${i}";;
esac
done
再让我们看一个例子。 file命令可以辨别出一个给定文件的文件类型，比如： 

file lf.gz 
这将返回： 
lf.gz: gzip compressed data, deflated, original filename, 
last modified: Mon Aug 27 23:09:18 2001, os: Unix 
下面有个叫做smartzip的脚本，该脚本可以自动解压bzip2, gzip 和zip 类型的压缩文件： 
#!/bin/sh 
ftype=`file "$1"` 
case "$ftype" in 
"$1: Zip archive"*) 
unzip "$1" ;; 
"$1: gzip compressed"*) 
gunzip "$1" ;; 
"$1: bzip2 compressed"*) 
bunzip2 "$1" ;; 
*) echo "File $1 can not be uncompressed with smartzip";; 
esac 
您可能注意到我们在这里使用了一个特殊的变量$1。该变量包含了传递给该程序的第一个参数值。
也就是说，当我们运行： 
smartzip articles.zip 
$1 就是字符串 articles.zip
 
 
循环结构 
for命令
for 命令用于通过一系列值重复的循环。每次重复使用系列中的一个值执行一个定义的命令集。

格式：

for var in list

do

  commands

done

在参数 list 中提供一系列用于迭代的值。for 循环认为每个值都用空格分隔。

 

注意：可以将 do 语句与 for 语句放在同一行，但是必须使用分号将它与列表项分开：

  for var in list; do

 

列表值中包含单引号的处理方法

使用转义字符（反斜杠符号）来转义单引号
使用双引号来定义使用单引号的值
 

内部字段分隔符(internal field separator, IFS)定义了 bash shell 用作字段分隔符的字符列表。默认情况下，bash shell 将下面的字符看作字段分隔符。

空格
制表符
换行符
如果处理能够包含空格的数据时，就会产生干扰，可以在 shell 脚本中暂时更改环境变量 IFS 的值，限制 bash shell 看作是字段分隔符的字符。

示例

#!/bin/bash
# reading values from a file

file="states"

IFS=$'\n'
for state in `cat $file`
do
  echo "Visit beautiful $state"
done

 

使用通配符读取目录或处理多目录

示例

#!/bin/bash
# iterate through all the files in a directory

for file in /home/txj/* /home/txj/.b*
do
if [ -d "$file" ]
then
echo "$file is a directory"
elif [ -f "$file" ]
then
echo "$file is a file"
fi
done

 

C式 for 循环
格式

for (( variable assignment ;  condition ;  iteration process ))

有几项不遵循标准 bash shell 的 for 方法

变量的赋值可以包含空格
条件中的变量不以美元符号做前缘
迭代处理式不使用 expr 命令格式
示例

#!/bin/bash
# multiple variables

for (( a=1, b=10; a<=10; a++,b-- ))
do
echo "$a - $b"
done

 

 

while 命令
while 命令格式

while test command

do

  other commands

done

在 while 命令中定义的 test 命令与在 if-then 语句中定义的格式一样。while 关键是指定的 test 命令的退出状态必须根据循环中命令的运行情况改变。

示例

#!/bin/bash
# while command test

var1=10
while [ $var1 -gt 0 ]
do
echo $var1
var1=$[ $var1 - 1 ]
done

 

如果有多条 test 命令，只有最后一条测试命令的退出状态是用来决定循环是何时停止的。

#!/bin/bash
# tesing a multicommand while loop

var1=10

while echo $var1
        [ $var1 -ge 0 ]
do
echo "This is inside the loop"
var1=$[ $var1 - 1 ]
done

  

until 命令
until 命令刚好与 while 命令相反。

格式：

until test commands

do 

  other commands

done

until  命令需要制定一条测试命令，这条命令通常产生一个非0的退出状态。只要测试命令的退出状态非0， bash shell就会执行列在循环当中的命令。一旦测试条件返回0退出状态，循环停止。

示例

#!/bin/bash
# using the until command

var1=100

until [ $var1 -eq 0 ]
do
echo $var1
var1=$[ $var1 - 25 ]
done

 

嵌套循环

通常需要迭代存储在文件内部的项。需要结合两种技术：

使用嵌套循环
更改环境变量 IFS
示例

#!/bin/bash
# changing the IFS value
IFSOLD=$IFS
IFS=$'\n'
for entry in `cat /etc/passwd | grep ro `
do
echo "Values in $entry -"
IFS=:
for value in $entry
do
echo " $value"
done
done

 

break 命令
break 命令是在处理过程中跳出循环的一种简单方法。

示例

#!/bin/bash
# breaking out of a for loop

for var1 in 1 2 3 4 5 6 7 8 9 10
do
if [ $var1 -eq 5 ]
then
break
fi
echo "Iteration number: $var1"
done
echo "The for loop is completed"

 

break 命令包括单独的命令行参数值

break n

示例

#!/bin/bash
# breaking out of an outer loop

for (( a=1; a<4; a++ ))
do
echo "Outer loop: $a"
for (( b=1; b<100; b++ ))
do
if [ $b -gt 4 ]
then
break 2
fi
echo " Inner loop: $b"
done
done

 

continue 命令
continue 命令是一种提前停止循环内命令，而不完全终止循环的方法。

示例

#!/bin/bash
# continuing an outer loop

for (( a=1; a<=5; a++ ))
do
echo "Iteration $a:"
for (( b=1; b<3; b++ ))
do
if [ $a -gt 2 ] && [ $a -lt 4 ]
then
continue 2
fi
var3=$[ $a * $b ]
echo " The result of $a * $b is $var3"
done
done

 

循环的输出
可以通过在 done 命令的末尾添加管道或重定向循环的输出结果。

示例

#!/bin/bash
# redirecting the for output to a file

for (( a=1; a<10; a++ ))
do
echo "The number is $a"
done > test10-23.txt

 
移位(shift) 
shift命令能够改变命令行参数的相对位置。使用 shift 命令时，默认将每个参数变量左移一个位置。

示例 

#!/bin/bash
# demonstrating the shift command

count=1
while [ -n "$1" ]
do
echo "Parameter #$count = $1"
count=$[ $count + 1 ]
shift
done

 
select
格式

select variable in list

do

    commands

done

类别参数是用空格隔开的构建菜单的文本项列表。select 命令将列表中的每一项显示为一个编号选项，然后为选择显示一个特殊的提示符(由 PS3 环境变量定义)。

示例

#!/bin/sh
echo "What is your favourite OS?"
select var in "Linux" "Gnu Hurd" "Free BSD" "Other"

do
  break
done
echo "You have selected $var"

下面是该脚本运行的结果： 

What is your favourite OS? 
1) Linux 
2) Gnu Hurd 
3) Free BSD 
4) Other 
#? 1 
You have selected Linux
 
--------------------------------------------------------------------------


repeat语句
repeat语句是tcsh提供的独有的循环语句.使用repeat命令要求shell对一个命令执行一定的次数.
语法格式:
　　repeat count command
如;
foreach num ( $ *)
repeat $num echo -n " *"
echo " "
end
