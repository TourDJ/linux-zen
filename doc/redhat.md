
## redhat 系列

#### CentOS 7 安装 google-chrome 浏览器
1，下载 chrome 的 rpm 包 google-chrome-stable_current_x86_64.rpm       
2，切换到安装包目录，执行命令：        

    yum localinstall google-chrome-stable_current_x86_64.rpm 
3， 在 CentOS 7 下可能会报以下错误  
    
    Couldn't open file /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6    
4，到 CentOS 官网上 https://www.centos.org/keys/ 下载 CentOS 6 的 key，在 /etc/pki/rpm-gpg/ 目录下 创建 RPM-GPG-KEY-CentOS-6，拷贝 key，用以下命令验证以下 key 值：

    gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
5，继续执行安装命令，如果报以下错误：   

    NOKEY Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
6，执行命令： 

    rpm --import /etc/pki/rpm-gpg/RPM*    
7，再执行安装命令即可。
