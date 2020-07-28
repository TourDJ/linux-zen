
## Shell 语法之信号与作业
Linux 使用信号与系统上运行的进程进行通信。

**Linux 编程中最常见的 Linux 系统信号**

|信号 |　　值　|   描述      |
|----|-----------|-----------------------------------|
|1 　|SIGHUP 　　 |挂起进程|
|2 　|SIGINT 　　 |中断进程|
|3 　|SIGQUIT 　　|停止进程|
|9 　|SIGKILL 　　|无条件终止进程|
|15  |SIGTERM 　　|如果可能的话终止进程|
|17  |SIGSTOP 　　|无条件停止，但不终止进程|
|18  |SIGTSTP 　　|停止或暂停进程，但不终止它|
|19  |SIGCONT 　  |重新启动停止的进程|

默认情况下，bash shell 会忽略它接收的任何 SIGQUIT 和 SIGTERM 信号。

 

### 中断进程

Ctrl + C 组合键可以生成 SIGINT 信号

 
### 暂停进程

Ctrl +Z 组合键生成 SIGTSTP 信号


### 捕获信号

`trap` 命令可以指定能够通过 shell 脚本监控和拦截 Linux 信号。如果脚本收到在 `trap` 命令中列出的信号，它将保护该信号不被 shell 处理，并在本地处理它。

格式：

    trap commands signals

示例
```shell
#!/bin/bash
# testing output in a background job

trap "echo Haha" SIGINT SIGTERM
echo "This is a test program"
count=1
while [ $count -le 10 ]
do
    echo "Loop #$count"
    sleep 10
    count=$[ $count + 1 ]
done
echo "This is the end of the test program"
```
在用户试图使用 bash shell 键盘 CTRL+ C 命令停止程序时，脚本将不受影响。

    [root@tang sh13]# ./test1
    This is a test program
    Loop #1
    Haha
    Loop #2
    Haha
    Loop #3
    Loop #4
    Loop #5
    Haha
    Loop #6
    Loop #7
    Loop #8
    Loop #9
    Loop #10
    This is the end of the test program


### 捕获脚本退出

要捕获 shell 脚本 退出，只需要向 trap 命令添加 EXIT 信号。

示例
```shell
#!/bin/bash
# trapping the script exit

trap "echo byebye" EXIT

count=1
while [ $count -le 5 ]
do
    echo "Loop #$count"
    sleep 3
    count=$[ $count + 1 ]
done
```
调用

    [root@tang sh13]# ./test2
    Loop #1
    byebye

 

### 移除捕获

要移除捕获，使用破折号(-)作为命令和想要恢复正常行为的信号列表

示例
```shell
#!/bin/bash
# removing a set trap

trap "echo byebye" EXIT

count=1
while [ $count -le 5 ]
do
echo "Loop #$count"
sleep 3
count=$[ $count + 1 ]
done
trap - EXIT
echo "I just removed the trap"
```
调用

    [root@tang sh13]# ./test3
    Loop #1
    Loop #2
    Loop #3
    Loop #4
    Loop #5
    I just removed the trap

 

### 作业控制

作业控制的关键命令是 `jobs` 命令

示例
```shell
#!/bin/bash
# testing job control

echo "This is a test program $$"
count=1

while [ $count -le 10 ]
do
    echo "Loop #$count"
    sleep 10
    count=$[ $count + 1 ]
done
echo "This is the end of the test program"
```
调用

    [root@tang sh13]# ./test4
    This is a test program 7049
    Loop #1
    Loop #2

    [2]+ Stopped ./test4
    [root@tang sh13]# jobs
    [1]- Stopped ./test4
    [2]+ Stopped ./test4

 

### 重启停止的作业

要以后台模式重新启动作业，使用带有编号的 `bg` 命令

    [root@tang sh13]# bg 1
    [1]- ./test4 &
    [root@tang sh13]# Loop #2
    Loop #3
    Loop #4

    ...

 

要以前台模式重新启动作业，使用带有编号的 `fg` 命令

    [root@tang sh13]# fg 2
    ./test4
    Loop #3
    Loop #4

    ...
