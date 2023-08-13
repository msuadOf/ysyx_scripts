#!/bin/sh

export MAX_THREAD=16

export proxy_server=172.20.53.1

export HTTPS_PROXY=http://${proxy_server}:7890
export HTTP_PROXY=http://${proxy_server}:7890
export http_proxy=http://${proxy_server}:7890
export https_proxy=http://${proxy_server}:7890


