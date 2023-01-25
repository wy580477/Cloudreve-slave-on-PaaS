## Heroku已于2022年11月末关闭免费服务

## 鸣谢

- [FuaerCN/Cloudreve-Heroku](https://github.com/FuaerCN/Cloudreve-Heroku)
- [P3TERX/aria2.conf](https://github.com/P3TERX/aria2.conf)  

## 注意

 1. **请勿滥用，账号封禁风险自负**
 2. 容器的文件系统是临时性的，重启会恢复到部署时状态。不适合长期下载和共享文件用途。
 3. Aria2配置文件默认限速5MB/s。

## 概述

  本项目用于在支持Dockerfile或拉取容器镜像的PaaS服务上部署Cloudreve从机节点，集成Aria2离线下载功能。

  集成 [NodeStatus](https://github.com/cokemine/nodestatus) 探针客户端。[NodeStatus 服务端](https://github.com/wy580477/NodeStatus-Docker)也可以部署在 PaaS 平台上。
  
  每次部署会采用Cloudreve最新版本。
  
## 部署方式

 **请勿使用本仓库直接部署**  

 <details>
<summary><b>Heroku 部署方法</b></summary>

 1. 点击右上角Fork，再点击Create Fork。
 2. 在Fork出来的仓库页面上点击Setting，勾选Template repository。
 3. 然后点击Code返回之前的页面，点Setting下面新出现的按钮Use this template，起个随机名字创建新库。
 4. 仓库content目录下，conf.ini为Cloudreve设置文件，aria2.conf为aria2设置文件，可根据需要自行修改。tracker.sh用于每次dyno启动时自动更新BT tracker。
 5. 比如你的Github用户名是bobby，新库名称是green。浏览器登陆heroku后，访问<https://dashboard.heroku.com/new?template=https://github.com/bobby/green> 进行部署。
 6. 首先打开Cloudreve主机管理面板———离线下载节点，点接入新节点进入向导。
 7. 将从机密钥填入Secret变量。NodeStatus_DSN环境变量可选，为探针服务端连接信息，不设置则为禁用。示例：wss://username:password@status.mydomain.com
 8. Heroku完成部署后，将Heroku APP域名填入从机地址，Aria2 RPC服务地址为<http://127.0.0.1:61800> ，RPC密钥为空白。

  </details>

 <details>
<summary><b>支持 CI/CD 平台（Render，Northflank，Doprax等）部署方法</b></summary>

 1. 点击右上角Fork，再点击Create Fork。
 2. 在Fork出来的仓库页面上点击Setting，勾选Template repository。
 3. 然后点击Code返回之前的页面，点Setting下面新出现的按钮Use this template，起个随机名字创建新库。
 4. 仓库content目录下，conf.ini为Cloudreve设置文件，aria2.conf为aria2设置文件，可根据需要自行修改。tracker.sh用于每次容器启动时自动更新BT tracker。
 5. 首先打开Cloudreve主机管理面板———离线下载节点，点接入新节点进入向导。
 6. 在PaaS平台管理面板中连接你新建立的github仓库，然后进行部署。
 7. 在PaaS部署过程中建立Secret环境变量，值为从机密钥。如果需要设置内部 HTTP 端口，默认为3000，也可以自行设置 PORT 变量修改。
 8. NodeStatus_DSN环境变量可选，为探针服务端连接信息，不设置则为禁用。示例：wss://username:password@status.mydomain.com
 9. 完成部署后，将PaaS平台提供的域名填入从机地址，Aria2 RPC服务地址为<http://127.0.0.1:61800> ，RPC密钥为空白。

  </details>

 <details>
<summary><b>支持拉取容器镜像 PaaS 平台（Koyeb，Northflank等）部署方法</b></summary>

 1. 点击右上角Fork，再点击Create Fork。
 2. 在Fork出来的仓库页面上点击Setting，勾选Template repository。
 3. 然后点击Code返回之前的页面，点Setting下面新出现的按钮Use this template，起个随机名字创建新库。
 4. 仓库content目录下，conf.ini为Cloudreve设置文件，aria2.conf为aria2设置文件，可根据需要自行修改。tracker.sh用于每次容器启动时自动更新BT tracker。
 5. 点击仓库Settings > Actions > General，滚动到页面最下方，将Workflow permissions设置为Read and write permissions。
 6. 点击页面右侧 Create a new release，建立格式为 v0.1.0 的tag，其它内容随意，然后点击 Publish release。
 7. 大概不到一分钟后，github action 构建容器镜像完成，点击页面右侧 Packages, 再点击进入刚生成的 Package。
 8. 点击页面右侧 Package settings，在页面最下方点击 Change visibility，选择 public 并输入 package 名称以确认。
 9. 容器镜像拉取地址在 package 页面 docker pull 命令示例中。
 10. 首先打开Cloudreve主机管理面板———离线下载节点，点接入新节点进入向导。
 11. 在PaaS部署过程中建立Secret环境变量，值为从机密钥。如果需要设置内部 HTTP 端口，默认为3000，也可以自行设置 PORT 变量修改。
 12. NodeStatus_DSN环境变量可选，为探针服务端连接信息，不设置则为禁用。示例：wss://username:password@status.mydomain.com
 13. 完成部署后，将PaaS平台提供的域名填入从机地址，Aria2 RPC服务地址为<http://127.0.0.1:61800> ，RPC密钥为空白。

  </details>

## Cloudflare Workers反代

- https://github.com/wy580477/PaaS-Related/blob/main/CF_Workers_Reverse_Proxy_chs_simple.md
- 从机地址填写上面创建的Workers service域名。
- 国内workers.dev域名被阻断，可以使用Workers Route功能绑定自定义域名。
