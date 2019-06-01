> [返回首页](../README.md)     

## debian 系列
### deb 包安装方法  

#### 安装一个 Debian 软件包

    dpkg -i <package.deb>

#### 列出 <package.deb> 的内容

    dpkg -c <package.deb>

#### 从 <package.deb> 中提取包裹信息

    dpkg -I <package.deb>

#### 移除一个已安装的包裹

    dpkg -r <package>

#### 完全清除一个已安装的包裹。和 remove 不同的是，remove 只是删掉数据和可执行文件，purge 另外还删除所有的配制文件

    dpkg -P <package>

#### 列出 <package> 安装的所有文件清单。同时请看 dpkg -c 来检查一个 .deb 文件的内容

    dpkg -L <package>

#### 显示已安装包裹的信息。同时请看 apt-cache 显示 Debian 存档中的包裹信息，以及 dpkg -I 来显示从一个 .deb 文件中提取的包裹信息

    dpkg -s <package>

#### 重新配制一个已经安装的包裹，如果它使用的是 debconf (debconf 为包裹安装提供了一个统一的配制界面)

    dpkg-reconfigure <package>
 
 
> apt-cache 是linux下的一个apt软件包管理工具，它可查询apt的二进制软件包缓存文件。
参见： http://zwkufo.blog.163.com/blog/static/258825120092245519896/

## [debian 软件源更新](http://www.cnblogs.com/beanmoon/p/3387652.html)
修改 /etc/apt/sources.list 之后一般会运行下面两个命令进行更新升级：

        sudo apt-get update
        sudo apt-get dist-upgrade
其中 ：
   update - 取回更新的软件包列表信息
   dist-upgrade - 发布版升级
第一个命令仅仅更新的软件包列表信息，所以很快就能完成。
第二个命令是全面更新发布版，一般会下载几百兆的新软件包。
其实在运行完第一个命令后系统就会提示你进行更新升级。因为修改了源，所有这次更新的改动可能会很大，比如安装某个包可能会删除太多的其他包，所有系统会提示你运行“sudo apt-get dist-upgrade”进行全面升级或使用软件包管理器中的“标记全部软件包以便升级”功能进行升级。两者效果是一样的。

#### apt-get指令的 autoclean,clean,autoremove的[区别](http://blog.csdn.net/flydream0/article/details/8620396) 
apt-get autoclean:
    如果你的硬盘空间不大的话，可以定期运行这个程序，将已经删除了的软件包的.deb安装文件从硬盘中删除掉。如果你仍然需要硬盘空间的话，可以试试apt-get clean，这会把你已安装的软件包的安装包也删除掉，当然多数情况下这些包没什么用了，因此这是个为硬盘腾地方的好办法。

apt-get clean:
    类似上面的命令，但它删除包缓存中的所有包。这是个很好的做法，因为多数情况下这些包没有用了。但如果你是拨号上网的话，就得重新考虑了。

apt-get autoremove:
    删除为了满足其他软件包的依赖而安装的，但现在不再需要的软件包。

apt-get remove 软件包名称：
    删除已安装的软件包（保留配置文件）。

apt-get --purge remove 软件包名称：
     删除已安装包（不保留配置文件)。


## debian 网络配置

配置网卡
修改 /etc/network/interfaces 添加如下

auto eth0 #开机自动激活
iface eth0 inte static #静态IP
address 192.168.0.56 #本机IP
netmask 255.255.255.0 #子网掩码
gateway 192.168.0.254 #路由网关
 
如果是用DHCP自动获取，请在配置文件里添加如下：
auto eth0
iface eth0 inet dhcp

设置DNS
echo "nameserver 202.96.128.86" >> /etc/resolv.conf

重启一下网卡。
/etc/init.d/networking restart

## Debian 系命令
        
debian 的 runlevel级别定义如下：

    0 – Halt，关机模式
    1 – Single，单用户模式
    2 - Full multi-user with display manager (GUI)
    3 - Full multi-user with display manager (GUI)
    4 - Full multi-user with display manager (GUI)
    5 - Full multi-user with display manager (GUI)
    6 – Reboot，重启
可以发现2~5级是没有任何区别的。他们为多用户模式，这和一般的linux不一样。

sysv-rc-conf 是一个服务管理程序。

update-rc.d 类似与 RHEL 中的 chkconfig。

invoke-rc.d 类似与 RHEL 中的 service。


    echo $HISTSIZE
可以修改该参数，但重启电脑后失效，如需长久有效，在 /etc/profile 文件中配置。

