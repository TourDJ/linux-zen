
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


### 常用命令
* --list-languages     
查看识别哪些语言

* --list-maps      
可以根据文件的扩展名以及文件名的形式来确定该文件中是何种语言，从而使用正确的分析器。

* --list-kinds       
查看ctags可以识别的语法元素     
--list-kinds=java 单独查看可以识别的 java 的语法元素
