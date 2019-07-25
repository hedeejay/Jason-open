## 安全编码规范

### 典型安全漏洞

| 漏洞 | 备注 |
| --- | --- |
| 脚本注入（SQL注入） | 攻击者利用 SQL注入漏洞，可以获取数据库中的多种信息（如管理员后台密码），从而脱取数据库中内容（脱库）。在特别情况下还可以修改数据库内容或者插入内容到数据库，如果数据库权限分配存在问题，或者数据库本身存在缺陷，那么攻击者可以通过SQL注入漏洞直接获取 bshell 或者服务器系统权限。 |
| XSS攻击 | 通过漏洞页面在浏览器上执行 js， 从而进行一系列的操作。常见的攻击方式主要是利用 XSS 盗取用户身份，进一步获取权限，甚至利用高级攻击技巧直接攻击企业内网 。 |
| 任意文件上传 | 文件上传攻击被利用于上传可 执行文件、脚本到服务器上，进而进一步导致服务器沦陷。 |
| 任意文件下载 | 任意文件读取漏洞能够读取服务器上任意的脚本代码、服务及系统的配置文件等敏感信息，造 成企业代码与数据的泄漏，威胁主机安全。 |
| 越权访问/敏感信息泄漏 | 获取其他用户的数据，修改其他用户的信息，乃至直接获取管理员权限从而可以对整个网站的 数据进行操作。 |
| 弱口令/暴力破解 | 获取员工权限，拿到网站管理或内部系统权限，对进一步渗透打下基础，甚至可能直接获取系统 权限。 |

### 安全规范

- .单点登录的ticket绝对不允许使用登录名，不允许使用永久有效的ticket，同一用户每次生成的ticket必须不一样
- .不要给黑客留可以不登录就根据字典暴力破解密码的口。
- .缺省不允许使用弱口令。
- .不允许按前端传递的人员Id进行响应，必须根据当前登录用户筛选数据。
- .最终用户上传的文件不允许进入上下文目录，不允许上传jsp文件（上传的html文件要对script进行trim）。
- .不要为了方便就开一个口可以下载任何一个文件。
- .关于敏感信息，存储一定要加密，传输尽可能保障安全，必须使用POST提交，敏感信息不允许出现在URL中，不要在日志中输出客户的信息。
- .必须登录才允许上传文件。
- .管理功能必须加角色控制注解，限定角色访问。

### 如何避免SQL注入

所有的SQL/HQL必须使用PreparedStatement，不允许拼静态SQL

比如下面这个

    public void updateHistoryDataMapNull(Long itemId) throws DatabaseException {        super.getHibernateTemplate().bulkUpdate("update HistoryWorkitemBLOBDAO w set w.itemDataMap2=null where w.id="+itemId);    }

需要修改为

 super.getHibernateTemplate().bulkUpdate("update HistoryWorkitemBLOBDAO w set w.itemDataMap2=null where w.id=?");

### 如何避免XSS

所有请求的parameter，必须处理后才能输出

比如下面就是典型的XSS

public ModelAndView xss(HttpServletRequest request, HttpServletResponse response){    ModelAndView view = new ModelAndView("xss.jsp");    view.addObject("param1", request.getParameter(param1));}

//xss.jsp\<script\>    var param1 = ${param1};\</script\>\<body\>    \<input value="${param1}"/\>    \<input value="\<%=request.getParameter('param1')%\>"/\>\</body\>

修改方式如下：html中的内容使用ctp:toHTML，javascript上下文使用ctp:escapeJavascript进行转义

//xss.jsp\<script\>    var param1 = ${ctp:escapeJavascript(param1)};\</script\>\<body\>    \<input value="${ctp:toHTML(param1)}"/\>\</body\>

## CSRF控制

我们的CSRF框架基于OWASP CSRFGuard，但为了性能做了简化，裁剪了大部分特性。

对于开发人员来说，重点保证以下两点即可：

1、所有的Ajax请求都带着CSRFTOKEN的header

2、所有的链接或IFRAME的src都带着&CSRFTOKEN=xxx后缀

平台已经对基础组件进行了处理，受控应用只需按下面的方式对开启CSRF控制开关后404的页面进行处理

我们的filter只监控_.do和_.jsp，所以无需处理js和css的引用

- .frame的src

增加**${ctp:csrfSuffix()}**

\<iframe  src="${path }/collaboration/collaboration.do?method=tabOffice${ctp:csrfSuffix()}" \>\</iframe\>

- .js指定的url

调用**CsrfGuard.getUrlSurffix()**

