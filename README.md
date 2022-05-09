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

 1. 点击右上角Fork，再点击Create Fork。
 2. 在Fork出来的仓库页面上点击Setting，勾选Template repository。
 3. 然后点击Code返回之前的页面，点Setting下面新出现的按钮Use this template，起个随机名字创建新库。
 4. 比如你的Github用户名是bobby，新库名称是green。浏览器登陆heroku后，访问<https://dashboard.heroku.com/new?template=https://github.com/bobby/green> 进行部署。
 5. 首先打开Cloudreve主机管理面板———离线下载节点，点接入新节点进入向导。
 6. 将从机密钥填入Heroku Secret变量。
 7. HEROKU_API_KEY, HEROKU_APP_NAME, HEROKU_RESTART_TIME三个变量用于固定Heroku dyno重启时间。Heroku的重启周期是24-27小时左右，这三项变量设置好以后可以把Heroku dyno重启周期固定到24小时，避免出现随机重启的情况。如果通过Cloudflare Workers反代实现单双日切换dyno，此三项不需要填写，Workers将通过指定的时区定时切换到单双日指定的dyno，重置24小时重启周期。
 8. Heroku完成部署后，将Heroku APP域名填入从机地址，Aria2 RPC服务地址为<http://127.0.0.1:61800> ，RPC密钥为空白。
 9. 仓库content目录下，conf.ini为Cloudreve设置文件，aria2.conf为aria2设置文件，tracker.sh用于每次dyno启动时自动更新BT tracker。
 10. 每次部署会采用Cloudreve最新版本。

## Cloudflare Workers反代

   **单双日交替使用不同dyno绕过Heroku非信用卡验证账号每月550小时限制**

- 单双日切换dyno绕过Heroku每个月550小时限制，需要两个Heroku账号分别部署使用相同从机密钥的dyno
- 登陆cloudflare账号
- 点击左侧导航栏workers，选择Create a Service
- 创建service以后，点击Quick Edit
- 将如下代码粘贴进左侧编辑区

 ```
const SingleDay = 'cloudreve1.herokuapp.com'
const DoubleDay = 'cloudreve2.herokuapp.com'
const timezone = 'Etc/GMT+2'; 

addEventListener(
    "fetch",event => { 

        let localized_date = new Date(new Date().toLocaleString('en-US', { timeZone: timezone }));
        if (localized_date.getDate()%2) {
            host = SingleDay
        } else {
            host = DoubleDay
        }

        let url=new URL(event.request.url);
        url.hostname=host;
        let request=new Request(url,event.request);
        event. respondWith(
            fetch(request)
        )
    }
)
```

- 第一行和第二行分别填单双日所使用的Heroku dyno域名，第三行是通过时区控制切换dyno的时间，范围从Etc/GMT-12到Etc/GMT+12。
- 点击Save and Deploy即可生效。
- 从机地址填写上面创建的Workers service域名。
