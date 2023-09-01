#!/bin/bash

export MAX_THREAD=12 #`nproc`
echo "cpu:"  $MAX_THREAD

export HOSTIP=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")

if [ $? -ne 0 ] ; then
    echo -e "\e[31m[Error]\e[0m:proxy ($HOSTIP) failed" 
else
    export http_proxy="http://$HOSTIP:7890"
    export HTTP_PROXY="http://$HOSTIP:7890"
    export https_proxy="http://$HOSTIP:7890"
    export HTTPS_PROXY="http://$HOSTIP:7890"
    export all_proxy="socks5://$HOSTIP:7890"
    export ALL_PROXY="socks5://$HOSTIP:7890"
    echo -e "\e[32m[Success]\e[0m:proxy ($HOSTIP) connected"
fi

# export proxy_server=172.20.53.1

# export HTTPS_PROXY=http://${proxy_server}:7890
# export HTTP_PROXY=http://${proxy_server}:7890
# export http_proxy=http://${proxy_server}:7890
# export https_proxy=http://${proxy_server}:7890

# echo ${HTTPS_PROXY}
