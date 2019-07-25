# gitbook serve 随机出现找不到文件的错误

- 操作系统: Win7、Win10  
GitBook version is 3.2.3  
Nodejs: v8.9.1  
**步骤**:  
编辑文件: C:\Users[user].gitbook\versions\3.2.3\lib\output\website\copyPluginAssets.js  
修改两个地方： copyAssets(output, plugin) 和 copyResources(output, plugin):

  将    
  `confirm: true`  
  修改为  
   `confirm: false`


- 制作docker镜像，Dockerfile文件：
  
```
FROM node:8.11-alpine

RUN npm install --global gitbook-cli && \
    gitbook fetch 3.2.3 && \
    gitbook install && \
    npm cache clear --force && \
    rm -rf /tmp/*

   RUN sed -i.bak 's/confirm: true/confirm: false/g' \
    /root/.gitbook/versions/3.2.2/lib/output/website/copyPluginAssets.js
```

- Build the image:  
    `$ docker build . -t gitbook`
- Write README.md example:  
    `$ echo "# Hello Gitbook" > README.md`
- Build a book:  
    `$ docker run -v $(pwd):/gitbook -w /gitbook --rm -it gitbook gitbook build . output`