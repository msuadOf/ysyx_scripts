#!/bin/bash

export MAX_THREAD=2 #`nproc`
echo "cpu:"  $MAX_THREAD

export HOSTIP=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")

export http_proxy="http://$HOSTIP:7890"
export https_proxy="http://$HOSTIP:7890"
export all_proxy="socks5://$HOSTIP:7890"
export ALL_PROXY="socks5://$HOSTIP:7890"

# export proxy_server=172.20.53.1

# export HTTPS_PROXY=http://${proxy_server}:7890
# export HTTP_PROXY=http://${proxy_server}:7890
# export http_proxy=http://${proxy_server}:7890
# export https_proxy=http://${proxy_server}:7890

# echo ${HTTPS_PROXY}
