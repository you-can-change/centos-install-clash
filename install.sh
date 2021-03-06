#!/bin/bash

my_install(){
  yum -y install nginx
  mkdir -p /opt/clash
  \cp src/clash /opt/clash/
  \cp src/Country.mmdb /opt/clash/
  \cp -ap src/clash-dashboard /opt/clash/
  \cp src/sync_config.sh /opt/clash/
  
  \cp src/clash.service  /etc/systemd/system/clash.service
  \cp src/vpn-proxy.conf  /etc/nginx/conf.d/vpn-proxy.conf
  \cp src/vpn-proxy.cron  /etc/cron.d/vpn-proxy.cron
  \cp src/vpn-proxy.sh /etc/profile.d/vpn-proxy.sh
  systemctl daemon-reload
  sh src/sync_config.sh
  systemctl enable --now nginx clash crond
  systemctl reload nginx crond
  echo "--------------------------------------------------------------------------------------------------------------"
  echo "Install successful. Run command: 'source /etc/profile.d/vpn-proxy.sh' to enable proxy settings."
  echo "Then you can use browser open http://{you-server-ip}/ui to visit the clash-dashboard, choice a available line."
  echo "come back shell, Run test command 'curl -I -m 3 -o /dev/null -s -w %{http_code}  www.google.com'"
  echo "--------------------------------------------------------------------------------------------------------------"
}

my_uninstall(){
  rm -rf /etc/systemd/system/clash.service 
  rm -rf /etc/nginx/conf.d/vpn-proxy.conf 
  rm -rf /etc/cron.d/vpn-proxy.cron
  rm -rf /etc/profile.d/vpn-proxy.sh
  rm -rf /opt/clash
  systemctl daemon-reload
  systemctl stop clash
  systemctl reload crond
  echo "--------------------------------------------------------------------------------------------------------------"
  echo "Uninstall successful. Run command: 'unset no_proxy http_proxy https_proxy' to remove proxy settings."
  echo "--------------------------------------------------------------------------------------------------------------"
}

show_help(){
  echo
  echo "Usage: sh $0 [install|unintall|-i|-u]"
  echo
}

case $1 in
  install|-i) my_install;;
  uninstall|-u) my_uninstall;;
  *) show_help ;;
esac
