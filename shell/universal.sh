
## 想要知道某个日期的累积日数， 可使用如下的程序计算：
echo $(($(date --date="2008/09/04" +%s)/86400+1))

## 查出整个系统内属于 username 的文件
find / -user username
