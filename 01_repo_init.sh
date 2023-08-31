#!/bin/bash

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

source ~/.bashrc

echo $NEMU_HOME
echo $AM_HOME

sudo apt install bison flex -y
