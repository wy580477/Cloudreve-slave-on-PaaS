## 鸣谢
- [FuaerCN/Cloudreve-Heroku](https://github.com/FuaerCN/Cloudreve-Heroku)
- [P3TERX/aria2.conf](https://github.com/P3TERX/aria2.conf)  
## 注意
 1. **请勿滥用，重度使用可能导致账号被封。**
 2. Heroku的文件系统是临时性的，每24小时强制重启一次后会恢复到部署时状态。不适合长期BT下载和共享文件用途。
 3. Aria2配置文件默认限速5MB/s。

## 概述
  本项目用于在Heroku上部署Cloudreve从机节点，集成Aria2离线下载功能。
  
## 部署方式

 **请勿使用本仓库直接部署**  
 
  **Heroku修复安全漏洞中，目前无法通过网页从私有库部署**  
 
 1. 点击右上角Fork，再点击Creat Fork。
 2. 在Fork出来的仓库页面上点击Setting，勾选Template repository。
 3. 然后点击Code返回之前的页面，点Setting下面新出现的按钮Use this template，起个随机名字创建新库。
 4. 比如你的Github用户名是bobby，新库名称是green。浏览器登陆heroku后，访问https://dashboard.heroku.com/new?template=https://github.com/bobby/green 进行部署。
 5. 首先打开Cloudreve主机管理面板———离线下载节点，点接入新节点进入向导。
 6. 将从机密钥填入Heroku Secret变量。
 7. Heroku完成部署后，将Heroku APP域名填入从机地址，Aria2 RPC服务地址为http://127.0.0.1:6800 ，RPC密钥为空白。
 8. HEROKU_API_KEY, HEROKU_APP_NAME, HEROKU_RESTART_TIME三个变量用于固定Heroku dyno重启时间。Heroku的重启周期是24-27小时左右，这三项变量设置好以后可以把Heroku dyno重启周期固定到24小时，避免出现随机重启的情况。
 9. 仓库content目录下，conf.ini为Cloudreve设置文件，aria2.conf为aria2设置文件，tracker.sh用于每次dyno启动时自动更新BT tracker。



