# overseas-server-free (海外服务器免费)

**本项目帮助中国用户合法使用国外的服务器网络**
## 当前版本：1.0-20240305-final
（1.0最终版）
***
## 简介：
该项目适用于中国用户连接国外服务器困难问题。由于中国的计算机不可直接进行国际联网，而一条专线又无比难开，并且某某加速器直接VPN连接也冒着违法的风险，所以就萌生生的有了这个《直接在国外服务器操作》的想法，这就让众多中国博主的福来了，可以登youtube twitter tiktok等等网站。
## 前提：
一个Github或GitLab账号，一台正常使用的电脑（能正常使用Chromium类浏览器就行），一个正常运转的脑子
## 食用方法：
打开Gitpod官网（下方），登录你的GitHub/GitLab账号。  
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/giaostu1010/overseas-server-free)  
然后在新的页面创建workspace，Editor选VSCode Browser，配置根据自己需求选择。continue。进入vscode。弹出新的页面，会自动启动terminal，输入以下命令：
```shell
sudo su
bash gui.sh
# 根据提示按回车输y，等待执行完成
startvnc
```
此时来到PORTS选项卡，点开带6080端口的链接（6080-.....io），新页面点击vnc.html，connect，输入在gui.sh里设置的密码登录VNC。要打开浏览器，点击桌面上的Home文件夹，左上角菜单点Open in terminal，黑色窗口输入firefox即可使用。
## 下一步要实现的计划
计划|实现
-|-
中文输入法|x
桌面优化|x
汉化|x
...|...
  
感兴趣者欢迎pull request。
## 更新动态
版本号|更新内容
-|-
1.0-20240305-final|修复判断的问题，重排版Readme，完善一键安装浏览器
1.0-20240304|初版调试