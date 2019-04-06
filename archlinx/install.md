
Archlinux 安装

创建分区
使用 parted 分区
![parted 分区]()    

格式化分区
# mkfs.ext4 /dev/sdX1

格式交换分区
 # mkswap /dev/sdX2
 # swapon /dev/sdX2
 
 挂载分区
mount /dev/sdX1 /mnt

添加数据源
vim /etc/pacman.d/mirrorlist
增加
Server = xxxxx/$repo/os$arch

更新源
pacman -Syy

安装系统
pacstrap /mnt base base-devel

配置系统
Fstab
用以下命令生成 fstab 文件 (用 -U 或 -L 选项设置UUID 或卷标)：

# genfstab -U /mnt >> /mnt/etc/fstab


