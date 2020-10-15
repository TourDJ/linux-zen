

## linux 解压缩命令

* tar 文件解压缩

        tar -cvf jpg.tar *.jpg
        tar -xvf file.tar
* tar.gz 文件解压缩

        tar -zcvf jpg.tar.gz *.jpg
        tar -zxvf file.tar.gz
* tar.bz2 文件解压缩

        tar -jcvf jpg.tar.bz2 *.jpg
        tar -jxvf file.tar.bz2
* tar.Z 文件解压缩

        tar -Zcvf jpg.tar.Z *.jpg
        tar -Zxvf file.tar.Z
* rar 文件解压缩

        rar a jpg.rar *.jpg
        unrar e file.rar
* zip 文件解压缩

        zip jpg.zip *.jpg
        unzip file.zip 
* xz 文件解压缩

        xz -z 要压缩的文件
        xz -d 要解压的文件
        使用 -k 参数来保留被解压缩的文件
其他

        *.gz 用 gzip -d或者gunzip 解压
        *.bz2 用 bzip2 -d或者用bunzip2 解压
        *.Z 用 uncompress 解压
