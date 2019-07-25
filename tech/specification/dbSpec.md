# 1. 数据结构设计规范

## 1.1. 基本原则

符合命名规范，使用正确的数据类型，遵循第三范式，适度冗余，保证数据的一致性。

**1 第一范式（1NF）**

在任何一个[关系数据库](http://baike.baidu.com/item/%E5%85%B3%E7%B3%BB%E6%95%B0%E6%8D%AE%E5%BA%93)中，第一范式（1NF）[2]是对关系模式的基本要求，不满足第一范式（1NF）的数据库就不是关系数据库。

所谓第一范式（1NF）是指数据库[表](http://baike.baidu.com/item/%E8%A1%A8/9997188)的每一列都是不可分割的基本数据项，同一列中不能有多个值，即[实体](http://baike.baidu.com/item/%E5%AE%9E%E4%BD%93/13387585)中的某个[属性](http://baike.baidu.com/item/%E5%B1%9E%E6%80%A7)不能有多个值或者不能有重复的属性。如果出现重复的属性，就可能需要定义一个新的实体，新的实体由重复的属性构成，新实体与原实体之间为一对多关系。在第一范式（1NF）中表的每一行只包含一个实例的信息。

简而言之，第一范式就是无重复的列。

**2 第二范式（2NF）**

第二范式（2NF）[2]是在第一范式（1NF）的基础上建立起来的，即满足第二范式（2NF）必须先满足第一范式（1NF）。第二范式（2NF）要求数据库表中的每个[实例](http://baike.baidu.com/item/%E5%AE%9E%E4%BE%8B)或行必须可以被唯一地区分。为实现区分通常需要为表加上一个列，以存储各个实例的唯一标识。这个唯一属性列被称为[主关键字](http://baike.baidu.com/item/%E4%B8%BB%E5%85%B3%E9%94%AE%E5%AD%97)或主键、主码。

第二范式（2NF）要求实体的属性完全依赖于主关键字。所谓完全依赖是指不能存在仅依赖主关键字一部分的属性。如果存在，那么这个属性和主关键字的这一部分应该分离出来形成一个新的实体，新实体与原实体之间是一对多的关系。为实现区分通常需要为表加上一个列，以存储各个实例的唯一标识。

简而言之，第二范式就是非主属性非部分依赖于主关键字。

**3 第三范式（3NF）**

满足第三范式（3NF）[2]必须先满足第二范式（2NF）。简而言之，第三范式（3NF）要求一个数据库表中不包含已在其它表中已包含的非主关键字信息。

例如，存在一个部门信息表，其中每个部门有部门编号（dept\_id）、部门名称、部门简介等信息。那么在员工信息表中列出部门编号后就不能再将部门名称、部门简介等与部门有关的信息再加入员工信息表中。如果不存在部门信息表，则根据第三范式（3NF）也应该构建它，否则就会有大量的数据冗余。

简而言之，第三范式就是属性不依赖于其它非主属性。

## 1.2. 命名规范

数据库表的命名：数据库表名=模块（缩写）+表含义，例：表单模块的表前缀为form_，如：__协同为col_，form\_appresource表单资源表。

表中相同概念的字段，应该使用相同的名字、相同的类型、相同的值域，HBM映射文件与POJO类也尽量保持一致的命名。例："创建时间"在sql中字段名：create\_time类型为datetime，在HBM文件与POJO类中属性名为createTime，类型为java.util.Date。

所有的表名、字段名，全部使用小写字符。

数据库中表名与字段名使用下划线区分单词，以增加可读性。

在HBM文件与POJO中则去除下划线，并除首单词之外的每个单词的开头字母大写。

表主键：ID在数据库中bigint类型，在POJO中为long类型，通过UUID算法生成。

表外键：被引用表缩写\_id。

新建的表对于频繁查询的字段需要建立索引。

## 1.3. 常用数据类型

下表中是我们经常用到的一些字段的类型与值域，请大家在设计数据库之前先查询一下这张表看看类似的字段是如何定义类型与值域的。

| mysql | oracle | sqlserver | hbm文件 | POJO类型 |
| --- | --- | --- | --- | --- |
| BIGINT | NUMBER(19, 0) | bigint | long | java.lang.Long |
| INT | NUMBER(38, 0) | int | integer | java.lang.Integer |
| TINYINT | NUMBER(3, 0) | tinyint | integer | java.lang.Integer |
| VARCHAR | VARCHAR2 | nvarchar | string | java.lang.String |
| DATETIME | TIMESTAMP(6) | datetime | timestamp | java.util.Date |
| TEXT/LONGTEXT | CLOB | TEXT | clob | java.lang.String |
| Decimal(10,2) | Decimal(10,2)/ NUMBER(10,2) | decimal(10,2)/ numeric(10,2) | double | java.lang.Double |
| FLOAT | FLOAT | FLOAT | float | java.lang.Float |
| BLOB | BLOB | image | blob | java.sql.Blob |

## 1.4. 常用字段定义规范

| 字段名 | 中文名 | 类型（mysql） | 描述 |
| --- | --- | --- | --- |
| Id | 主键ID | bigint(20) |   |
| create\_member\_id | 发起人id | bigint(20) |   |
| subject | 标题 | varchar(255) | 长度统一定义为255，js前段校验为80 |
| content | 正文 | text/longtext | 慎用！必须用时请说明理由 |
| description | 描述 | varchar(2000) | js前段校验为500 |
| create\_date | 创建时间 | datetime |   |
| update\_date | 修改时间 | datetime |   |
| start\_date | 发起时间 | datetime |   |
| finish\_date | 完成时间 | datetime |   |

## 1.5. 禁止

- .禁止三表联查，容易导致性能问题。
- .数据不要使用XML，避免序列化和反序列化性能问题。如果必须存储复合数据，建议使用JSON。
- .不要使用BLOB，非结构化数据请使用文件存储。

# 2. 数据结构变更规范

## 2.1. 变更流程

① 开发人员：描述变更内容，提交流程 ② 开发经理：检查数据结构设计是否合理，是否有索引，索引设计是否合理 ③ DBA：审核数据库规范（半自动化） ④ 系统环境工程师：更新测试环境，知会其他人员（开发，测试）

迭代结束后，会多维度统计变更情况（按表，按类型等），分析原因，总结经验，哪些容易考虑遗漏，提前预埋，提升大家数据结构设计能力。

## 2.2. 变更版本

**主干变更**

- .发起《数据结构变更》

**分支月度修复包变更（含快速需求响应）**

原则上不允许数据结构变更，尽量减少

- .

月度修复包版本，放在系统启动执行（只执行一次）

- .

系统启动sql位置：/apps-common/src/main/webapp/WEB-INF/cfgHome/startup/sql/runonce

- .
- .

如果提交主干，初始化脚本发起《数据结构变更》处理

- .
- .

如果提交主干，升级脚本采用升级程序处理，避免打过月度修复包的客户执行升级脚本报错影响升级

- .

升级程序位置：/ctp\_upgrade/src/com/seeyon/ctp/upgrade

- .

## 2.3. 变更类型

**增加表/增加字段**

**修改字段长度**

**修改字段类型**

​ 原则上不允许修改，除非必须修改且数据库允许修改且已产生数据不影响的前提下，建议增加新字段兼容

**调整初始化数据**

​ 建议程序处理，比如每个单位下需要预制一套单位公告板块：

​ 集团版监听单位新建事件，兼听单位修改修改事件（如新建监听失败，可尝试补偿，方便修复，内部逻辑做好兼容，有数据则不初始化）。

    @ListenEvent(event = AddAccountEvent.class)    public void onAddAccount(AddAccountEvent evt) throws Exception {        bulTypeManager.initBulType(evt.getAccount().getId());    }

​ 企业版通过系统启动初始化

public class BulSystemInitializer extends AbstractSystemInitializer {

    private static Log log = LogFactory.getLog(BulSystemInitializer.class);

    private OrgManager orgManager;

    private BulTypeManager bulTypeManager;

    public void setOrgManager(OrgManager orgManager) {

        this.orgManager = orgManager;

    }

    public void setBulTypeManager(BulTypeManager bulTypeManager) {

        this.bulTypeManager = bulTypeManager;

    }

    @Override

    public void initialize() {

        log.info("企业版初始化单位公告板块......开始");

        try {

            V3xOrgAccount rootAccount = orgManager.getRootAccount();

            if (rootAccount != null && !rootAccount.isGroup()) {

                // 内部逻辑做好兼容，有数据则不初始化

                bulTypeManager.initBulType(rootAccount.getId());

            }

        } catch (Exception e) {

            log.error("", e);

        }

        log.info("企业版初始化单位公告板块......结束");

    }

    @Override

    public void destroy() {

    }

}

**调整索引**

​ 根据查询条件，优化索引，提升查询效率。
