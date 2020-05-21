
- [文件](./file.md)     


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


