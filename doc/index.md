


## [System V](https://en.wikipedia.org/wiki/UNIX_System_V)    
UNIX System V is one of the first commercial versions of the Unix operating system. It was originally developed by AT&T and first released in 1983. Four major versions of System V were released, numbered 1, 2, 3, and 4. System V Release 4, or SVR4, was commercially the most successful version, being the result of an effort, marketed as "Unix System Unification", which solicited the collaboration of the major Unix vendors. It was the source of several common commercial Unix features. System V is sometimes abbreviated to SysV.

system V 主要用 chkconfig和sevice(Redhat系列)、 update-rc.d(debian 系列)命令管理服务。

## [Systemd](https://fedoraproject.org/wiki/Systemd/zh-cn#System_V_init_.E4.B8.8E_systemd_.E7.9A.84.E5.AF.B9.E6.8E.A5)
systemd 是 Linux 下一个与 SysV 和 LSB 初始化脚本兼容的系统和服务管理器。systemd 使用 socket 和 D-Bus 来开启服务，提供基于守护进程的按需启动策略，保留了 Linux cgroups 的进程追踪功能，支持快照和系统状态恢复，维护挂载和自挂载点，实现了各服务间基于从属关系的一个更为精细的逻辑控制，拥有前卫的并行性能。systemd 无需经过任何修改便可以替代 sysvinit 。

[systemctl](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units) 是 systemd 最主要的工具。它融合 service 和 chkconfig 的功能于一体。你可以使用它永久性或只在当前会话中启用/禁用服务。

Systemctl 主要负责控制systemd系统和服务管理器。Systemd是一个系统管理守护进程、工具和库的集合，用于取代System V初始进程。   

systemd uses 'targets' instead of runlevels. By default, there are two main targets:b
* multi-user.target: analogous to runlevel 3
* graphical.target: analogous to runlevel 5

To view current default target, run:

    systemctl get-default

To set a default target, run:

    systemctl set-default TARGET.target


