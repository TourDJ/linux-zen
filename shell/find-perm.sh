

## Use `find . -type f -perm +6000` caused an error:
##      Invalid mode '+6000' with find -perm
## According to man pages of find perm +mode is deprecated 
## use `find / -perm /6000 -type f` instead
##  -perm +mode
##      This is no longer supported (and has been deprecated since 2005).  Use -perm /mode instead
## 

## File's  permission  bits are exactly mode (octal or symbolic).
find . -type f -perm 6000
## All of the permission bits mode are set for the file. 
find . -type f -perm -6000
## Any of the permission bits mode are set for the file.
find . -type f -perm /6000

## How to search for all SUID/SGID files?
find / -type f -perm /6000

