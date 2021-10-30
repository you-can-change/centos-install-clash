#!/bin/bash

source ./env.sh
base_path=/opt/clash

restor_config(){
  echo 'sync fail, restore...'
  [ -f ${base_path}/config_bak/config.yaml ] && \mv ${base_path}/config_bak/config.yaml ${base_path}/config.yaml && systemctl restart clash && echo 'restore ok'
}

makesure_network(){
  proxy_status=$(curl -I -m 3 -o /dev/null -s -w %{http_code}  www.baidu.com)
  [ $proxy_status != 200 ] && unset no_proxy http_proxy https_proxy
}

backup(){
  mkdir -p ${base_path}/config_bak
  [ -f ${base_path}/config.yaml ] && \mv ${base_path}/config.yaml ${base_path}/config_bak/config.yaml && echo "backup ok." || echo "conf not exist"
  
}

sync_config(){
  makesure_network
  wget -q -O ${base_path}/config.yaml $subscribe_addr && \
  sed -i "s/mode: rule/mode: global/g;s/log-level: silent/log-level: info/g;s/secret: ''/secret: '$ui_secret'/g;s%# external-ui: folder%external-ui: ${base_path}/clash-dashboard/dist%g" ${base_path}/config.yaml && \
  systemctl restart clash && echo "sync ok" && return 0 || { echo "sync fail" && return 1; }
}


backup && sync_config || restor_config
