

## shell 启动脚本

启动脚本是bash启动时自动执行的脚本。用户可以把一些环境变量的设置和alias、umask设置放在启动脚本中，这样每次启动Shell时这些设置都自动生效。思考一下，bash在执行启动脚本时是以fork子Shell方式执行的还是以source方式执行的？

/etc/profile —— ~/.bash_profile —— ~/.bashrc —— /etc/bashrc---->命令提示符                       
                                                                               
  /etc/profile.d/\*.sh 
     
  




 

### /etc/profile 的作用

* USER变量
* LOGNAME变量
* MAIL变量
* PATH变量
* HOSTNAME变量
* umask
* 调用/etc/profile.d/*.sh文件
 

### ~/.bash_profile的作用

调用了 ~/.bashrc 文件
在PATH 变量后面加入了”:$HOME/bin” 这个目录
 

### ~/.bashrc 的作用

设置别名
 

 

### /etc/bashrc的作用

PS1 变量
umask
PATH 变量
调用 /etc/profile.d/*.sh 文件
 

**bash 配置文件一览表**

|文件	|效力范围|	时机|	说明     |
|----|--|-----------|-------------------------------------------------|
|/etc/profile|	全系统|	login shell 启动时|	通常包含环境变量（至少会定义一个基本的 PATH），以及登陆后要立即启动的程序。|
|~/.bash_profile|	个人|	login shell 启动时|	执行次序在 /etc/profile 之后|
|~/.bash_login|	个人|	login shell 启动时|	只有在 ~/.bash_profile 不存在时才有效|
|~/.profile|	个人|	login shell 启动时|	只有在 ~/.bash_profile  和  ~/.bash_login 都不存在是才有效|
|~/.bash_logout|	个人|	login shell 结束时|	用户注销时会自动执行|
|~/.bashrc|	个人|	以交互模式启动时，在所有 profile 之后|	通常含有个人偏好环境的设定值或是会追溯 /etc/bashrc|
|/etc/bashrc|	全系统|	不一定|	含有全体用户都适用的环境设定值。通常由个人的~/.bashrc 来追溯此文件|
|~/.inputrc|	个人|	login shell 启动时|	定义按键绑定（key binding）和影响 bash 按键响应方式的变量。bash 默认的按键绑定类似于 Emacs 文本编辑程序|

启动bash的方法不同，执行启动脚本的步骤也不相同，具体可分为以下几种情况。 

1. 以交互登录Shell启动，或者使用--login参数启动 
交互Shell是指用户在提示符下输命令的Shell而非执行脚本的Shell，登录Shell就是在输入用户名和密码登录后得到的Shell，比如从字符终端登录或者用telnet/ssh从远程登录，但是从图形界面的窗口管理器登录之后会显示桌面而不会产生登录Shell（也不会执行启动脚本），在图形界面下打开终端窗口得到的Shell也不是登录Shell。

这样启动bash会自动执行以下脚本：

首先执行/etc/profile，系统中每个用户登录时都要执行这个脚本，如果系统管理员希望某个设置对所有用户都生效，可以写在这个脚本里

然后依次查找当前用户主目录的~/.bash_profile、~/.bash_login和~/.profile三个文件，找到第一个存在并且可读的文件来执行，如果希望某个设置只对当前用户生效，可以写在这个脚本里，由于这个脚本在/etc/profile之后执行，/etc/profile设置的一些环境变量的值在这个脚本中可以修改，也就是说，当前用户的设置可以覆盖（Override）系统中全局的设置。~/.profile这个启动脚本是sh规定的，bash规定首先查找以~/.bash_开头的启动脚本，如果没有则执行~/.profile，是为了和sh保持一致。

顺便一提，在退出登录时会执行~/.bash_logout脚本（如果它存在的话）。

 
2. 以交互非登录Shell启动 
比如在图形界面下开一个终端窗口，或者在登录Shell提示符下再输入bash命令，就得到一个交互非登录的Shell，这种Shell在启动时自动执行~/.bashrc脚本。

为了使登录Shell也能自动执行~/.bashrc，通常在~/.bash_profile中调用~/.bashrc：

if [ -f ~/.bashrc ]; 
then     
　　. ~/.bashrc 
fi
这几行的意思是如果~/.bashrc文件存在则source它。多数Linux发行版在创建帐户时会自动创建~/.bash_profile和~/.bashrc脚本，~/.bash_profile中通常都有上面这几行。所以，如果要在启动脚本中做某些设置，使它在图形终端窗口和字符终端的Shell中都起作用，最好就是在~/.bashrc中设置。

下面做一个实验，在~/.bashrc文件末尾添加一行（如果这个文件不存在就创建它）：

export PATH=$PATH:/home/akaedu
然后关掉终端窗口重新打开，或者从字符终端logout之后重新登录，现在主目录下的程序应该可以直接输程序名运行而不必输入路径了，例如：

~$ a.out
就可以了，而不必

~$ ./a.out
为什么登录Shell和非登录Shell的启动脚本要区分开呢？最初的设计是这样考虑的，如果从字符终端或者远程登录，那么登录Shell是该用户的所有其它进程的父进程，也是其它子Shell的父进程，所以环境变量在登录Shell的启动脚本里设置一次就可以自动带到其它非登录Shell里，而Shell的本地变量、函数、alias等设置没有办法带到子Shell里，需要每次启动非登录Shell时设置一遍，所以就需要有非登录Shell的启动脚本，所以一般来说在~/.bash_profile里设置环境变量，在~/.bashrc里设置本地变量、函数、alias等。如果你的Linux带有图形系统则不能这样设置，由于从图形界面的窗口管理器登录并不会产生登录Shell，所以环境变量也应该在~/.bashrc里设置。

 
3. 非交互启动 
为执行脚本而fork出来的子Shell是非交互Shell，启动时执行的脚本文件由环境变量BASH_ENV定义，相当于自动执行以下命令：

if [ -n "$BASH_ENV" ]; 
then 
　　. "$BASH_ENV"; 
fi
如果环境变量BASH_ENV的值不是空字符串，则把它的值当作启动脚本的文件名，source这个脚本。

 
4. 以sh命令启动
如果以sh命令启动bash，bash将模拟sh的行为，以~/.bash_开头的那些启动脚本就不认了。所以，如果作为交互登录Shell启动，或者使用--login参数启动，则依次执行以下脚本：

/etc/profile

~/.profile

如果作为交互Shell启动，相当于自动执行以下命令：

if [ -n "$ENV" ]; 
then 
　　. "$ENV"; 
fi
如果作为非交互Shell启动，则不执行任何启动脚本。通常我们写的Shell脚本都以#! /bin/sh开头，都属于这种方式。
