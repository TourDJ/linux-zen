

## Use `find . -type f -perm +6000` caused an error:
##      Invalid mode '+6000' with find -perm
## According to man pages of find perm +mode is deprecated 
## use `find / -perm /6000 -type f` instead
## see: https://askubuntu.com/questions/1126527/invalid-mode-6000-with-find-perm
## so:

##  strict match
find . -type f -perm 6000
##
find . -type f -perm -6000
##
find . -type f -perm /6000

## How to search for all SUID/SGID files?
find / -type f -perm /6000

