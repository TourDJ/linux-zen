
- [Shell 使用](#shell)      
  - [Shell 简介](#shell_what)      
  - [Shell 基础知识](basic.md)               
  - [Shell 启动脚本](launch.md)              
  - [Shell 常用特性](attribute.md)                    
  - [Shell 语法之结构化命令(流程控制)](flow.md)                         
  - [Shell 语法之用户输入](input.md)                  
  - [Shell 语法之输入输出](io.md)                      
  - [Shell 语法之信号与作业](sign.md)                    
  - [Shell 语法之函数](function.md)      
  - [Shell 工具之 sed](sed.md)                   
  - [Shell 工具之 gawk](gawk.md)              
  

## <a id="Shell">shell 使用</a>

### <a id="shell_what">Shell 简介</a>
A shell is a program that provides an interface between a user and an operating system (OS) kernel. An OS starts a shell for each user when the user logs in or opens a terminal or console window.

A kernel is a program that:

* Controls all computer operations.
* Coordinates all executing utilities
* Ensures that executing utilities do not interfere with each other or consume all system resources.
* Schedules and manages all system processes.

By interfacing with a kernel, a shell provides a way for a user to execute utilities and programs.

Shell 本身是一个用C语言编写的程序，它是用户使用Linux的桥梁。Shell既是一种命令语言，又是一种程序设计语言。作为命令语言，它交互式地解释和执行用户输入的命令；作为程序设计语言，它定义了各种变量和参数，并提供了许多在高级语言中才具有的控制结构，包括循环和分支。它虽然不是 Linux系统核心的一部分，但它调用了系统核心的大部分功能来执行程序、建立文件并以并行的方式协调各个程序的运行。因此，对于用户来说，shell是最重要的实用程序，深入了解和熟练掌握shell的特性及其使用方法，是用好Linux系统的关键。可以说，shell使用的熟练程度反映了用户对 Linux使用的熟练程度。

当一个用户登录Linux系统之后，系统初始化程序init就为每一个用户运行一个称为shell(外壳)的程序。那么，shell是什么呢？确切一点说，shell就是一个命令行解释器，它为用户提供了一个向Linux内核发送请求以便运行程序的界面系统级程序，用户可以用shell来启动、挂起、停止甚至是编写一些程序。

当用户使用Linux时是通过命令来完成所需工作的。一个命令就是用户和shell之间对话的一个基本单位，它是由多个字符组成并以换行结束的字符串。shell解释用户输入的命令，就象DOS里的command.com所做的一样，所不同的是，在DOS中，command.com只有一个，而在Linux下比较流行的shell有好几个，每个shell都各有千秋。一般的Linux系统都将bash作为默认的shell。


### <a id="shell_kind">几种流行的shell</a>

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

## 参考资料
* [What Is a Shell?](https://www.thegeekdiary.com/unix-linux-what-is-a-shell-what-are-different-shells/)     
