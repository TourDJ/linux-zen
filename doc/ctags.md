
## ctags
ctags的功能：扫描指定的源文件，找出其中所包含的语法元素，并将找到的相关内容记录下来。

### ctags 简介
目前用的 ctags 是 Universal Ctags

    Universal Ctags 0.0.0, Copyright (C) 2015 Universal Ctags Team
    Universal Ctags is derived from Exuberant Ctags.
    Exuberant Ctags 5.8, Copyright (C) 1996-2009 Darren Hiebert
      Compiled: Jun 12 2019, 12:29:00
      URL: https://ctags.io/
      Optional compiled features: +wildcards, +regex, +iconv, +option-directory, +packcc


### ctags 安装

    $ ./autogen.sh
    $ ./configure --prefix=/where/you/want # defaults to /usr/local
    $ make
    $ make install # may require extra privileges depending on where to install

### 常用命令
* --list-languages     
查看识别哪些语言

* --list-maps      
可以根据文件的扩展名以及文件名的形式来确定该文件中是何种语言，从而使用正确的分析器。

* --langmap=c++:+.inl –R      
指定ctags用特定语言的分析器来分析某种扩展名的文件

* --list-kinds       
查看ctags可以识别的语法元素     
--list-kinds=java 单独查看可以识别的 java 的语法元素

### ctags 命令示例

    ctags-R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+px--fields=+aiKSz --extra=+q --exclude=lex.yy.cc --exclude=copy_lex.yy.cc
命令解释：

* -R

表示扫描当前目录及所有子目录（递归向下）中的源文件。并不是所有文件 ctags 都会扫描，如果用户没有特别指明，则 ctags 根据文件的扩展名来决定是否要扫描该文件，如果 ctags 可以根据文件的扩展名可以判断出该文件所使用的语言，则 ctags 会扫描该文件。

* --languages=c++

只扫描文件内容判定为`c++`的文件，即 ctags 观察文件扩展名，如果扩展名对应`c++`，则扫描该文件。反之如果某个文件叫 aaa.py（python文件），则该文件不会被扫描。

* --langmap=c++:+.inl

告知 ctags，以 inl 为扩展名的文件是`c++`语言写的，在加之上述2中的选项，即要求 ctags 以`c+`+语法扫描以 inl 为扩展名的文件。

* -h +.inl

告知 ctags，把以inl为扩展名的文件看作是头文件的一种（inl文件中放的是inline函数的定义，本来就是为了被include的）。这样ctags在扫描inl文件时，就算里面有static的全局变量，ctags在记录时也不会标明说该变量是局限于本文件的。

* --c++-kinds=+px

记录类型为函数声明和前向声明的语法元素。

* --fields=+aiKSz

控制记录的内容。

* --extra=+q

让ctags额外记录一些东西。

* --exclude=lex.yy.cc --exclude=copy_lex.yy.cc

告知ctags不要扫描名字是这样的文件。还可以控制ctags不要扫描指定目录，这里就不细说了。

* -f tagfile

指定生成的标签文件名，默认是tags. tagfile指定为 - 的话，输出到标准输出。


### vim 中使用 ctags
#### vim 中配置 ctags
生成 tags 文件：

    ctags –R ∗
在 vim 中指定 tags 文件。通常手动指定，在 vim 命令行输入：

    :set tags=$PATH/tags
若要引用多个不同目录的tags文件，可以用逗号隔开或者设置在配置文件中。在 ~/.vimrc 加入一行：

    set tags=$PATH/tags

如果经常在不同工程里查阅代码，那么可以在 ~/.vimrc 中添加：

    set tags=tags;
    set autochdir
> 注意第一个命令里的分号是必不可少的。

#### vim 快捷键

    vi –t tag               (请把tag替换为您欲查找的变量或函数名)
    :ts                     (ts 助记字：tags list, “:”开头的命令为VI中命令行模式命令)
    :tp                     (tp 助记字：tags preview)
    :tn                     (tn 助记字：tags next) 
    Ctrl+](:ta name)        跳转到变量或函数的定义处
    Ctrl+o/t                返回到跳转前的位置                
       

