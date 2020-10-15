
## Shell 语法之函数
函数是被赋予名称的脚本代码块，可以在代码的任意位置重用。每当需要在脚本中使用这样的代码块时，只需引用该代码块被赋予的函数名称。

### 创建函数

格式
```shell
[ function ] name [()]
{
    commands;
    [return int;]
}
```
> 说明：              
  1、可以带`function name()` 定义，也可以直接 `name()` 定义,不带任何参数。             
  2、name 属性定义了该函数的唯一名称。name 后面要有空格。                       
  3、`commands` 是组成函数的一条或多条 bash shell 命令。            
  4、参数返回，可以显式加 `return` 返回，如果不加，将以最后一条命令运行结果，作为返回值。 return后跟数值n(0-255)             

常用格式：
```shell
function name {
　　commands
}
```
另一种格式 
```shell
name() {
　　commands
}
```
示例
```shell
#!/bin/bash
# using a function in a script

function func1 {
  echo "This is an example of a function"
}

count=1
while [ $count -le 5 ]
do
  func1
  count=$[ $count + 1 ]
done

echo "This is the end of the loop"
func1
echo "Now this is the end of the script"
```
调用

    [root@tang sh14]# ./test1
    This is an example of a function
    This is an example of a function
    This is an example of a function
    This is an example of a function
    This is an example of a function
    This is the end of the loop
    This is an example of a function
    Now this is the end of the script

> 注意：如果在函数定义之前使用函数，会得到错误消息。如果重新定义函数，那么新定义将取代函数原先的定义。

 

### 函数返回值

#### 默认退出状态

默认情况下，函数的退出状态是函数的最后一条命令返回的退出状态。

示例
```shell
#!/bin/bash
# testing the exit status of a function

func1() {
  echo "trying to display a non-existent file"
  ls -l badfile
}

echo "testing the function:"
func1
echo "The exit status is: $?"
```
调用

    [root@tang sh14]# ./test4
    testing the function:
    trying to display a non-existent file
    ls: badfile: No such file or directory
    The exit status is: 2


#### 使用 return 命令

`return` 命令可以使用单个整数值来定义函数退出状态，提供了一种通过编程设置函数退出状态的简单方法。

示例
```shell
#!/bin/bash
# using the return command in a function

function db1 {
  read -p "Enter a value: " value
  echo "doubling the value"
  return $[ $value * 2]
}

db1
echo "The new value is $?"
```
调用

    [root@tang sh14]# ./test5
    Enter a value: 10
    doubling the value
    The new value is 20

> 注意：请记住在函数完成后尽快提取返回值,请记住退出状态的取值范围是0~255

 

### 使用函数输出

正如命令输出可以捕获并存放到 shell 变量中一样，函数的输出也可以捕获并存放到 shell 变量中。

示例
```shell
#!/bin/bash
# using the echo to return a value

function db1 {
　　read -p "Enter a value: " value
　　echo $[ ($value) * 2 ]
}

result=`db1`
echo "The new value is $result"
```
调用

    [root@tang sh14]# ./test5b
    Enter a value: 1
    The new value is 2 


### 向函数传递参数

函数可以使用标准参数环境变量来表示命令行传递给函数的参数。

函数名在变量 $0 中定义， 函数命令行的其他参数使用变量 $1、$2...,专有变量$#可以用来确定传递给函数的参数数目。

示例
```shell
#!/bin/bash
# passing parameters to a function

function addem {
　　if [ $# -eq 0 ] || [ $# -gt 2 ]
　　then
　　　　echo -1
　　elif [ $# -eq 1 ]
　　then
　　　　echo $[ $1 + $1 ]
　　else
　　　　echo $[ $1 + $2 ]
　　fi
}

echo -n "Adding 10 and 15: "
value=`addem 10 15`
echo $value
echo -n "Let's try adding just one number: "
value=`addem 10`
echo $value
echo -n "Now trying adding no numbers: "
value=`addem`
echo $value
echo -n "Finally, try adding three numbers: "
value=`addem 10 15 20`
echo $value
```
调用

    [root@tang sh14]# ./test6
    Adding 10 and 15: 25
    Let's try adding just one number: 20
    Now trying adding no numbers: -1
    Finally, try adding three numbers: -1 

 

由于函数为自己的参数值使用专用的参数环境变量，所以函数无法从脚本命令行直接访问脚本参数值。如果想在函数中使用这些值，那么必须在调用该函数时手动传递这些数据。

示例
```shell
#!/bin/bash
# trying to access script parameters inside a function

function func7 {
　　echo $[ $1 * $2 ]
}

if [ $# -eq 2 ]
then
　　value=`func7 $1 $2`
　　echo "The result is $value"
else
　　echo "Usage: badtest1 a b"
fi
```
调用

    [root@tang sh14]# ./test7
    Usage: badtest1 a b

    [root@tang sh14]# ./test7 2 6
    The result is 12

 

### 在函数中使用变量

