
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