* 延伸阅读    
[Centos7下的systemctl命令与service和chkconfig](https://blog.csdn.net/cds86333774/article/details/51165361)     
[systemd，upstart， systemV服务启动编写](https://www.jianshu.com/p/d856428bc43f)     
[浅析 Linux 初始化 init 系统，第 1 部分](https://www.ibm.com/developerworks/cn/linux/1407_liuming_init1/index.html?ca=drs-)   
[浅析 Linux 初始化 init 系统，第 2 部分](https://www.ibm.com/developerworks/cn/linux/1407_liuming_init2/index.html)   
[浅析 Linux 初始化 init 系统，第 3 部分](https://www.ibm.com/developerworks/cn/linux/1407_liuming_init3/index.html?ca=drs-)   


chkconfig, service 与 systemctl 命令对照

| 任务	           |              旧指令	          |         新指令            |
|-------            | ----------                      | --------------            |
|使某服务自启	        |  chkconfig --level 3 httpd on	  |   systemctl enable httpd.service |
|使某服务不自动启动	  |  chkconfig --level 3 httpd off	|   systemctl disable httpd.service |
|检查服务状态	        |  service httpd status	          |   systemctl status httpd.service 或者 systemctl is-active httpd.service |
|显示所有已启动服务	  |  chkconfig --list	            |   systemctl list-units --type=service |
|启动某服务	         |  service httpd start	           |   systemctl start httpd.service |
|停止某服务	         |  service httpd stop	           |   systemctl stop httpd.service |
|重启某服务	         |  service httpd restart	       |   systemctl restart httpd.service |


> SysV init守护进程（sysv init软件包）是一个基于运行级别的系统，它使用运行级别（单用户、多用户以及其他更多级别）和链接（位于/etc/rc?.d目录中，分别链接到/etc/init.d中的init脚本）来启动和关闭系统服务。Upstart init守护进程（upstart软件包）则是基于事件的系统，它使用事件来启动和关闭系统服务。

## linux 基础知识

#### linux 启动过程
1. 读取 MBR 的信息,启动 Boot Manager。Windows 使用 NTLDR 作为 Boot Manager,如果您的系统中安装多个版本的 Windows,您就需要在 NTLDR 中选择您要进入的系统。Linux 通常使用功能强大,配置灵活的 GRUB 作为 Boot Manager。
2. 加载系统内核,启动 init 进程。init 进程是 Linux 的根进程,所有的系统进程都是它的子进程。
3. init 进程读取 /etc/inittab 文件中的信息,并进入预设的运行级别,按顺序运行该运行级别对应文件夹下的脚本。脚本通常以 start 参数启动,并指向一个系统中的程序。通常情况下, /etc/rcS.d/ 目录下的启动脚本首先被执行,然后是/etc/rcN.d/ 目录。例如您设定的运行级别为 3,那么它对应的启动目录为 /etc/rc3.d/ 。
4. 根据 /etc/rcS.d/ 文件夹中对应的脚本启动 Xwindow 服务器 xorg。Xwindow 为 Linux 下的图形用户界面系统。
5. 启动登录管理器,等待用户登录。Ubuntu 系统默认使用 GDM 作为登录管理器,您在登录管理器界面中输入用户名和密码后,便可以登录系统。(您可以在 /etc/rc3.d/ 文件夹中找到一个名为 S13gdm 的链接)

#### Login shells 与 Nonlogin shells 执行过程

Login shells

    /etc/profile
        /etc/profile.d
    ~/.bash_profile
        ~/.bashrc
            /etc/bashrc

Non-login shells

        ~/.bashrc
            /etc/bashrc
                /etc/profile.d

.bash_logout 在每次登陆shell退出时被读取并执行。

#### linux 中变量的含义

* $# 是传给脚本的参数个数
* $0 是脚本本身的名字
* $1 是传递给该shell脚本的第一个参数
* $2 是传递给该shell脚本的第二个参数
* $@ 是传给脚本的所有参数的列表
* $* 是以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个
* $$ 是脚本运行的当前进程ID号
* $? 是显示最后命令的退出状态，0表示没有错误，其他表示有错误


sudo 免密码    
```shell
your_user_name ALL=(ALL) NOPASSWD: ALL
```
注意： 有的时候你的将用户设了nopasswd，但是不起作用，原因是被后面的group的设置覆盖了，需要把group的设置也改为nopasswd。

su 免密码

切换到root权限，创建group为wheel，`groupadd wheel`，将用户加入wheel group中，命令为`usermod -G wheel your_user_name`，修改su的配置文件/etc/pam.d/su,增加下列项：
```shell
auth       required   pam_wheel.so group=wheel 
# Uncomment this if you want wheel members to be able to
# su without a password.
auth       sufficient pam_wheel.so trust use_uid
```


#### linux 目录

* /usr：系统级的目录，可以理解为C:/Windows/，/usr/lib理解为C:/Windows/System32。
* /usr/local：用户级的程序目录，可以理解为C:/Progrem Files/。用户自己编译的软件默认会安装到这个目录下。
* /opt：用户级的程序目录，可以理解为D:/Software，opt有可选的意思，这里可以用于放置第三方大型软件（或游戏），当你不需要时，直接rm -rf掉即可。在硬盘容量不够时，也可将/opt单独挂载到其他磁盘上使用。
*源码目录*  
* /usr/src：系统级的源码目录。  
* /usr/local/src：用户级的源码目录。  

**/usr文件系统** 
* /usr 文件系统经常很大，因为所有程序安装在这里. /usr 里的所有文件一般来自Linux distribution；本地安装的程序和其他东西在/usr/local 下.这样可能在升级新版系统或新distribution时无须重新安装全部程序. 

* /usr/X11R6    
X Window系统的所有文件.为简化X的开发和安装，X的文件没有集成到系统中. X自己在/usr/X11R6 下类似/usr .  

* /usr/X386    
类似/usr/X11R6 ，但是给X11 Release 5的.  

* /usr/bin  
几乎所有用户命令.有些命令在/bin 或/usr/local/bin 中. 

* /usr/sbin   
根文件系统不必要的系统管理命令，例如多数服务程序.  

* /usr/man , /usr/info , /usr/doc   
手册页、GNU信息文档和各种其他文档文件.  

* /usr/include   
C编程语言的头文件.为了一致性这实际上应该在/usr/lib 下，但传统上支持这个名字. 

* /usr/lib   
程序或子系统的不变的数据文件，包括一些site-wide配置文件.名字lib来源于库(library); 编程的原始库存在/usr/lib 里.  

* /usr/local   
本地安装的软件和其他文件放在这里.  用户自己编译的软件默认会安装到这个目录下。这里主要存放那些手动安装的软件，即不是通过“新立得”或apt-get安装的软件。它和/usr目录具有相类似的目录结构。让软件包管理器来管理/usr目录，而把自定义的脚本(scripts)放到/usr/local目录下面

**/var文件系统** 

* /var 包括系统一般运行时要改变的数据.每个系统是特定的，即不通过网络与其他计算机共享.  

* /var/catman   
当要求格式化时的man页的cache.man页的源文件一般存在/usr/man/man* 中；有些man页可能有预格式化的版本，存在/usr/man/cat* 中.而其他的man页在第一次看时需要格式化，格式化完的版本存在/var/man 中，这样其他人再看相同的页时就无须等待格式化了. (/var/catman 经常被清除，就象清除临时目录一样.)  

* /var/lib   
系统正常运行时要改变的文件.  

* /var/local   
/usr/local 中安装的程序的可变数据(即系统管理员安装的程序).注意，如果必要，即使本地安装的程序也会使用其他/var 目录，例如/var/lock .  

* /var/lock   
锁定文件.许多程序遵循在/var/lock 中产生一个锁定文件的约定，以支持他们正在使用某个特定的设备或文件.其他程序注意到这个锁定文件，将不试图使用这个设备或文件.  

* /var/log   
各种程序的Log文件，特别是login  (/var/log/wtmp log所有到系统的登录和注销) 和syslog (/var/log/messages 里存储所有核心和系统程序信息. /var/log 里的文件经常不确定地增长，应该定期清除.  

* /var/run   
保存到下次引导前有效的关于系统的信息文件.例如， /var/run/utmp 包含当前登录的用户的信息. 

* /var/spool   
mail, news, 打印队列和其他队列工作的目录.每个不同的spool在/var/spool 下有自己的子目录，例如，用户的邮箱在/var/spool/mail 中.  

* /var/tmp   
比/tmp 允许的大或需要存在较长时间的临时文件. (虽然系统管理员可能不允许/var/tmp 有很旧的文件.) 

/opt：用户级的程序目录
这里主要存放那些可选的程序。你想尝试最新的firefox测试版吗?那就装到/opt目录下吧，这样，当你尝试完，想删掉firefox的时候，你就可以直接删除它，而不影响系统其他任何设置。安装到/opt目录下的程序，它所有的数据、库文件等等都是放在同个目录下面。
举个例子：刚才装的测试版firefox，就可以装到/opt/firefox_beta目录下，/opt/firefox_beta目录下面就包含了运 行firefox所需要的所有文件、库、数据等等。要删除firefox的时候，你只需删除/opt/firefox_beta目录即可，非常简单。
在硬盘容量不够时，也可将/opt单独挂载到其他磁盘上使用。

***


## linux 命令

#### [nohup](https://www.cnblogs.com/baby123/p/6477429.html)    
　　用途：不挂断地运行命令。

　　语法：nohup Command [ Arg ... ] [　& ]

　　描述：nohup 命令运行由 Command 参数和任何相关的 Arg 参数指定的命令，忽略所有挂断（SIGHUP）信号。在注销后使用 nohup 命令运行后台中的程序。要运行后台中的 nohup 命令，添加 & （ 表示"and"的符号）到命令的尾部。
例如后台执行Spring boot:

    nohup java -jar crm-1.0.jar --server.port=8080 --spring.profiles.active=pro >/home/nginx/crm/logs/crm.log &

#### ldconfig
ldconfig 命令的用途,主要是在默认搜寻目录(/lib和/usr/lib)以及动态库配置文件/etc/ld.so.conf内所列的目录下,搜索出可共享的动态链接库(格式如前介绍,lib*.so*)，进而创建出动态装入程序(ld.so)所需的连接和缓存文件，缓存文件默认为 /etc/ld.so.cache，此文件保存已排好序的动态链接库名字列表。

#### 向文件添加和追加内容

    ivan@jiefang:~/test$ echo Hello > a.txt
    ivan@jiefang:~/test$ echo World >> a.txt
其中，> 是覆盖，>> 是追加。

#### find
To find all socket files on your system run

    sudo find / -type s

#### ps

ps -l

    F S UID PID PPID C PRI NI ADDR SZ WCHAN TTY TIME CMD
    0 S 0 5881 5654 0 76 0 - 1303 wait pts/0 00:00:00 su
    4 S 0 5882 5881 0 75 0 - 1349 wait pts/0 00:00:00 bash
    4 R 0 6037 5882 0 76 0 - 1111 - pts/0 00:00:00 ps
 

上面这个信息其实很多喔！各相关信息的意义为：
* F 代表这个程序的旗标 (flag)， 4 代表使用者为 super user；
* S 代表这个程序的状态 (STAT)，关于各 STAT 的意义将在内文介绍；
* PID 没问题吧！？就是这个程序的 ID 啊！底下的 PPID 则上父程序的 ID；
* C CPU 使用的资源百分比
* PRI 这个是 Priority (优先执行序) 的缩写，详细后面介绍；
* NI 这个是 Nice 值，在下一小节我们会持续介绍。
* ADDR 这个是 kernel function，指出该程序在内存的那个部分。如果是个 running 的程序，一般就是『 - 』的啦！
* SZ 使用掉的内存大小；
* WCHAN 目前这个程序是否正在运作当中，若为 - 表示正在运作；
* TTY 登入者的终端机位置啰；
* TIME 使用掉的 CPU 时间。
* CMD 所下达的指令为何！？


检测后台进程是否存在

    ps -ef | grep redis
    ps aux | grep redis


#### netstat
检测6379端口是否在监听

    netstat -lntp | grep 6379

#### top 
top 的全屏对话模式可分为3部分：系统信息栏、命令输入栏、进程列表栏。
第一部分 — 最上部的 系统信息栏 ：
第一行（top）：
“14:55:59”为系统当前时刻；
“4 days,  5:52”为系统启动后到现在的运作时间；
“1 user”为当前登录到系统的用户，更确切的说是登录到用户的终端数 — 同一个用户同一时间对系统多个终端的连接将被视为多个用户连接到系统，这里的用户数也将表现为终端的数目；
“load average”为当前系统负载的平均值，后面的三个值分别为1分钟前、5分钟前、15分钟前进程的平均数，一般的可以认为这个数值超过 CPU 数目时，CPU 将比较吃力的负载当前系统所包含的进程；
第二行（Tasks）：
“12 total”为当前系统进程总数；
“1 running”为当前运行中的进程数；
“11 sleeping”为当前处于等待状态中的进程数；
“0 stoped”为被停止的系统进程数；
“0 zombie”为被复原的进程数；
第三行（Cpus）：
分别表示了 CPU 当前的使用率；
第四行（Mem）：
分别表示了内存总量、当前使用量、空闲内存量、以及缓冲使用中的内存量；
第五行（Swap）：
表示类别同第四行（Mem），但此处反映着交换分区（Swap）的使用情况。通常，交换分区（Swap）被频繁使用的情况，将被视作物理内存不足而造成的。
第二部分 — 中间部分的内部命令提示栏：
top 运行中可以通过 top 的内部命令对进程的显示方式进行控制。内部命令如下表：
s – 改变画面更新频率
l – 关闭或开启第一部分第一行 top 信息的表示
t – 关闭或开启第一部分第二行 Tasks 和第三行 Cpus 信息的表示
m – 关闭或开启第一部分第四行 Mem 和 第五行 Swap 信息的表示
N – 以 PID 的大小的顺序排列表示进程列表
P – 以 CPU 占用率大小的顺序排列进程列表
M – 以内存占用率大小的顺序排列进程列表
h – 显示帮助
n – 设置在进程列表所显示进程的数量
q – 退出 top
s – 改变画面更新周期
第三部分 — 最下部分的进程列表栏：
以 PID 区分的进程列表将根据所设定的画面更新时间定期的更新。通过 top 内部命令可以控制此处的显示方式。
一般的，我们通过远程监控的方式对服务器进行维护，让服务器本地的终端实时的运行 top ，是在服务器本地监视服务器状态的快捷便利之一。

按 f 键，再按某一列的代表字母，即可选中或取消显示


#### time

#### tee

#### tree
以树型结构显示当前文件夹下的文件及其子文件夹下的内容。    

忽略某些文件下命令：

    tree -I '*svn|*node_module*'

#### nmap

#### [getconf](https://www.cnblogs.com/MYSQLZOUQI/p/5552238.html)
将系统配置变量值写入标准输出。

查看 Linux 系统的位数

    getconf LONG_BIT
    

#### lsof
lsof -i: 查看某个端口是否被占用


#### 参考  
[鸟哥的 Linux 私房菜](http://cn.linux.vbird.org/linux_server/)    
[debian下服务控制命令](http://www.cnblogs.com/Joans/articles/4939002.html)

#### linux 突然断网
linux 网络断了，重启后宝如下错误：

    Failed to start LSB: Bring up/down networking.
解决方法：

    systemctl restart NetworkManager
    sudo service network restart


#### linux 解压缩
* tar 文件解压缩

        tar -cvf jpg.tar *.jpg
        tar -xvf file.tar
* tar.gz 文件解压缩

        tar -zcvf jpg.tar.gz *.jpg
        tar -zxvf file.tar.gz
* tar.bz2 文件解压缩

        tar -jcvf jpg.tar.bz2 *.jpg
        tar -jxvf file.tar.bz2
* tar.Z 文件解压缩

        tar -Zcvf jpg.tar.Z *.jpg
        tar -Zxvf file.tar.Z
* rar 文件解压缩

        rar a jpg.rar *.jpg
        unrar e file.rar
* zip 文件解压缩

        zip jpg.zip *.jpg
        unzip file.zip 
* xz 文件解压缩

        xz -z 要压缩的文件
        xz -d 要解压的文件
        使用 -k 参数来保留被解压缩的文件
其他

        *.gz 用 gzip -d或者gunzip 解压
        *.bz2 用 bzip2 -d或者用bunzip2 解压
        *.Z 用 uncompress 解压


##3## linux 历史记录
查询历史命令记录并执行某条命令

    history
    !100

> ~/.bash_histroy里面是记录的上次注销前的历史记录（最大保存1000条，且是上次注销前最近的1000条记录）  
  HISTSIZE 变量记录了保存的数量

## linux 文件

#### /etc/sudoers
sudo的配置文件。该文件允许特定用户像root用户一样使用各种各样的命令，而不需要root用户的密码。


***
## Linux 源码安装
这些都是典型的使用 GNU 的 AUTOCONF 和 AUTOMAKE 产生的程序的安装步骤。

***

***


## 常见问题
* error: watch ENOSPC     

Run the below command:      

    echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p


* linux ssh 配置取消禁止root用户直接登陆
打开文件

    etc/ssh/sshd_config
    设置
    PermitRootLogin no
    重启sshd服务
    sservice sshd restart


