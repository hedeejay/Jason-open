# 1 技术准备

## 1.1 技能要求

开发人员必须掌握以下技术技能：

**基础技能**

- .Java语言编程
- .JavaEE原理
- .Spring的原理和方法
- .Java 23种基本设计模式
- .MVC结构
- .XML
- .JSON
- .JavaSrcipt基本用法
- .CSS的使用

**应用界面开发**

- .JSP开发技能
- .JavaScript开发技能
- .CSS，JSTL开发技能
- .HTML结构
- .Servlet原理和结构
- .Portlet原理和结构
- .Ajax

**应用开发**

- .部分J2EE标准:JAAS、JMS
- .WebService、RMI

**数据层开发**

- .JDBC原理和编程方法
- .Hiberante原理与编程方法
- .数据库的配置和使用：MySQL，Oracle、SQL Server

以上是对相应开发人员技能的基本要求，需要参考专门的资料和书籍进行学习，本文对这些知识不做介绍。如果要成为一名优秀的开发人员或架构师，不仅要全面并深入地掌握以上的内容，还有其他JavaEE相关的知识需要了解。

## 1.2 微服务平台相关技术

| 技术 | 备注 |
| --- | --- |
| Spring boot | Spring是一个开源框架，Spring是于2003 年兴起的一个轻量级的Java 开发框架，由Rod Johnson创建。简单来说，Spring是一个分层的JavaSE/EEfull-stack(一站式) 轻量级开源框架。 |
| SpringCloud | Hibernate是一个开放源代码的对象关系映射框架，它对JDBC进行了非常轻量级的对象封装，它将POJO与数据库表建立映射关系，是一个全自动的orm框架，hibernate可以自动生成SQL语句，自动执行，使得Java程序员可以随心所欲的使用对象编程思维来操纵数据库。 Hibernate可以应用在任何使用JDBC的场合，既可以在Java的客户端程序使用，也可以在Servlet/JSP的Web应用中使用，最具革命意义的是，Hibernate可以在应用EJB的J2EE架构中取代CMP，完成数据持久化的重任。 |
| Docker | 全名是Model View Controller，是模型(model)－视图(view)－控制器(controller)的缩写，一种软件设计典范，用一种业务逻辑、数据、界面显示分离的方法组织代码，将业务逻辑聚集到一个部件里面，在改进和个性化定制界面及用户交互的同时，不需要重新编写业务逻辑。MVC被独特的发展起来用于映射传统的输入、处理和输出功能在一个逻辑的图形化用户界面的结构中。 |
| linux | [Groovy](http://open.seeyon.com/book/GLOSSARY.html#groovy)是一种基于JVM（Java虚拟机）的敏捷开发语言，它结合了Python、Ruby和Smalltalk的许多强大的特性，[Groovy](http://open.seeyon.com/book/GLOSSARY.html#groovy) 代码能够与 Java 代码很好地结合，也能用于扩展现有代码。由于其运行在 JVM 上的特性，[Groovy](http://open.seeyon.com/book/GLOSSARY.html#groovy) 可以使用其他 Java 语言编写的库。 |
| Activity | 业务流程管理(BPM)和工作流系统，其核心是BPMN2流程引擎。 |
| Web Service | Web service是一个平台独立的，低耦合的，自包含的、基于可编程的web的应用程序，可使用开放的XML（标准通用标记语言下的一个子集）标准来描述、发布、发现、协调和配置这些应用程序，用于开发分布式的互操作的应用程序。它使得运行在不同机器上的不同应用无须借助附加的、专门的第三方软件或硬件， 就可相互交换数据或集成。依据Web Service规范实施的应用之间， 无论它们所使用的语言、 平台或内部协议是什么， 都可以相互交换数据。Web Service是自描述、 自包含的可用网络模块， 可以执行具体的业务功能。 |
| JAX-WS/SOAP | JAX-WS(Java API for XML Web Services)规范是一组XML web services的JAVA API，JAX-WS允许开发者可以选择RPC-oriented或者message-oriented 来实现自己的web services。 |
| JAX-RS/REST | JAX-RS是JAVA EE6 引入的一个新技术。 JAX-RS即Java API for RESTful Web Services，是一个Java 编程语言的应用程序接口，支持按照表述性状态转移（REST）架构风格创建Web服务。JAX-RS使用了Java SE5引入的Java标注来简化Web服务的客户端和服务端的开发和部署。 |
| Quartz  | 分布式任务调度框架，为在Java应用程序中进行作业调度提供了简单却强大的机制。 |
| Swagger | REST API管理框架，实现在线查看方法说明、参数和返回值格式，并支持在线测试。 |
| Zipkin | 微服务架构是一个分布式架构，一个分布式系统往往有很多微服务组成。由于微服务数量众多和业务的复杂性，如果出现了错误和异常，很难去定位。主要体现在，一个请求可能需要调用很多个服务，而内部服务的调用复杂性，决定了问题难以定位。所以微服务架构中，必须实现分布式调用链路追踪，去跟进一个请求到底有哪些服务参与，参与的顺序又是怎样的，从而达到每个请求的步骤清晰可见，出了问题，很快定位。 |
| XML | 可扩展标记语言，标准通用标记语言的子集，是一种用于标记电子文件使其具有结构性的标记语言。在电子计算机中，标记指计算机所能理解的信息符号，通过此种标记，计算机之间可以处理包含各种的信息比如文章等。它可以用来标记数据、定义数据类型，是一种允许用户对自己的标记语言进行定义的源语言。 它非常适合万维网传输，提供统一的方法来描述和交换独立于应用程序或供应商的结构化数据。是Internet环境中跨平台的、依赖于内容的技术，也是当今处理分布式结构信息的有效工具。早在1998年，W3C就发布了XML1.0规范，使用它来简化Internet的文档信息传输。 |
| JSON | JSON(JavaScript Object Notation, JS 对象标记) 是一种轻量级的数据交换格式。它基于 ECMAScript (w3c制定的js规范)的一个子集，采用完全独立于编程语言的文本格式来存储和表示数据。简洁和清晰的层次结构使得 JSON 成为理想的数据交换语言。 易于人阅读和编写，同时也易于机器解析和生成，并有效地提升网络传输效率。 |
| JSP | JSP全名为Java Server Pages，中文名叫java服务器页面，其根本是一个简化的Servlet设计，它[1] 是由Sun Microsystems公司倡导、许多公司参与一起建立的一种动态网页技术标准。JSP技术有点类似ASP技术，它是在传统的网页HTML（标准通用标记语言的子集）文件(_.htm,_.html)中插入Java程序段(Scriptlet)和JSP标记(tag)，从而形成JSP文件，后缀名为(\*.jsp)。 用JSP开发的Web应用是跨平台的，既能在Linux下运行，也能在其他操作系统上运行。 |
