#!/bin/bash

#proxy
export HOSTIP=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")
export http_proxy="http://$HOSTIP:7890"
export https_proxy="http://$HOSTIP:7890"
export all_proxy="socks5://$HOSTIP:7890"
export ALL_PROXY="socks5://$HOSTIP:7890"

export CURRENT_Dir=$(cd `dirname $0`; pwd)
export PARENT_Dir=$(cd $(dirname $0);cd ..; pwd)
echo "CURRENT_Dir = "$CURRENT_Dir
echo "PARENT_Dir = "$PARENT_Dir

cd $CURRENT_Dir
# sh ./PA0_01_dev_env.sh  

cd $PARENT_Dir

# ssh-keygen -t rsa -C "1445617868@qq.com"
git config --global user.email "1445617868@qq.com"
git config --global user.name "msuad"

bash init.sh nemu
bash init.sh abstract-machine
bash init.sh nvboard

source ~/.bashrc

echo $NEMU_HOME
echo $AM_HOME

sudo apt install bison flex -y
