#!/bin/sh 
# To uncompress mutliple kind file format 
 
ftype=`file "$1"`                                                                                                 
case "$ftype" in  
    "$1: Zip archive"*) 
        unzip "$1" ;;  
    "$1: gzip compressed"*) 
        tar -zxvf "$1" ;; ##gunzip "$1" ;; 
    "$1: XZ compressed"*) 
        xz -dk "$1" ;;
    "$1: bzip2 compressed"*) 
        tar -jxvf "$1" ;; ##bunzip2 "$1" ;; 
    "$1: RAR archive"*) 
        unrar e "$1" ;;
    "$1: compress'd"*) 
        tar -Zxvf "$1" ;;
    "$1: POSIX tar"*) 
        tar -xvf "$1" ;;
    *)  
        echo "File $1 can not be uncompressed with extract";; 
esac
