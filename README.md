## 鸣谢

- [FuaerCN/Cloudreve-Heroku](https://github.com/FuaerCN/Cloudreve-Heroku)
- [P3TERX/aria2.conf](https://github.com/P3TERX/aria2.conf)  

## 注意

 1. **请勿滥用，账号封禁风险自负。**
 2. Heroku的文件系统是临时性的，每24小时强制重启一次后会恢复到部署时状态。不适合长期下载和共享文件用途。
 3. Aria2配置文件默认限速5MB/s。

## 概述

  本项目用于在Heroku上部署Cloudreve从机节点，集成Aria2离线下载功能。
  
## 部署方式

 **请勿使用本仓库直接部署**  

 1. 点击右上角Fork，再点击Create Fork。
 2. 在Fork出来的仓库页面上点击Setting，勾选Template repository。
 3. 然后点击Code返回之前的页面，点Setting下面新出现的按钮Use this template，起个随机名字创建新库。
 4. 比如你的Github用户名是bobby，新库名称是green。浏览器登陆heroku后，访问<https://dashboard.heroku.com/new?template=https://github.com/bobby/green> 进行部署。
 5. 首先打开Cloudreve主机管理面板———离线下载节点，点接入新节点进入向导。
 6. 将从机密钥填入Heroku Secret变量。
 7. Heroku完成部署后，将Heroku APP域名填入从机地址，Aria2 RPC服务地址为<http://127.0.0.1:61800> ，RPC密钥为空白。
 8. 仓库content目录下，conf.ini为Cloudreve设置文件，aria2.conf为aria2设置文件，tracker.sh用于每次dyno启动时自动更新BT tracker。
 9. 每次部署会采用Cloudreve最新版本。

## Cloudflare Workers反代

- [单双日交替使用不同dyno绕过Heroku非信用卡验证账号每月550小时限制](https://github.com/wy580477/PaaS-Related/blob/main/CF_Workers_Reverse_Proxy_chs.md)
- 从机地址填写上面创建的Workers service域名。
