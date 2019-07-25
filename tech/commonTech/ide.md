

# 微服务后台开发

## 环境搭建手册


文件必须解压到指定的目录!!!  否则IDE的配制不能生效。

环境搭建步骤：

第一步，解压文件到指定目录。

存放目录为：D:\javaEnv\_V2.0

最终的目录结构为：

D:\javaEnv\_V2.0

  |--apache-maven-3.3.9

  |--jdk1.8.0\_102

  |--maven repository

  ...

第二步,执行批处理文件，设置JDK和MAVEN环境变量。

以管理员身份运行批处理文件：JEE Environment Setup v2.0.bat

第三步，创建桌面快捷方式。

在文件D:\javaEnv\_V2.0\sts-bundle\sts-3.8.4.RELEASE\STS.exe 上右键，选择"发送到"，选择"桌面快捷方式"。

第四步：重启电脑，使配置生效，环境搭建即完成，启动开发环境，双击桌面STS.exe即可。



备注：

1 如果启动报错：Failed to load the JNI shared library ，需重启电脑。

2 执行批处理文件,JEE Environment Setup v2.0.bat，会覆盖之前JDK和MAVEN的环境变量。

3 Oracle 连接工具plsql为绿色版，且自带oracle 客户端，如需使用，请查看D:\javaEnv\_V2.0\PLSQL10\readme.txt进行配制。

4 maven仓库地址为成都分公司的私有仓库，如不能连接，请切换为阿里仓库。方法为修改文件D:\javaEnv\_V2.0\apache-maven-3.3.9\conf\settings.xml

  修改mirrors.mirror.url 为http://maven.aliyun.com/nexus/content/groups/public/

5 如需使用Mysql或SQLServer客户端，可使用Navicat Premium ，请查看D:\javaEnv\_V2.0\Navicat Premium\readMe.txt进行配制。
