

## ACL
ACL，就是Access Control List，一个文件/目录的访问控制列表，可以针对任意指定的用户/组分配RWX权限。它在UGO权限管理的基础上为文件系统提供一个额外的、更灵活的权限管理机制。它被设计为UNIX文件权限管理的一个补充。ACL允许你给任何的用户或用户组设置任何文件/目录的访问权限。

### 检查是否支持ACL
命令：

       sudo tune2fs -l /dev/sda1 |grep "Default mount options:"
       Default mount options:                 user_xattr    acl
       sudo dumpe2fs -h /dev/sda2 |grep "Default mount options:"
       Default mount options:                 user_xattr    acl
从输出中可以看出已经加入 acl 支持。


### ACL 权限查看
命令格式： `getfacl `

说明：

       For  each  file,  getfacl displays the file name, owner, the group, and the Access Control List (ACL). If a directory has a default ACL, getfacl also displays the default ACL. Non-directories cannot have default ACLs.

       If getfacl is used on a file system that does not support ACLs, getfacl displays the access permissions defined by the traditional file mode permission bits.

       The output format of getfacl is as follows:
               1:  # file: somedir/
               2:  # owner: lisa
               3:  # group: staff
               4:  # flags: -s-
               5:  user::rwx
               6:  user:joe:rwx               #effective:r-x
               7:  group::rwx                 #effective:r-x
               8:  group:cool:r-x
               9:  mask::r-x
              10:  other::r-x
              11:  default:user::rwx
              12:  default:user:joe:rwx       #effective:r-x
              13:  default:group::r-x
              14:  default:mask::r-x
              15:  default:other::---

       Lines 1--3 indicate the file name, owner, and owning group.

       Line 4 indicates the setuid (s), setgid (s), and sticky (t) bits: either the letter representing the bit, or else a dash (-). This line is included if any of those bits is set  and  left  out
       otherwise, so it will not be shown for most files. (See CONFORMANCE TO POSIX 1003.1e DRAFT STANDARD 17 below.)

       Lines  5,  7  and 10 correspond to the user, group and other fields of the file mode permission bits. These three are called the base ACL entries. Lines 6 and 8 are named user and named group
       entries. Line 9 is the effective rights mask. This entry limits the effective rights granted to all groups and to named users. (The file owner and others permissions are not affected  by  the
       effective  rights  mask;  all  other entries are.)  Lines 11--15 display the default ACL associated with this directory. Directories may have a default ACL. Regular files never have a default
       ACL.

       The default behavior for getfacl is to display both the ACL and the default ACL, and to include an effective rights comment for lines where the rights of the entry differ from  the  effective
       rights.

       If output is to a terminal, the effective rights comment is aligned to column 40. Otherwise, a single tab character separates the ACL entry and the effective rights comment.

       The ACL listings of multiple files are separated by blank lines.  The output of getfacl can also be used as input to setfacl.

       PERMISSIONS
       Process  with  search access to a file (i.e., processes with read access to the containing directory of a file) are also granted read access to the file's ACLs.  This is analogous to the per‐
       missions required for accessing the file mode.


### ACL 权限设置
命令格式：  

       setfacl [-bkRd] [{-m|-x} acl参数] 目标文件名
选项与参数：
* -m ：配置后续的 acl 参数给文件使用，不可与 -x 合用；
* -x ：删除后续的 acl 参数，不可与 -m 合用；
* -b ：移除所有的 ACL 配置参数；
* -k ：移除默认的 ACL 参数，关于所谓的『默认』参数于后续范例中介绍；
* -R ：递归配置 acl ，亦即包括次目录都会被配置起来；
* -d ：配置『默认 acl 参数』的意思！只对目录有效，在该目录新建的数据会引用此默认值

ACL 主要可以针对几个项目来控制权限呢：

* 使用者 (user)：可以针对使用者来配置权限；
* 群组 (group)：针对群组为对象来配置其权限；
* 默认属性 (mask)：还可以针对在该目录下在创建新文件/目录时，规范新数据的默认权限；


