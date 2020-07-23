
## Shell 语法之输入输出
 

Linux 使用文件描述符标识每个文件对象。文件描述符是一个非负整数，可以唯一地标识会话中打开的文件。每个进程中最多可以有9个打开文件的描述符。

**Linux 标准文件描述符**

|  文件描述符　|　  缩写 　　|　　描述  |
| ------- | --------- | ------------|
|0  　　|STDIN  　　 |标准输入|
|1  　　|STDOUT  　  |标准输出|
|2  　　|STDERR  　　|标准错误|

 

* STDIN 文件描述符引用 shell 的标准输入。
* STDOUT 文件描述符引用 shell 的标准输出。
* STDERR 文件描述符处理错误消息。

可以将 STDEER 和 STDOUT 输出重定向到同一个输出文件，使用 `&>` 符号

    ls -al test test2 test3 badtet &> test7
或者

`command>&file`：将命令的标准错误输出一起重定向到一个文件。

    find /etc -name passwd >alloutlput 2>&1
将标准输出、错误输出都存入到alloutout文件中

 
### 在脚本中重定向输出
在脚本中使用文件描述符在多个位置生成输出，只要重定向相应的文件描述符即可。

 

在文件描述符编号前面添加 & 号，表示在脚本的文件描述符指向的地方而不是普通的 STDOUT 上显示文本。

示例

#!/bin/bash
# testing STDEERR messages

echo "This is an error" >&2
echo "This is normal output"

 

使用 exec 命令通知 shell 在脚本执行期间重定向特定的文件描述符

示例

#!/bin/bash
# redirecting output to different locations

exec 2>testerror

echo "This is the start of the script"
echo "now redirecting all output to another location"

exec 1>testout

echo "This output should go to the testout file"
echo "but this should go to the testerror file" >&2

[root@tang sh]# ./test12-11
This is the start of the script
now redirecting all output to another location

 

在脚本中重定向输入
示例

#!/bin/bash
# redirecting file input

exec 0< states
count=1

while read line
do
echo "Line #$count: $line"
count=$[ $count + 1 ]
done

[root@tang sh]# ./test12-12
Line #1: Alabama
Line #2: Alaska
Line #3: Arizona
Line #4: Arkansas
Line #5: Colorado
Line #6: Connecticut
Line #7: Florida
Line #8: Georgia

 

自定义输出文件描述符
shell 中最多有9个打开的文件描述符，可以将其余的文件描述符应用到任何文件，然后在脚本中作用它们。

示例

#!/bin/bash
# using an alternative file descriptor

exec 3>test3out

echo "this should display on the monitor"
echo "and this should be stored in teh file" >&3
echo "then this should be back on the monitor"

[root@tang sh]# ./test12-13
this should display on the monitor
then this should be back on the monitor

 

重定向文件描述符
可以将 STDOUT 的原位置重定向到备选文件描述符，然后将该文件描述符重定向加 STDOUT。

示例

#!/bin/bash
# storing STDOUT, then coming back to it

exec 3>&1
exec 1>test14out

echo "this should store in the output file"
echo "along with this line."

exec 1>&3

echo "now things should be back to normal" 

[root@tang sh]# ./test12-14
now things should be back to normal

 

自定义输入文件描述符
示例

#!/bin/bash
# redirecting input file descriptors

exec 6<&0

exec 0<states

count=1
while read line
do
echo "Line #$count: $line"
count=$[ $count + 1 ]
done

exec 0<&6
read -p "Are you done now?" answer
case $answer in
Y|y) echo "Goodby" ;;
N|n) echo "Sorry, this is the end." ;;
esac

 

关闭文件描述符
如果创建新的输入或输出文件描述符， shell 将在脚本退出时自动关闭它们。有时需要在脚本结束前手动关闭文件描述符。

要关闭文件描述符，将它重定向到特殊符号 &- 。

示例

#!/bin/bash
# testing closing file descriptors

exec 3>test17file
echo "This is a test line of data" >&3
exec 3>&-

cat test17file

exec 3>test17file
echo "This'll be bad" >&3

 

列出开放文件描述符
lsof 命令列出整个 Linux 系统上所有的开放文件描述符。

-p 指定进程 ID

-d 指定要显示的文件描述符编号

-a 连接其他两个选项的结果

示例

#!/bin/bash
# testing lsof with file descriptors

exec 3>test18file1
exec 6>test18file2
exec 7<states

/usr/sbin/lsof -a -p $$ -d0,1,2,3,6,7

 

禁止命令输出
如果不希望显示任何脚本输出，可以将 STDERR 重定向到称为空文件的特殊文件。

示例

ls -al > /dev/null
 

可以使用 /dev/null 文件作为输入文件用于输入重定向，由于 /dev/null 文件不包含任何内容，可以使用它快速将数据从现有文件移除。

cat /dev/null > testfile
 

 

创建临时文件
mktemp 命令可以轻松在 /tmp 文件夹中创建一个唯一的临时文件。

默认情况下，mktemp 在本地目录创建文件，需要指定一个文件名模板。模板包括文件名以及附加到文件名后的6个X。mktemp 命令的输出是它所创建的文件的名称。

示例

#!/bin/bash
# creating and using a temp file

tempfile=`mktemp test19.XXXXXX`
exec 3>$tempfile

echo "This scrit writes to temp file $tempfile"

echo "This is the first line" >&3
echo "This is the second line." >&3
exec 3>&-

echo "Done creating temp file. The contents are:"
cat $tempfile
rm -f $tempfile 2>/dev/null

 

-t 选项强迫 mktemp 在系统的临时文件夹中创建文件。

示例

#!/bin/bash
# creating a temp file in /tmp

tempfile=`mktemp -t tmp.XXXXXX`
echo "This is a test file" > $tempfile
echo "This is the second line of the test." >> $tempfile

echo "The temp file is located at: $tempfile"
cat $tempfile
rm -f $tempfile

 

-d 选项让 mktemp 创建一个临时目录而不是一个文件。

示例

#!/bin/bash
# using a temporary directory

tempdir=`mktemp -d dir.XXXXXX`
cd $tempdir
tempfile1=`mktemp temp.XXXXXX`
tempfile2=`mktemp temp.XXXXXX`
exec 7>$tempfile1
exec 8>$tempfile2

echo "Sending data to directory $tempdir"
echo "This is a test line of data for $tempfile1" >&7
echo "This is a test line of data for $tempfile2" >&8

 

记录消息
使用 tee 命令将输出同时发送到监视器和日志文件。

tee 命令重定向来自 STDIN 的数据，可以与管道命令配置使用重定向任何命令的输出。

示例

#!/bin/bash
# using the tee command for logging

tempfile=test22file

echo "this is the start of the test" | tee $tempfile
echo "this is the second line of the test" | tee -a $tempfile
echo "this is the end of the test" | tee -a $tempfile
