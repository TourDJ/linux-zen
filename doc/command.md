
- [linux 命令](#linux)          
  - [Linux 基础命令](#linux-base)             
    - [nohup](#nohup)         
    - [ldconfig](#ldconfig)          
    - [find](#find)         
    - [ps](#ps)        
    - [netstat](#netstat)      
    - [top](#top)           
  - [tmux 命令](./doc/tmux.md)        
  - [Redhad/CentOS 常用命令](./distribution/redhat.md)         
  - [Debian/Ubuntu 常用命令](./distribution/debian.md)        

## <a id="linux">linux 命令</a>

## <a id="linux-base">Linux 基础命令</a>

#### <a id="nohup">nohup</a>   
　　用途：不挂断地运行命令。

　　语法：nohup Command [ Arg ... ] [　& ]

　　描述：[nohup](https://www.cnblogs.com/baby123/p/6477429.html) 命令运行由 Command 参数和任何相关的 Arg 参数指定的命令，忽略所有挂断（SIGHUP）信号。在注销后使用 nohup 命令运行后台中的程序。要运行后台中的 nohup 命令，添加 & （ 表示"and"的符号）到命令的尾部。
例如后台执行Spring boot:

    nohup java -jar crm-1.0.jar --server.port=8080 --spring.profiles.active=pro >/home/nginx/crm/logs/crm.log &

#### <a id="ldconfig">ldconfig</a>    
ldconfig命令的用途主要是在默认搜寻目录/lib和/usr/lib以及动态库配置文件/etc/ld.so.conf内所列的目录下，搜索出可共享的动态链接库（格式如lib*.so\*）,进而创建出动态装入程序(ld.so)所需的连接和缓存文件。缓存文件默认为/etc/ld.so.cache，此文件保存已排好序的动态链接库名字列表，为了让动态链接库为系统所共享，需运行动态链接库的管理命令ldconfig，此执行程序存放在/sbin目录下。
ldconfig通常在系统启动时运行，而当用户安装了一个新的动态链接库时，就需要手工运行这个命令。

语法:          
ldconfig [-v|--verbose] [-n] [-N] [-X] [-f CONF] [-C CACHE] [-r ROOT] [-l] [-p|--print-cache] [-c FORMAT] [--format=FORMAT] [-V] [-?|--help|--usage] path... 

选项          
* -v或--verbose：用此选项时，ldconfig将显示正在扫描的目录及搜索到的动态链接库，还有它所创建的连接的名字。
* -n：用此选项时,ldconfig仅扫描命令行指定的目录，不扫描默认目录（/lib、/usr/lib），也不扫描配置文件/etc/ld.so.conf所列的目录。
* -N：此选项指示ldconfig不重建缓存文件（/etc/ld.so.cache），若未用-X选项，ldconfig照常更新文件的连接。
* -X：此选项指示ldconfig不更新文件的连接，若未用-N选项，则缓存文件正常更新。
* -f CONF：此选项指定动态链接库的配置文件为CONF，系统默认为/etc/ld.so.conf。
* -C CACHE：此选项指定生成的缓存文件为CACHE，系统默认的是/etc/ld.so.cache，此文件存放已排好序的可共享的动态链接库的列表。
* -r ROOT：此选项改变应用程序的根目录为ROOT（是调用chroot函数实现的）。选择此项时，系统默认的配置文件/etc/ld.so.conf，实际对应的为ROOT/etc/ld.so.conf。如用-r /usr/zzz时，打开配置文件/etc/ld.so.conf时，实际打开的是/usr/zzz/etc/ld.so.conf文件。用此选项，可以大大增加动态链接库管理的灵活性。
* -l：通常情况下,ldconfig搜索动态链接库时将自动建立动态链接库的连接，选择此项时，将进入专家模式，需要手工设置连接，一般用户不用此项。
* -p或--print-cache：此选项指示ldconfig打印出当前缓存文件所保存的所有共享库的名字。
* -c FORMAT 或 --format=FORMAT：此选项用于指定缓存文件所使用的格式，共有三种：old(老格式)，new(新格式)和compat（兼容格式，此为默认格式）。
* -V：此选项打印出ldconfig的版本信息，而后退出。
* -? 或 --help 或 --usage：这三个选项作用相同，都是让ldconfig打印出其帮助信息，而后退出。

#### <a id="find">find</a>
To find all socket files on your system run

    sudo find / -type s

#### <a id="ps">ps</a>

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


#### <a id="netstat">netstat</a>
检测6379端口是否在监听

    netstat -lntp | grep 6379

#### nmap Network exploration tool and security / port scanner

#### <a id="top">top</a> 
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

tee and >

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



## pkg-config
Return metainformation about installed libraries

## autoconf
Generate configuration scripts


## autoreconf
Update generated configuration files

## gedit

### 进程命令

jobs    查看当前有多少在后台运行的命令
fg      将后台中的命令调至前台继续运行。如果后台中有多个命令，可以用 fg %jobnumber将选中的命令调出，%jobnumber是通过jobs命令查到的后台正在执行的命令的序号(不是pid)
bg      将一个在后台暂停的命令，变成继续执行。如果后台中有多个命令，可以用bg %jobnumber将选中的命令调出，%jobnumber是通过jobs命令查到的后台正在执行的命令的序号(不是pid)
   
#### 向文件添加和追加内容

    ivan@jiefang:~/test$ echo Hello > a.txt
    ivan@jiefang:~/test$ echo World >> a.txt
其中，> 是覆盖，>> 是追加。

