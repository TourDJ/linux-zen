
- [linux 命令](#linux)             
  - [Linux 的账号](#linux-account)             
    - [新增用户](#useradd)      
  - [基础命令](#linux-base)             
    - [nohup](#nohup)         
    - [ldconfig](#ldconfig)          
    - [find](#find)         
  - [进程命令](#process)          
    - [ps](#ps)        
    - [netstat](#netstat)      
    - [top](#top)           
    - [kill](#kill)        
  - [优先级](#priority)           
    - [renice](#renice)           
    - [nice](#nice)           
    - [ionice](#ionice)           
  - [前台/后台](#fgbg)          
  - [acl](./acl.md)         
  - [backup](./backup.md)         
  - [解压缩命令](./compress.md)                    
  - [定时任务](./cron.md)          
  - [ctags](./ctags.md)                 
  - [cups](./cups.md)                        
  - [directory](./directory.md)                      
  - [dns](./dns.md)                  
  - [limit](./limit.md)                   
  - [log](./log.md)                         
  - [lvm](./lvm.md)                      
  - [quota](./quota.md)                   
  - [raid](./raid.md)             
  - [selinux](./selinux.md)               
  - [term](./term.md)               
  - [tmux 命令](./tmux.md)         
  - [shopt](./shopt.md)                
  - [core](./core.md)                     
  - [Redhad/CentOS 常用命令](../distribution/redhat.md)         
  - [Debian/Ubuntu 常用命令](../distribution/debian.md)        

## <a id="linux">linux 命令</a>

### <a id="linux-account">Linux 的账号</a>

#### <a id="useradd">useradd</a>
用途：新增用户

命令格式：

    useradd [-u UID] [-g 初始群组] [-G 次要群组] [-mM] [-c 说明栏] [-d 家目录绝对路径] [-s shell] 使用者账号名
选项与参数：
* -u  ：后面接的是 UID ，是一组数字。直接指定一个特定的 UID 给这个账号；
* -g  ：后面接的那个组名就是我们上面提到的 initial group 啦～该群组的 GID 会被放置到 /etc/passwd 的第四个字段内。
* -G  ：后面接的组名则是这个账号还可以加入的群组。这个选项与参数会修改 /etc/group 内的相关数据喔！
* -M  ：强制！不要创建用户家目录！(系统账号默认值)
* -m  ：强制！要创建用户家目录！(一般账号默认值)
* -c  ：这个就是 /etc/passwd 的第五栏的说明内容啦～可以随便我们配置的啦～
* -d  ：指定某个目录成为家目录，而不要使用默认值。务必使用绝对路径！
* -r  ：创建一个系统的账号，这个账号的 UID 会有限制 (参考 /etc/login.defs)
* -s  ：后面接一个 shell ，若没有指定则默认是 /bin/bash 的啦～
* -e  ：后面接一个日期，格式为『YYYY-MM-DD』此项目可写入 shadow 第八字段，亦即账号失效日的配置项目啰；
* -f  ：后面接 shadow 的第七字段项目，指定口令是否会失效。0为立刻失效，-1 为永远不失效(口令只会过期而强制于登陆时重新配置而已。)

#### <a id="passwd">passwd</a>
用途：变更用户密码

命令格式：
  
    passwd [-l] [-u] [--stdin] [-S] [-n 日数] [-x 日数] [-w 日数] [-i 日期] 账号 <==root 功能
选项与参数：
* --stdin ：可以透过来自前一个管线的数据，作为口令输入，对 shell script 有帮助！
* -l  ：是 Lock 的意思，会将 /etc/shadow 第二栏最前面加上 ! 使口令失效；
* -u  ：与 -l 相对，是 Unlock 的意思！
* -S  ：列出口令相关参数，亦即 shadow 文件内的大部分信息。
* -n  ：后面接天数，shadow 的第 4 字段，多久不可修改口令天数
* -x  ：后面接天数，shadow 的第 5 字段，多久内必须要更动口令
* -w  ：后面接天数，shadow 的第 6 字段，口令过期前的警告天数
* -i  ：后面接『日期』，shadow 的第 7 字段，口令失效日期

#### <a id="chage">chage</a>
用途：更改用户密码有效期信息

命令格式：

    chage [-ldEImMW] 账号名
选项与参数：
* -l ：列出该账号的详细口令参数；
* -d ：后面接日期，修改 shadow 第三字段(最近一次更改口令的日期)，格式 YYYY-MM-DD
* -E ：后面接日期，修改 shadow 第八字段(账号失效日)，格式 YYYY-MM-DD
* -I ：后面接天数，修改 shadow 第七字段(口令失效日期)
* -m ：后面接天数，修改 shadow 第四字段(口令最短保留天数)
* -M ：后面接天数，修改 shadow 第五字段(口令多久需要进行变更)
* -W ：后面接天数，修改 shadow 第六字段(口令过期前警告日期)

 强制使用者在第一次登陆时一定要更改口令后才能够使用系统资源
 
    chage -d 0 agetest


#### <a id="usermod">usermod</a>
用途：更改用户信息

命令格式：

    usermod [-cdegGlsuLU] username
选项与参数：
* -c  ：后面接账号的说明，即 /etc/passwd 第五栏的说明栏，可以加入一些账号的说明。
* -d  ：后面接账号的家目录，即修改 /etc/passwd 的第六栏；
* -e  ：后面接日期，格式是 YYYY-MM-DD 也就是在 /etc/shadow 内的第八个字段数据啦！
* -f  ：后面接天数，为 shadow 的第七字段。
* -g  ：后面接初始群组，修改 /etc/passwd 的第四个字段，亦即是 GID 的字段！
* -G  ：后面接次要群组，修改这个使用者能够支持的群组，修改的是 /etc/group 啰～
* -a  ：与 -G 合用，可『添加次要群组的支持』而非『配置』喔！
* -l  ：后面接账号名称。亦即是修改账号名称， /etc/passwd 的第一栏！
* -s  ：后面接 Shell 的实际文件，例如 /bin/bash 或 /bin/csh 等等。
* -u  ：后面接 UID 数字啦！即 /etc/passwd 第三栏的数据；
* -L  ：暂时将用户的口令冻结，让他无法登陆。其实仅改 /etc/shadow 的口令栏。
* -U  ：将 /etc/shadow 口令栏的 ! 拿掉，解冻啦！

#### <a id="userdel">userdel</a>
用途：删除用户的相关数据

命令格式：

    userdel [-r] username
选项与参数：
* -r  ：连同用户的家目录也一起删除

### <a id="linux-base">Linux 基础命令</a>

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

### <a id="process">进程命令</a>

#### <a id="ps">ps</a>
ps 命令是 Process Status 的缩写，用来列出系统中当前运行的那些进程。

PID 是每个进程唯一号码。使用 ps 获取所有正在运行的进程列表。

常用命令：
```
root# ps -auxefw          所有正在运行进程的详尽列表                      
root# ps -A               显示所有进程信息
root# ps -u root          显示指定用户信息
root# ps -ef              显示所有进程信息，连同命令行
```
将目前属于您自己这次登入的 PID 与相关信息列示出来
```
root# ps -l  
```
输出
```
F S UID PID PPID C PRI NI ADDR SZ WCHAN TTY TIME CMD
0 S 0 5881 5654 0 76 0 - 1303 wait pts/0 00:00:00 su
4 S 0 5882 5881 0 75 0 - 1349 wait pts/0 00:00:00 bash
4 R 0 6037 5882 0 76 0 - 1111 - pts/0 00:00:00 ps 
```
各相关信息的意义为：
* F 代表这个程序的旗标 (flag)， 4 代表使用者为 super user
* S 代表这个程序的状态 (STAT)，关于各 STAT 的意义将在内文介绍
* UID 程序被该 UID 所拥有
* PID 就是这个程序的 ID ！
* PPID 则是其上级父程序的ID
* C CPU 使用的资源百分比
* PRI 这个是 Priority (优先执行序) 的缩写，详细后面介绍
* NI 这个是 Nice 值，在下一小节我们会持续介绍
* ADDR 这个是 kernel function，指出该程序在内存的那个部分。如果是个 running的程序，一般就是 "-"
* SZ 使用掉的内存大小
* WCHAN 目前这个程序是否正在运作当中，若为 - 表示正在运作
* TTY 登入者的终端机位置
* TIME 使用掉的 CPU 时间。
* CMD 所下达的指令为何

检测后台进程是否存在
```
root# ps -ef | grep redis
root# ps aux | grep redis
```    
然而，更典型的用法是使用管道或者 pgrep:
```
# ps axww | grep cron
  586  ??  Is     0:01.48 /usr/sbin/cron -s
# ps aux | grep 'ss[h]'              # Find all ssh pids without the grep pid
# pgrep -l sshd                      # 查找所有进程名中有sshd的进程ID
# echo $$                            # The PID of your shell
# fuser -va 22/tcp                   # 列出使用端口22的进程
# fuser -va /home                    # 列出访问 /home 分区的进程
# strace df                          # 跟踪系统调用和信号
# truss df                           # 同上(FreeBSD/Solaris/类Unix)
# history | tail -50                 # 显示最后50个使用过的命令
```
ps命令列出的是当前那些进程的快照，就是执行ps命令的那个时刻的那些进程，如果想要动态的显示进程信息，就可以使用 top 命令。

### <a id="priority">优先级</a>

#### <a id="renice">renice</a>
用 renice 更改正在运行进程的优先级。负值是更高的优先级，最小为-20，其正值与 "nice" 值的意义相同。

    root# renice -5 586                      # 更强的优先级
    586: old priority 0, new priority -5

#### <a id="nice">nice</a>
使用 nice 命令启动一个已定义优先级的进程。 正值为低优先级，负值为高优先级。确定你知道 /usr/bin/nice 或者使用 shell 内置命令(# which nice)。

    root# nice -n -5 top                     # 更高优先级(/usr/bin/nice)
    root# nice -n 5 top                      # 更低优先级(/usr/bin/nice)
    root# nice +5 top                        # tcsh 内置 nice 命令(同上)

#### <a id="ionice">ionice</a>
nice 可以影响 CPU 的调度，另一个实用命令 ionice 可以调度磁盘 IO。

*This is very useful for intensive IO application which can bring a machine to its knees while still in a lower priority.* 

此命令仅可在 Linux (AFAIK) 上使用。你可以选择一个类型(idle - best effort - real time)，它的 man 页很短并有很好的解释。

    root# ionice c3 -p123                    # 给 pid 123 设置为 idle 类型
    root# ionice -c2 -n0 firefox             # 用 best effort 类型运行 firefox 并且设为高优先级
    root# ionice -c3 -p$$                    # 将当前的进程(shell)的磁盘 IO 调度设置为 idle 类型
例中最后一条命令对于编译(或调试)一个大型项目会非常有用。每一个运行于此 shell 的命令都会有一个较低的优先级，但并不妨碍这个系统。**$$ 是你 shell 的 pid (试试 echo $$)。**

### <a id="fgbg">前台/后台</a>

当一个进程在 shell 中已运行，可以使用 [Ctrl]-[Z] (^Z), bg 和 fg 来 调入调出前后台。举个例子：启动 2 个进程，调入后台。使用 jobs 列出后台列表，然后再调入一个进程到前台。

    root# ping cb.vu > ping.log
    ^Z                                        # ping 使用 [Ctrl]-[Z] 来暂停(停止) 
    root# bg                                  # 调入后台继续运行
    root# jobs -l                             # 后台进程列表
    [1]  - 36232 Running                       ping cb.vu > ping.log
    [2]  + 36233 Suspended (tty output)        top
    root# fg %2                              # 让进程 2 返回到前台运行

#### <a id="top">top</a> 
top 程序用来实时显示系统中各个进程的运行信息。

top 的全屏对话模式可分为3部分：系统信息栏、命令输入栏、进程列表栏。

##### 第一部分 — 最上部的系统信息栏
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

##### 第二部分 — 中间部分的内部命令提示栏：
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

##### 第三部分 — 最下部分的进程列表栏：
以 PID 区分的进程列表将根据所设定的画面更新时间定期的更新。通过 top 内部命令可以控制此处的显示方式。

一般的，我们通过远程监控的方式对服务器进行维护，让服务器本地的终端实时的运行 top ，是在服务器本地监视服务器状态的快捷便利之一。

按 f 键，再按某一列的代表字母，即可选中或取消显示。

当 top 在运行的时候，按下 h 键会显示帮助画面。常用键如下：          
* u [用户名] 只显示属于此用户的进程。使用 + 或者空白可以查看所有用户
* k [PID] 结束 PID 进程
* 1 显示所有进程状态信息(只有Linux)
* R 将当前排序倒转

#### <a id="netstat">netstat</a>
检测6379端口是否在监听

    netstat -lntp | grep 6379

### <a id="kill">Kill</a>
使用 kill 或 killall 终止或发送一个信号给进程。

    # ping -i 60 cb.vu > ping.log &
    [1] 4712
    # kill -s TERM 4712                  # 同 kill -15 4712
    # killall -1 httpd                   # 发送 HUP 信号终止进程 httpd
    # pkill -9 http                      # 发送 TERM 信号终止包含 http 的进程
    # pkill -TERM -u www                 # 发送 TERM 信号终止 www 所有者进程
    # fuser -k -TERM -m /home            # 终止所有访问 /home 的进程(卸载该分区前)
下面是一些重要的信号：

    1       HUP (挂起)
    2       INT (中断)
    3       QUIT (退出)
    9       KILL (KILL 信号不能被捕捉，不能被忽略。)
    15     TERM (软件终止信号)

#### nmap Network exploration tool and security / port scanner

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

#### ctrl+r
用途：反向搜索执行过的命令。(reverse-i-search)

通过Ctrl+R可以根据关键字搜索历史命令，按多次Ctrl+R可以继续搜索更旧的历史命令。

#### 参考  
[鸟哥的 Linux 私房菜](http://cn.linux.vbird.org/linux_server/)    
[debian下服务控制命令](http://www.cnblogs.com/Joans/articles/4939002.html)

#### linux 突然断网
linux 网络断了，重启后宝如下错误：

    Failed to start LSB: Bring up/down networking.
解决方法：

    systemctl restart NetworkManager
    sudo service network restart

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

