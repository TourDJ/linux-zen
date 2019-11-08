# linux-zen


## Linux 概述
Linux (/ˈlɪnəks/) is a family of open source Unix-like operating systems based on the Linux kernel, an operating system kernel first released on September 17, 1991 by Linus Torvalds.Linux is typically packaged in a Linux distribution (or distro for short).

![unix 系统及衍生系统发展分支图](https://github.com/TourDJ/linux-zen/blob/master/image/unixbranches.jpg)
原图：[类Unix系统图谱](https://blog.csdn.net/lu_embedded/article/details/53561142)     

Distributions include the Linux kernel and supporting system software and libraries, many of which are provided by the GNU Project. Many Linux distributions use the word "Linux" in their name, but the Free Software Foundation uses the name GNU/Linux to emphasize the importance of GNU software, causing some controversy.

Popular Linux distributions include Debian, Fedora, and Ubuntu. Commercial distributions include Red Hat Enterprise Linux and SUSE Linux Enterprise Server. Desktop Linux distributions include a windowing system such as X11 or Wayland, and a desktop environment such as GNOME or KDE Plasma. Distributions intended for servers may omit graphics altogether, and include a solution stack such as LAMP. Because Linux is freely redistributable, anyone may create a distribution for any purpose.

![Linux 发行版分支图](https://github.com/TourDJ/linux-zen/blob/master/image/linuxbranches.png)
原图：[Linux 发行版分支图](https://i.linuxtoy.org/docs/guide/ch48s09.html)

Linux was originally developed for personal computers based on the Intel x86 architecture, but has since been ported to more platforms than any other operating system. Linux is the leading operating system on servers and other big iron systems such as mainframe computers, and the only OS used on TOP500 supercomputers (since November 2017, having gradually eliminated all competitors). It is used by around 2.3 percent of desktop computers. The Chromebook, which runs the Linux kernel-based Chrome OS, dominates the US K–12 education market and represents nearly 20 percent of sub-$300 notebook sales in the US.

Linux also runs on embedded systems, i.e. devices whose operating system is typically built into the firmware and is highly tailored to the system. This includes routers, automation controls, televisions, digital video recorders, video game consoles, and smartwatches. Many smartphones and tablet computers run Android and other Linux derivatives. Because of the dominance of Android on smartphones, Linux has the largest installed base of all general-purpose operating systems.

Linux is one of the most prominent examples of free and open-source software collaboration. The source code may be used, modified and distributed—commercially or non-commercially—by anyone under the terms of its respective licenses, such as the GNU General Public License.

## Linux 服务管理程序
常用的服务管理程序主要有 System V, Systemd, Upstart。

### System V
UNIX System V is one of the first commercial versions of the Unix operating system. It was originally developed by AT&T and first released in 1983. Four major versions of System V were released, numbered 1, 2, 3, and 4. System V Release 4, or SVR4, was commercially the most successful version, being the result of an effort, marketed as "Unix System Unification", which solicited the collaboration of the major Unix vendors. It was the source of several common commercial Unix features. System V is sometimes abbreviated to SysV.

SysV init 是 system V 风格的 init 系统，它源于 System V 系列 UNIX。SysV init守护进程（sysv init软件包）是一个基于运行级别的系统，它使用运行级别（单用户、多用户以及其他更多级别）和链接（位于/etc/rc?.d目录中，分别链接到/etc/init.d中的init脚本）来启动和关闭系统服务。Upstart init守护进程（upstart软件包）则是基于事件的系统，它使用事件来启动和关闭系统服务。

System V 主要用 chkconfig和sevice(Redhat系列)、 update-rc.d(debian 系列)命令管理服务。

### Systemd
The systemd software suite provides fundamental building blocks for a Linux operating system. It includes the systemd "System and Service Manager", an init system used to bootstrap user space and manage user processes.

systemd aims to unify service configuration and behavior across Linux distributions. It replaces the UNIX System V and BSD init systems. Since 2015, the majority of Linux distributions have adopted systemd, and it is considered a de facto standard.

The name systemd adheres to the Unix convention of naming daemons by appending the letter d. It also plays on the term "System D", which refers to a person's ability to adapt quickly and improvise to solve problems.

systemd 是 Linux 下一个与 SysV 和 LSB 初始化脚本兼容的系统和服务管理器。systemd 使用 socket 和 D-Bus 来开启服务，提供基于守护进程的按需启动策略，保留了 Linux cgroups 的进程追踪功能，支持快照和系统状态恢复，维护挂载和自挂载点，实现了各服务间基于从属关系的一个更为精细的逻辑控制，拥有前卫的并行性能。systemd 无需经过任何修改便可以替代 SysV init 。

systemctl 是 systemd 最主要的工具。它融合 service 和 chkconfig 的功能于一体。你可以使用它永久性或只在当前会话中启用/禁用服务。

Systemctl 主要负责控制systemd系统和服务管理器。Systemd是一个系统管理守护进程、工具和库的集合，用于取代System V初始进程。   

systemd uses 'targets' instead of runlevels. By default, there are two main targets:
* multi-user.target: analogous to runlevel 3
* graphical.target: analogous to runlevel 5

To view current default target, run:

    systemctl get-default

To set a default target, run:

    systemctl set-default TARGET.target



表： chkconfig, service 与 systemctl 命令对照

| 任务	           |              旧指令	          |         新指令            |
|-----------        | ----------------------         | --------------            |
|使某服务自启	        |  chkconfig --level 3 httpd on	  |   systemctl enable httpd.service |
|使某服务不自动启动	  |  chkconfig --level 3 httpd off	|   systemctl disable httpd.service |
|检查服务状态	        |  service httpd status	          |   systemctl status httpd.service 或者 systemctl is-active httpd.service |
|显示所有已启动服务	  |  chkconfig --list	            |   systemctl list-units --type=service |
|启动某服务	         |  service httpd start	           |   systemctl start httpd.service |
|停止某服务	         |  service httpd stop	           |   systemctl stop httpd.service |
|重启某服务	         |  service httpd restart	       |   systemctl restart httpd.service |


### Upstart
Upstart is an event-based replacement for the /sbin/init daemon which handles starting of tasks and services during boot, stopping them during shutdown and supervising them while the system is running.

It was originally developed for the Ubuntu distribution, but is intended to be suitable for deployment in all Linux distributions as a replacement for the venerable System-V init.

Most major users of Upstart have moved on. Commercial and security support for upstart will stop be from Canonical once the last Ubuntu release shipping upstart lapses.

Project is in maintaince mode only. No new features are being developed and the general advice would be to move over to another minimal init system or systemd.
  
## Linux 运维

### Linux 性能分析
一个完整运行的 Linux 系统包括很多子系统（介绍，CPU，Memory，IO，Network，…），监测和评估这些子系统是性能监测的一部分。我们往往需要宏观的看整个系统状态，也需要微观的看每个子系统的运行情况。幸运的是，我们不必重复造轮子，监控这些子系统都有相应的工具可用，这些经过时间考验、随 Unix 成长起来、简单而优雅的小工具是我们日常 Unix/Linux 工作不可缺少的部分。

系统性能专家 Brendan D. Gregg 在最近的 LinuxCon NA 2014 大会上更新了他那个有名的关于 Linux 性能方面的资料和幻灯片。

#### 参考资料：
[Linux 性能监测：工具](https://www.vpsee.com/2013/06/linux-system-performance-monitoring-tools/)      
[Linux 性能](http://www.brendangregg.com/linuxperf.html)       

## 如何使用?
* [常用命令](./doc/command.md)       
* [Shell 使用](./doc/shell.md)       
* [Redhad/CentOS 常用命令](./distribution/redhat.md)     
* [Debian/Ubuntu 常用命令](./distribution/debian.md)     
* [tmux 命令](./doc/tmux.md)    






## 参考资料           
* [UNIX TOOLBOX](http://cb.vu/unixtoolbox_zh_CN.xhtml)        
* [How To Use Systemctl to Manage Systemd Services and Units](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)    
* [开源世界旅行手册](https://i.linuxtoy.org/docs/guide/)     
* [GNU make doc](https://www.gnu.org/software/make/manual/make.html#toc-An-Introduction-to-Makefiles)     
* [How To Use Systemctl to Manage Systemd Services and Units](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)      
* [systemd，upstart， systemV服务启动编写](https://www.jianshu.com/p/d856428bc43f)     
* [浅析 Linux 初始化 init 系统，第 1 部分](https://www.ibm.com/developerworks/cn/linux/1407_liuming_init1/index.html?ca=drs-)   
* [浅析 Linux 初始化 init 系统，第 2 部分](https://www.ibm.com/developerworks/cn/linux/1407_liuming_init2/index.html)   
* [浅析 Linux 初始化 init 系统，第 3 部分](https://www.ibm.com/developerworks/cn/linux/1407_liuming_init3/index.html?ca=drs-) 
* [System V init 与 systemd 的对接](https://fedoraproject.org/wiki/Systemd/zh-cn#System_V_init_.E4.B8.8E_systemd_.E7.9A.84.E5.AF.B9.E6.8E.A5)      

