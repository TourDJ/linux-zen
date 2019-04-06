
# Archlinux 安装

## 创建分区
使用 fdisk 或 parted 修改分区表。以使用 parted 分区为例。

打开 parted 交互模式：

    # parted /dev/sdx
为 BIOS 系统创建 MBR/msdos 分区表：

    (parted) mklabel msdos
为 UEFI 系统创建 GPT 分区表：

    (parted) mklabel gpt

命令创建分区：

    (parted) mkpart part-type fs-type start end
* part-type 是分区类型，可以选择 primary, extended 或 logical，仅用于 MBR 分区表.      
* fs-type 是文件系统类型，支持的类型列表可以通过 help mkpart 查看。 mkpart 并不会实际创建文件系统， fs-type 参数仅是让 parted 设置一个 1-byte 编码，让启动管理器可以提前知道分区中有什么格式的数据。
* start 是分区的起始位置，可以带单位, 例如 1M 指 1MiB.
* end 是设备的结束位置(不是 与 start 值的差)，同样可以带单位，也可以用百分比，例如 100% 表示到设备的末尾。
* 为了不留空隙，分区的开始和结束应该首尾相连。
示例见图：       
![parted 分区](https://github.com/TourDJ/linux-zen/blob/master/image/parted-msdoc.png)    

## 格式化分区

    # mkfs.ext4 /dev/sdX1

如果您创建了交换分区，格式交换分区
 
     # mkswap /dev/sdX2
     # swapon /dev/sdX2
 
## 挂载分区
格式化后，将根分区挂载到 /mnt

    # mount /dev/sdX1 /mnt

## 添加数据源
文件 `/etc/pacman.d/mirrorlist` 定义了软件包会从哪个 镜像源 下载。
打开镜像文件 `vim /etc/pacman.d/mirrorlist`增加服务器地址：

    Server = xxxxx/$repo/os$arch

更新源

    pacman -Syy

## 安装系统

pacstrap /mnt base base-devel

如果安装出错，执行以下命令：

    pacman-key --refresh-keys

## 配置系统
### Fstab
用以下命令生成 fstab 文件 (用 -U 或 -L 选项设置UUID 或卷标)：

    # genfstab -U /mnt >> /mnt/etc/fstab

切换到我们刚刚安装的那个系统的文件系统

    arch-chroot /mnt

### 安装 grub
下载grub

    pacman -S grub

安装grub到sda设备上

    grub-install /dev/sda 

生成配置文件

    grub-mkconfig -o /boot/grub/grub.cfg

### 本地化

    # nano /etc/locale.gen
    en_US.UTF-8 UTF-8
    zh_CN.UTF-8 UTF-8
    zh_TW.UTF-8 UTF-8
接着执行 locale-gen 以生成 locale 讯息：

    # locale-gen
/etc/locale.gen 会生成指定的本地化文件。

