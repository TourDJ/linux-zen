
## Shell 工具之 sed
sed 是 stream editor 的缩写，中文称之为“流编辑器”。

sed 命令是一个面向行处理的工具，它以“行”为处理单位，针对每一行进行处理，处理后的结果会输出到标准输出（STDOUT）。你会发现 sed 命令是很懂礼貌的一个命令，它不会对读取的文件做任何贸然的修改，而是将内容都输出到标准输出中。

 
### 命令格式
sed 命令格式：

    sed options script file

* options 允许自定义 sed 命令的行为，它包含的选项如表1所示。
* script 指定要应用于数据流的单个命令。如果需要多个命令，使用 -e 或者 -f 选项。
* file 要处理的文件，如果忽略 file 参数，则 sed 会把标准输入作为处理对象。

**表1： sed 命令选项**

|选项	|   描述   |
|----|------------------------------------|
|-e script|将脚本中指定的命令添加到处理输入时执行的命令中|
|-f file|将文件中指定的命令添加到处理输入时执行的命令中|
|-n|不需要为每个命令产生输出，但要等待打印命令|

#### 在命令行中定义编辑器命令

    $ echo "This is a test" | sed 's/test/big test/'
    $ sed 's/dog/cat/' data1 

#### 在命令行中使用多个编辑器命令

    $ sed -e 's/brown/green/; s/dog/cat/' data1 

> 注意：命令必须用分号隔开，且在命令结尾和分号之间不能有任何空格。

#### 也可以使用次提示符

    $ sed -e '
    > s/brown/green/
    > s/fox/elephant/
    > s/dog/cat/' data1
 
#### 从文件读取编辑器命令

    $ sed -f script1 data1
    $ cat script1
    s/brown/green/
    s/fox/elephant/
    s/dog/cat/

### sed 命令

#### 替换标记

s  用新文本替换某一行中的文本

    s/pattern/replacement/flags

可用的替换标记有4种：
* 数字：表示新文本替换的模式
* g：表示用新文本替换现有文本的全部实例
* p：表示打印原始行的内容
* w file：将替换的结果写入文件

例如

    $ sed 's/test/trial/2' data1 仅替换每一行中第二次出现的模式 

    $ sed 's/test/trial/g' data2 

    $ sed -n 's/test/trial/p' data4 替换命令中匹配模式的那一行，经常和-n 选项一起使用

    $ sed 's/test/trail/w test' data5

 

替换字符

sed 编辑器允许为替换命令中的字符串定界符选择一个不同的字符。

$ sed 's!/bin/bash!/bin/csh!' /etc/passwd

 

使用地址

在 sed 编辑器中， 有两种行寻址形式：

行的数值范围

筛选行的文本模式

格式

 [address] command

或者将多个命令组合在一起 

address {

  command1

  command2

}

 

数字式寻址

$ sed '2s/dog/cat/' data1

$ sed '2,3s/dog/cat' data1

$ sed 2,$s/dog/cat' data1

 

文本模式筛选器

格式

/pattern/command

$ sed '/rich/s/bash/csh/' /etc/passwd

 

组合命令

如果需要在单独一行上执行多个命令，使用大括号将命令组合在一起

$ sed '2,${

> s/fox/elephant/

> s/dog/cat/

> }' data1

 

删除行

d 删除与锁提供的寻址模式一致的所有文本行。

$ sed '3d' data1 

$ sed '2,3d' data2

$ sed '2,$d' data3

$ sed 'number 1/d' data4

 

还可以使用两个文本模式删除若干行。指定的第一个模式将打开行删除，第二个模式将关闭行删除。sed 编辑器将删除指定的这两行(包括这两行)之间的所有文本行。

sed '/1/,/3/d' data5

 

插入和附加文本

i 在指定行之前添加新的一行

a 在指定行之后添加新的一行

不能在单命令行上使用这两个命令，必须单独指定要插入或附件的行。

格式

sed '[address]command\

new line'

 

$ echo "testing" | sed 'i\

> This is a test'

$ echo "testing" | sed 'a\

> This is a test'

 

 

更改行

c 允许更改数据流中整行文本的内容。

$ sed '3c\

> This is a changed line of text.' data5

$ sed '/number 3/c\

> This is a changed line of text.' data5

$ sed '2,3c\

> This is a  new line of text.' data5

 

 

变换命令

y 命令是唯一对单个字符进行操作的 sed 编辑器命令。格式：

[address]y/inchars/outchars/

变换命令将 inchars 和 outchars 的值进行一对一映射。

$ sed 'y/123/789/' data1

 

打印

 有3个命令可以用于打印来自数据流的信息

打印文本行的小写 p 命令

打印行号的等号(=)命令

列出行的 l 命令

 

打印行

$ echo "This is a test" | sed 'p'

$ sed -n '/number 3/p' data1

$ sed -n '2,3p' data1

$ sed -n '/3/{

p

s/line/test/p

}' data4

 

打印行号

$ sed '=' data1

$ sed -n 'number 4/{

=

p

}' data4

 

列出行

列出命令(l)允许打印数据流中的文本和不可打印的 ASCII 字符。

$ sed -n 'l' data6

 

写文件

w 命令用于将文本行写入文件。

格式

[address]w filename

filename 可以指定为相对活绝对路径。

$ sed '1,2w test' data2

$ sed -n '/IN/w INcustomers' data1

 

从文件中读取

r 命令允许插入包含在独立文件中的数据。

格式

[address]r filename

$ sed '3r data11' data2

$ sed '/number 2/r data11' data2

$ sed '$r data11' data2 将文本添加到数据流末尾

$ sed '/LIST/{

> r data10

> d

> }' letter 套用信函使用类占位符 LIST 代替人员列表，并删除占位符。

 

模式空间和保留空间