quoteDocumentFrame.location.href = url + CsrfGuard.getUrlSurffix(url);// 如果你很确定你的url含有?字符，可以不传url，使用+ CsrfGuard.getUrlSurffix()

- .Ajax请求

增加 **beforeSend: CsrfGuard.beforeAjaxSend** ，例如：

$.ajax({    type: "POST",    beforeSend: CsrfGuard.beforeAjaxSend,     url: encodeURI("/seeyon/organization/orgIndexController.do?method=saveRecentData4OrgIndex&rData=" + \_value)}); $('#attchmentForm').ajaxSubmit({    url : genericURL + "?method=updateAttachment&edocSummaryId="+summaryId+"&affairId="+affair\_id,    type : 'POST',    beforeSend: CsrfGuard.beforeAjaxSend,     success : function(data) {    }});

- .后台调用

// 返回"&CSRFTOKEN={currentTokenValue}"com.seeyon.ctp.common.taglibs.functions.Functions.csrfSuffix()

- .form增加hidden域

不常见

    var jsonForm = $('\<form method="post" action="'        + action        + '"\>'+'\<input type="hidden" name="CSRFTOKEN" value="'+ CsrfGuard.getToken()+'"/\>' +'\<input type="hidden" id="\_json\_params" name="\_json\_params" value=""/\>\</form\>', targetWindow.document);    \<input type="hidden" name="CSRFTOKEN" value="${sessionScope['CSRFTOKEN']}" /\>

### 越权控制：角色控制注解

控制Controller的方法只允许固定角色访问，避免普通用户越权。

下面的例子使得MemberController的所有方法都只允许系统管理员、动物管理员、HR管理员、集团管理员、部门管理员访问。

