
## tmux 常用命令

#### session
start tmux with a new session

    tmux
    
#### window

Creating Windows

    C-b c
switch window 

    C-b p
    C-b n
    C-b <number>
detach your current session

    C-b d
    C-b D
list all running sessions

    tmux ls
attach session

    tmux attach -t 0
    tmux new -s database
    
#### panel
Splitting Panes

    C-b % //horizontal
    C-b " //vertial
Navigating Panes

    C-b <arrow key>
Closing Panes

    type exit or hit Ctrl-d
    
***
#### tmux 文章链接：     
[A Quick and Easy Guide to tmux](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)    
[Tmux 入门介绍](http://blog.jobbole.com/87278/)     
[Tmux 速成教程：技巧和调整](http://blog.jobbole.com/87584/)      

