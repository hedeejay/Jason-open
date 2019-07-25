# 持续集成

## 环境要求

持续集成服务器需要安装gitbook和docker环境。目前公司的持续集成环境已具备条件。

## 步骤

- .项目中添加Dockerfile文件，内容如下：

FROM 10.114.72.21:5001/basicimages/nginx:v1.4

MAINTAINER hedj "hedj-ds@petrochina.com.cn"

RUN sed -i '1 i\user root;' /etc/nginx/nginx.conf

COPY \_book /var/www/html/website/dist

- .建立持续集成任务，可复制"wikin-open"任务进行修改。

修改的内容包含：

- .SVN 配制信息，包含地址，账号密码等：
- .指定构建环境，"构建环境"--\> 选中"Execute shell script on remote host using ssh"，SSH site 选择已经配制好的目标服务器，即需要部署的目标服务器。
- .Post build scrip内容 如下：

docker stop wikin-open

docker rm wikin-open

docker rmi 10.114.72.21:5001/wikin/wikin-open:2.1

docker run -dit -p 4000:8888  --name wikin-open  -v /etc/nginx   10.114.72.21:5001/wikin/wikin-open:2.1

将wikin-open和版本号2.1替换为你当前的内容。

- .设置构建脚本 "构建"--\> 执行 Shell --\>命令

在命令窗口 输入 构建脚本如下：

cd /root/.jenkins/workspace/wikin-open/

gitbook install

gitbook build

docker build  --no-cache -t 10.114.72.21:5001/wikin/wikin-open:2.1 .

docker push 10.114.72.21:5001/wikin/wikin-open:2.1

将wikin-open ，仓库地址等修改为你的内容。

- .最后点击保存即可。