import com.seeyon.ctp.organization.OrgConstants.Role\_NAME;@CheckRoleAccess(roleTypes={Role\_NAME.SystemAdmin,Role\_NAME.AccountAdministrator,Role\_NAME.HrAdmin,Role\_NAME.GroupAdmin,Role\_NAME.DepAdmin})public class MemberController extends BaseController {    // ...}

也可以只限制指定的方法

public class SpaceController extends BaseController {    @CheckRoleAccess(roleTypes = { Role\_NAME.AccountAdministrator,Role\_NAME.GroupAdmin})    public ModelAndView spaceMain(HttpServletRequest request, HttpServletResponse response) throws BusinessException {    }}

支持的角色参见下面的代码

    /\*\*     \* 应用预置角色，\<b\>名称不允许有下划线\</b\>     \*/    public static enum Role\_NAME {        /\*\* 这个状态值不能使用，仅仅是因为升级上来占0这个位置的\*/        NULL,        /\*\* 集团文档空间管理员，为文档发送到集团空间使用\*/        GroupManager,        /\*\* 单位文档空间管理员，为文档发送到单位空间使用，并且可以在知识管理中进行博客管理 \*/        AccountAdmin,                /\*\* 部门管理员 \*/        DepAdmin,        /\*\* 部门主管 \*/        DepManager,        /\*\* 部门分管领导 \*/        DepLeader,        /\*\* 部門公文收發員 \*/        Departmentexchange,            /\*\* 外部人员\*/        ExternalStaff,        /\*\* 普通人员\*/        GeneralStaff,        /\*\* 协同模板管理员\*/        TtempletManager,        /\*\* 考勤管理员 \*/        AttendanceAdmin,        /\*\* HR管理员 \*/        HrAdmin,        /\*\* 工资管理员 \*/        SalaryAdmin,        /\*\* 表单管理员 \*/        FormAdmin,        /\*\* 车辆管理员 \*/        CarsAdmin,        /\*\* 图书管理员 \*/        BooksAdmin,        /\*\* 办公用品管理员 \*/        StocksAdmin,        /\*\* 会议室管理员\*/        MeetingRoomAdmin,        /\*\* 公文管理员\*/        EdocManagement,        /\*\* 單位公文收發員 \*/        Accountexchange,        /\*\* 发文拟文\*/        SendEdoc,        /\*\* 签报拟文\*/        SignEdoc,        /\*\* 收文登记\*/        RecEdoc,        /\*\* 绩效管理员\*/        PerformanceAdmin,        /\*\* 集团公告管理员\*/        GroupBulletinAdmin,        /\*\* 集团公告审核员\*/        GroupBulletinAuditor,        /\*\* 集团新闻管理员\*/        GroupNewsAdmin,        /\*\* 集团新闻审核员\*/        GroupNewsAuditor,        /\*\* 集团调查管理员\*/        GroupSurveyAdmin,        /\*\* 集团调查审核员\*/        GroupSurveyAuditor,        /\*\* 集团讨论管理员\*/        GroupDiscussAdmin,        /\*\* 单位公告管理员\*/        UnitBulletinAdmin,        /\*\* 单位公告审核员\*/        UnitBulletinAuditor,        /\*\* 单位新闻管理员\*/        UnitNewsAdmin,        /\*\* 单位新闻审核员\*/        UnitNewsAuditor,        /\*\* 单位调查管理员\*/        UnitSurveyAdmin,        /\*\* 单位调查审核员\*/        UnitSurveyAuditor,        /\*\* 单位讨论管理员\*/        UnitDiscussAdmin,        /\*\* 个人博客\*/        MemberBlog,        /\*\* 知识管理集团库管理员 \*/        DocGroupAdmin,        /\*\* 知识管理单位库管理员 \*/        DocUnitAdmin,        /\*\* 单位主管 \*/        AccountManager,          /\*\* 系统管理员 \*/        SystemAdmin,        /\*\* 审计管理员 \*/        AuditAdmin,        /\*\* 集团管理员 \*/        GroupAdmin,        /\*\* 单位后台管理员 \*/        AccountAdministrator,        /\*\* 超级管理员 \*/        SuperAdmin,        /\*\* 部门空间角色 \*/        DeptSpace,        /\*\* 归档公文修改 \*/        EdocModfiy,        /\*\* 信息上报人 \*/        InfoReporter,        /\*\* 期刊审核人 \*/        MagazineAudit,        /\*\* 信息报送管理员 \*/        InfoManager,        /\*\* G6 角色 收文登记 \*/        RegisterEdoc,        /\*\* G6 角色 收文分发 \*/        FenfaEdoc,        /\*\* 驾驶员 \*/        CarsDriver,        /\*\* 办公设备管理员 \*/        AssetsAdmin,        /\*\* 报表管理员 \*/        ReportAdmin,        /\*\* REST 管理员 \*/        RESTManager,        /\*\* 单位分管领导 \*/        AccountLeader,        /\*\* 大秀管理员\*/        ShowAdmin,        /\*\*A82\81 流程绩效用户授权\*/        WfanalysisAuth,        /\*\*A82\81 行为绩效用户授权\*/        BehavioranalysisAuth,        /\*\* 集团用车管理员\*/        GroupSpecialTrainAdmin,        /\*\* 单位用车管理员\*/        AccountSpecialTrainAdmin,        /\*\* 部门用车管理员\*/        DepartmentSpecialTrainAdmin,        /\*\*员工福利管理员\*/        EmployeeBenefitAdmin,        /\*\* vjoin人员（v-join平台人员的默认角色）\*/        VjoinStaff,        /\*\* 机构负责人(v-join平台预制的角色)\*/        VjoinUnitManager,        /\*\* 单位负责人(v-join平台预制的角色)\*/        VjoinAccountManager,    }

### 无需登录的请求

对于无需登录即可访问的url，比如登录，可以加@NeedlessCheckLogin注解

public class MainController{    @NeedlessCheckLogin    public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {    }}

### 文件越权控制：加V

我们的很多功能对链接做了权限控制，同一个URL，不同的登录用户也不能下载。

以doc插件为例

在插件的配置文件（pluginProperties.xml）中增加security.digesturl

\<?xml version="1.0" encoding="utf-8"?\>\<ctpConfig\>    \<doc\>        \<security\>            \<!-- 需要做URL digest的URL注册，空格分隔1为uri地址，2为method（没有可以省略），3为digest参数名 --\>            \<digesturl\>/doc.do rightNew resId,frType,docLibId,docLibType,isShareAndBorrowRoot,all,edit,add,readonly,browse,list,parentCommentEnabled,parentRecommendEnable,parentVersionEnabled,flag\</digesturl\>            \<digesturl\>/doc.do docPropertyIframe resId,docResId,frType,docLibId,docLibType,isShareAndBorrowRoot,all,edit,add,create,readonly,browse,read,list,parentCommentEnabled,parentRecommendEnable\</digesturl\>            \<digesturl\>/doc.do docProperty \_resId,docResId,frType,docLibId,docLibType,isShareAndBorrowRoot,\_all,\_edit,\_add,\_create,\_readonly,\_browse,\_read,\_list,propEditValue,\_parentCommentEnabled,isPerBorrow\</digesturl\>            \<digesturl\>/doc.do knowledgeBrowse docResId,entranceType,openFrom,docVersionId\</digesturl\>        \</security\>    \</doc\>\</ctpConfig\>

处理后的链接会多出一个v参数，只有当前登录用户才能够正常访问。
