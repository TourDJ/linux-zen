shopt 命令是set命令的一种替代，很多方面都和set命令一样，但它增加了很多选项。可有使用“-p”选项来查看shopt选项的设置。“-u”开关表示一个复位的选项，“-s”表示选项当前被设置。


**shopt命令参数用法**

|选项|	含义   |
|--------|-------------------------------------------------------------------|
|cdable_vars	|如果给cd内置命令的参数不是一个目录,就假设它是一个变量名,变量的值是将要转换到的目录|
|cdspell	|纠正cd命令中目录名的较小拼写错误.检查的错误包括颠倒顺序的字符,遗漏的字符以及重复的字符.如果找到一处需修改之处,正确的路径将打印出,命令将继续.只用于交互式shell|
|checkhash	|bash在试图执行一个命令前,先在哈希表中寻找,以确定命令是否存在.如果命令不存在,就执行正常的路径搜索|
|checkwinsize	|bash在每个命令后检查窗口大小,如果有必要,就更新LINES和COLUMNS的值|
|cmdhist	|bash试图将一个多行命令的所有行保存在同一个历史项中.这是的多行命令的重新编辑更方便|
|dotglob	|Bash在文件名扩展的结果中包括以点(.)开头的文件名|
|execfail	|如果一个非交互式shell不能执行指定给exec内置命令作为参数的文件,它不会退出.如果exec失败,一个交互式shell不会退出|
|expand_aliases	|别名被扩展.缺省为打开|
|extglob	|打开扩展的模式匹配特性(正常的表达式元字符来自Korn shell的文件名扩展)|
|histappend	|如果readline正被使用,用户有机会重新编辑一个失败的历史替换|
|histverify	|如果设置,且readline正被使用,历史替换的结果不会立即传递给shell解释器.而是将结果行装入readline编辑缓冲区中,允许进一步修改|
|hostcomplete	|如果设置,且readline正被使用,当正在完成一个包含@的词时bash将试图执行主机名补全.缺省为打开|
|huponexit	|如果设置,当一个交互式登录shell退出时,bash将发送一个SIGHUP(挂起信号)给所有的作业|
|interactive_comments	|在一个交互式shell中.允许以#开头的词以及同一行中其他的字符被忽略.缺省为打开|
|lithist	|如果打开,且cmdhist选项也打开,多行命令讲用嵌入的换行符保存到历史中,而无需在可能的地方用分号来分隔|
|mailwarn	|如果设置,且bash用来检查邮件的文件自从上次检查后已经被访问,将显示消息”The mail in mailfile has been read”|
|nocaseglob	|如果设置,当执行文件名扩展时,bash在不区分大小写的方式下匹配文件名|
|nullglob	|如果设置,bash允许没有匹配任何文件的文件名模式扩展成一个空串,而不是他们本身|
|promptvars	|如果设置,提示串在被扩展后再进行变量和参量扩展.缺省为打开|
|restricted_shell	|如果shell在受限模式下启动就设置这个选项.该值不能被改变.当执行启动文件时不能复位该选项,允许启动文件发现shell是否受限|
|shift_verbose	|如果该选项设置,当移动计数超出位置参量个数时,shift内置命令将打印一个错误消息|
|sourcepath	|如果设置,source内置命令使用PATH的值来寻找作为参数提供的文件的目录.缺省为打开|
|source	|点(.)的同义词|

删除目录下除了filename之外的所有文件

下来列出了不同的扩展模式匹配操作符，这些模式列表是一个用 | 分割包含一个或者多个文件名的列表：
通配符	含义
*(模式列表)	匹配 0 个或者多个出现的指定模式
?(模式列表)	匹配 0 个或者 1 个出现的指定模式
@(模式列表)	匹配 1 个或者多个出现的指定模式
!(模式列表)	匹配除了一个指定模式之外的任何内容
打开extglob shell选项

1
shopt -s extglob
删除目录下除了filename之外的所有文件

1
rm -v !("filename")
删除除了filename1和filename2之外的所有文件

1
rm -v !("filename1"|"filename2")
删除除了 .zip 之外的所有文件

1
rm -i !(*.zip)
关闭extglob shell选项

1
shopt -u extglob