全局变量是在 shell 脚本内处处有效的变量。

示例
```shell
#!/bin/bash
# using a global variable to pass a value

function db1 {
　　value=$[ $value * 2 ]
}

read -p "Enter a value: " value
db1
echo "The new value is: $value"
```
调用

    [root@tang sh14]# ./test8
    Enter a value: 10
    The new value is: 20

局部变量是在函数内部使用的变量，在变量声明前面冠以 local 关键字。

如果脚本在函数外部有同名变量，那么 shell 将能区分开这两个变量。

示例
```shell
#!/bin/bash
# demonstrating the local keyword

function func1 {
　　local temp=$[ $value + 5 ]
　　result=$[ $temp * 2 ]
}

temp=4
value=6

func1
echo "The result is $result"


if [ $temp -gt $value ]
then
　　echo "temp is larger"
else
　　echo "temp is smaller"
fi
```
调用

    [root@tang sh14]# ./test9
    The result is 22
    temp is smaller

### 向函数传递数组

如果试图将数组变量作为函数参数使用，那么函数只提取数组变量的第一个取值。

示例
```shell
#!/bin/sh
# array variable to function test

function testit {
　　local newarray
　　newarray=("$@")
　　echo "The new array value is: ${newarray[*]}"
}

myarray=(1 2 3 4 5)
echo "The original array is ${myarray[*]}"
testit ${myarray[*]}
```
调用

    [root@tang sh14]# ./test10
    The original array is 1 2 3 4 5
    The new array value is: 1 2 3 4 5

必须将数组变量拆分为单个元素，然后使用这些元素的值作为函数参数。

 

### 函数内部使用数组

示例
```shell
#!/bin/bash
# adding values in an array

function addarray {
　　local sum=0
　　local newarray
　　newarray=(`echo "$@"`)
　　for value in ${newarray[*]}
　　do
　　　　sum=$[ $sum + $value ]
　　done
　　echo $sum
}

myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
arg1=`echo ${myarray[*]}`
result=`addarray $arg1`
echo "The result is $result"
```
调用

    [root@tang sh14]# ./test11
    The original array is: 1 2 3 4 5
    The result is 15

 

### 从函数返回数组

示例
```shell
#!/bin/sh
# returning an array value

function arraydblr {
　　local origarray
　　local newarray
　　local elements
　　local i
　　origarray=(`echo "$@"`)
　　newarray=(`echo "$@"`)
　　elements=$[ $# - 1 ]
　　for(( i=0; i<=elements; i++ ))
　　{
　　　　newarray[$i]=$[ ${origarray[$i]} * 2 ]
　　}
　　echo ${newarray[*]}
}

myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
arg1=`echo ${myarray[*]}`
result=(`arraydblr $arg1`)
echo "The new array is: ${result[*]}"
```
调用

    [root@tang sh14]# ./test12
    The original array is: 1 2 3 4 5
    The new array is: 2 4 6 8 10

 

### 函数递归

示例
```shell
#!/bin/sh
# using recursion

function factorial {
　　if [ $1 -eq 1 ]
　　then
　　　　echo 1
　　else
　　　　local temp=$[ $1 - 1 ]
　　　　local result=`factorial $temp`
　　　　echo $[ $1 * $result ]　　
　　fi
}

read -p "Enter value: " value
result=`factorial $value`
echo "The factorial of $value is: $result"
```
调用

    [root@tang sh14]# ./test13
    Enter value: 5
    The factorial of 5 is: 120

 

### 创建库

创建函数的库文件，可以在不同脚本中引用该库文件。

其难点在于 shell 函数的作用域。与环境变量一样，shell 函数仅在其定义所处的 shell 会话中有效。如果从 shell 命令行界面运行库文件，那么 shell 将打开一个新的 shell ，并在新 shell 中运行此脚本，但是当试图运行调用这些库函数的另一个脚本时，库函数并不能使用。

使用函数库的关键是 source 命令。source 命令在当前 shell 环境中执行命令，而非创建新 shell 来执行命令。使用 source 命令在 shell 脚本内部运行库文件脚本。

source 有一个短小的别名，称为点操作符(.)

示例
```shell
#!/bin/bash
# using functions defiend in a library file

. ./myfuncs

value1=10
value2=5
result1=`addem $value1 $value2`
result2=`multem $value1 $value2`
result3=`divem $value1 $value2`

echo "The result of adding them is: $result1"
echo "The result of multiplying them is: $result2"
echo "The result of dividing them is: $result3"
```
调用

    [root@tang sh14]# ./test14
    The result of adding them is: 15
    The result of multiplying them is: 50
    The result of dividing them is: 2

 

### 在命令行中使用参数

    $ function divem { echo $[ $1 + $2 ]; 
    $ divem 100 5

 

### 在.bashrc 文件中定义函数

将函数定义放在 shell 每次启动都能重新载入的地方，.bashrc。

可以直接定义函数，或者提供函数文件。
