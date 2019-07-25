## 1.

维护时间：2018-08-27

维护人员：

维护内容：创建文档

# 2. 工程管理

## 2.1. 工程命名规范

工程命名结构为 **工程性质** - **应用名**

工程名全部为小写字母工程性质：平台：ctp         应用：apps(A8应用)、cip(集成应用)、dee(交换引擎应用)等应用名：功能的[英文]描述，尽量为单个单词，不能使用缩写，不能使用拼音

## 2.2. 工程结构

- .v5开发工程使用业界通用的工程结构
- .工程名称使用统一的工程命名
- .业务代码统一放在包com.seeyon下,如news组的代码放在

apps-news

├──branches

|    ├──V6.1SP2\_Hotfix

|    └──V7.0\_Hotfix

├──tags

|    ├──V6.1SP2\_Release\_20180328

|    └──V7.0\_Release\_20180601

└──trunk

     └──src

         ├──main

         |    ├──java

         |    |    └──com

         |    |        └──seeyon

         |    |              └──news

         |    |                   └──NewsManager.java

         |    ├──resources

         |    └──webapp

         └──test

              ├──java

              |    └──com

              |        └──seeyon

              |              └──news

              |                   └──NewsManagerTest.java

              └──resources

## 2.3. 环境及编译

### 2.3.1. JDK规范

**JDK统一使用JDK8，因需要支持WAS，编译输出级别需为1.6（代码风格请使用JDK6风格，JDK7以上风格会导致编译不通过）。编译统一使用maven，maven中会有编译需要的一切配置，禁止使用本地配置编译代码。**

**禁止对jdk自带的sun包的调用**

## 2.4. 工程定义

### 2.4.1. 平台

A8平台由若干个A8平台工程组成，是所有A8基础功能的集合，是所有应用的基础平台工程以ctp为前缀，核心工程为ctp-core

### 2.4.2. 应用

### 2.4.3. apps(A8应用)

A8应用以apps为前缀，所有A8应用依赖于A8平台，但是A8应用间不能有任何的依赖关系，全部为平级

#### cip(集成应用)

集成应用以cip为前缀，主要为集成部门的相关应用，与所有A8应用同级，与A8应用间不能有任何的依赖关系

#### dee(交换引擎应用)

交换引擎应用以dee为前缀，主要为交换引擎部门的相关应用，与所有A8应用同级，与A8应用间不能有任何的依赖关系

# 3. POM文件

## 3.1. POM（项目对象模型）介绍

**Project Object Model** ，项目对象模型。通过xml格式保存的pom.xml文件。作用类似ant的build.xml文件，功能更强大。该文件用于管理：源代码、配置文件、开发者的信息和角色、问题追踪系统、组织信息、项目授权、项目的url、项目的依赖关系等等。

POM文件只能由平台部门维护

## 3.2. maven工程配置规范

- .maven配置文件统一使用工程根目录下的settings.xml，配置会使用统一的内部nexus服务器
- .不允许依赖本地jar包，所有jar包依赖都来自于pom文件中的定义
- .依赖更新、工程配置、工程构建仅允许通过maven来实现

## 3.3. 依赖定义

### 3.3.1. 平台

平台的核心工程为ctp-core，ctp-core依赖A8项目定义工程root。平台间的依赖关系请参考CI流程章节(TODO 更新链接)

### 3.3.2. 应用

应用的核心工程为apps-root，apps-root依赖整个平台，所有应用依赖apps-root，禁止应用间互相依赖，如apps-bbs的依赖为

    \<parent\>        \<groupId\>com.seeyon\</groupId\>        \<artifactId\>apps-root\</artifactId\>        \<version\>7.0SP1-SNAPSHOT\</version\>    \</parent\>
