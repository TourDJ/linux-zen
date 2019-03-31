


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


***


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


