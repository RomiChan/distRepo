# distRepo

本仓库是`go-cqhttp`的rpm/deb仓库地址。目前正在进行调试，欢迎各位尝鲜！

## CentOS, RHEL, Fedora (dnf) 选手
Step1: 添加仓库
> sudo dnf config-manager --add-repo https://cdn.jsdelivr.net/gh/gocq/distRepo/rpm/go-cqhttp.repo  
 
Step2: 安装

> sudo dnf install go-cqhttp

如果您是`CentOS7`选手，请`sudo yum install dnf`安装`dnf`或手动添加仓库。  

如果您在运行`dnf config-manager`提示`No such command: config-manager`, 那么请尝试运行`dnf install dnf-plugin-config-manager`, 然后继续执行添加仓库操作

## Debian, Ubuntu 选手

Step1: 添加公钥
> curl -s https://cdn.jsdelivr.net/gh/gocq/distRepo/rpm/gpg_key_pub | sudo apt-key add -

Step2: 添加仓库
> cp /etc/apt/sources.list /etc/apt/sources.list.bak  
> echo deb https://cdn.jsdelivr.net/gh/gocq/distRepo/deb nini main >> /etc/apt/sources.list

Step3: 安装
>sudo apt update  
>sudo apt install go-cqhttp
