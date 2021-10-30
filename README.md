# 简介
> 基于[clash](https://github.com/Dreamacro/clash)和[clash-dashboard](https://github.com/Dreamacro/clash-dashboard), 方便在linux上使用.
- clash: `Clash v1.7.1 linux amd64 with go1.17 Wed Sep 15 12:22:57 UTC 2021`
- clash-dashboard: latest

```bash
# 0. 需要将包放在/opt下.

# 1. 将env.sh中的参数修改成合适的值.
# 订阅地址
subscribe_addr='<you_subscribe_addr>'
# web ui的密码
ui_secret='<ui_secret>'


# 2. 安装
sh install.sh -i

# 3. 卸载
sh install.sh -u

# 4. 打包
cd /opt
tar zcvf clash.tar.gz clash/ --exclude=config.yaml --exclude=config_bak
```
