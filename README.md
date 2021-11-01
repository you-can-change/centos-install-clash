# 简介
> 基于[clash](https://github.com/Dreamacro/clash)和[clash-dashboard](https://github.com/Dreamacro/clash-dashboard), 方便在linux上使用.
- clash: `Clash v1.7.1 linux amd64 with go1.17 Wed Sep 15 12:22:57 UTC 2021`
- clash-dashboard: `latest`

## 安装
```bash
# 1. 克隆仓库
git clone https://github.com/you-can-change/centos-install-clash.git
cd centos-install-clash

# 2. 将env.sh中的参数修改成合适的值.
# 订阅地址
subscribe_addr='<you_subscribe_addr>'
# web ui的密码
ui_secret='<ui_secret>'

# 2. 安装
sh install.sh -i

# 3. 卸载
sh install.sh -u

# 4. 使用.
开启代理: source /etc/profile.d/vpn-proxy.sh
停止代理: unset no_proxy http_proxy https_proxy

```
## 其他-打包
```bash
cd /opt
tar zcvf centos-install-clash.tar.gz centos-install-clash/ --exclude=config.yaml --exclude=config_bak
```
