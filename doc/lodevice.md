## 什么是loop设备？
loop设备是一种伪设备，是使用文件来模拟块设备的一种技术，文件模拟成块设备后, 就像一个磁盘或光盘一样使用。在使用之前，一个 loop 设备必须要和一个文件进行连接。这种结合方式给用户提供了一个替代块特殊文件的接口。因此，如果这个文件包含有一个完整的文件系统，那么这个文件就可以像一个磁盘设备一样被 mount 起来。

之所以叫loop设备（回环），其实是从文件系统这一层来考虑的，因为这种被 mount 起来的镜像文件它本身也包含有文件系统，通过loop设备把它mount起来，它就像是文件系统之上再绕了一圈的文件系统，所以称为 loop。

## loop设备的使用
一般在linux中会有8个loop设备，一般是/dev/loop0~loop7，可用通过losetup -a查看所有的loop设备，如果命令没有输出就说明所有的loop设备都没有被占用，你可以按照以下步骤创建自己的loop设备。

1）创建一个文件

    $ dd if=/dev/zero of=/var/loop.img bs=1M count=10240

2）使用losetup将文件转化为块设备

    $ losetup /dev/loop0 /var/loop.img

3）通过lsblk查看刚刚创建的块设备
lsblk |grep loop0
losetup -a

4）你也可以将这个块设备格式化并创建其他的文件系统，然后再mount到某个目录

    $ mkfs -t ext3 /dev/loop0
    $ mount /dev/loop0 /tmp

5）要删除这个loop设备可以执行以下命令

    $ losetup -d /dev/loop0


## losetup命令

    losetup [ -e encryption ] [ -o offset ] loop_device file
    losetup [ -d ] loop_device

说明：             
此命令用来设置循环设备。循环设备可把文件虚拟成块设备，籍此来模拟整个文件系统，让用户得以将其视为硬盘驱动器，光驱或软驱等设备，并挂入当作目录来使用。
上面，命令格式中的选项与参数名：      
-e 表示加密的方式       
-o 设置数据偏移量     
-d 卸载设备      

loop_device 循环设备名，在 linux 下如 /dev/loop0 , /dev/loop1 等。
file 要与循环设备相关联的文件名，这个往往是一个磁盘镜象文件，如 *.img

