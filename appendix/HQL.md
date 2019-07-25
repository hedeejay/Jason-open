# 1. HQL: Hibernate 查询语言

Hibernate 配备了一种非常强大的查询语言，这种语言看上去很像SQL。但是不要被语法结构上的相似所迷惑，HQL 是非常有意识的被设计为完全面向对象的查询，它可以理解如继承、多态和关联之类的概念。

## 1.1. 大小写敏感性问题

除了Java 类与属性的名称外，查询语句对大小写并不敏感。所以SeLeCT 与sELEct 以及SELECT 是相同的，但是org.hibernate.eg.FOO 并不等价于org.hibernate.eg.Foo 并且foo.barSet 也不等价于foo.BARSET。

本手册中的HQL 关键字将使用小写字母。很多用户发现使用完全大写的关键字会使查询语句的可读性更强，但我们发现，当把查询语句嵌入到Java 语句中的时候使用大写关键字比较难看。

## 1.2. from 子句

Hibernate 中最简单的查询语句的形式如下：

from eg.Cat

该子句简单的返回eg.Cat 类的所有实例。通常我们不需要使用类的全限定名，因为auto-import（自动引入）是缺省的情况。所以我们几乎只使用如下的简单写法：

from Cat

为了在这个查询的其他部分里引用Cat，你将需要分配一个_别名_。例如：

from Cat as cat

这个语句把别名cat 指定给类Cat 的实例，这样我们就可以在随后的查询中使用此别名了。关键字as 是可选的，我们也可以这样写：

from Cat cat

子句中可以同时出现多个类，其查询结果是产生一个笛卡儿积或产生跨表的连接。

from Formula, Parameter

from Formula as form, Parameter as param

查询语句中别名的开头部分小写被认为是实践中的好习惯，这样做与Java 变量的命名标准保持了一致（比如，domesticCat）。

## 1.3. 关联（Association）与连接（Join）

我们也可以为相关联的实体甚至是对一个集合中的全部元素指定一个别名，这时要使用关键字join。

from Cat as cat    inner join cat.mate as mate    left outer join cat.kittens as kitten

from Cat as cat leftjoin cat.mate.kittens as kittens

from Formula form fulljoin form.parameter param

受支持的连接类型是从ANSI SQL 中借鉴来的：

- .inner join
- .left outer join
- .right outer join
- .full join（全连接，并不常用）

语句inner join，left outer join 以及right outer join 可以简写。

from Cat as cat    join cat.mate as mate    left join cat.kittens as kitten

通过HQL 的with 关键字，你可以提供额外的join 条件。

from Cat as cat    left join cat.kittens as kitten        with kitten.bodyWeight\> 10.0

A "fetch" join allows associations or collections of values to be initialized along with their parent objects using a single select. This is particularly useful in the case of a collection. It effectively overrides the outer join and lazy declarations of the mapping file for associations and collections. See [第](https://docs.jboss.org/hibernate/orm/3.5/reference/zh-CN/html/performance.html#performance-fetching)[20.1 节](https://docs.jboss.org/hibernate/orm/3.5/reference/zh-CN/html/performance.html#performance-fetching)["](https://docs.jboss.org/hibernate/orm/3.5/reference/zh-CN/html/performance.html#performance-fetching)[抓取策略（Fetching strategies）](https://docs.jboss.org/hibernate/orm/3.5/reference/zh-CN/html/performance.html#performance-fetching)["](https://docs.jboss.org/hibernate/orm/3.5/reference/zh-CN/html/performance.html#performance-fetching)for more information.

from Cat as cat    inner join fetch cat.mate    left join fetch cat.kittens

一个fetch 连接通常不需要被指定别名，因为相关联的对象不应当被用在where 子句（或其它任何子句）中。同时，相关联的对象并不在查询的结果中直接返回，但可以通过他们的父对象来访问到他们。

from Cat as cat    inner join fetch cat.mate    left join fetch cat.kittens child    left join fetch child.kittens

假若使用iterate() 来调用查询，请注意fetch 构造是不能使用的（scroll() 可以使用）。fetch 也不应该与setMaxResults() 或setFirstResult() 共用，这是因为这些操作是基于结果集的，而在预先抓取集合类时可能包含重复的数据，也就是说无法预先知道精确的行数。fetch 还不能与独立的with 条件一起使用。通过在一次查询中fetch 多个集合，可以制造出笛卡尔积，因此请多加注意。对bag 映射来说，同时join fetch 多个集合角色可能在某些情况下给出并非预期的结果，也请小心。最后注意，使用full join fetch 与right join fetch 是没有意义的。

如果你使用属性级别的延迟获取（lazy fetching）（这是通过重新编写字节码实现的），可以使用fetch all properties 来强制Hibernate 立即取得那些原本需要延迟加载的属性（在第一个查询中）。

from Document fetchall properties orderby name

from Document doc fetchall properties where lower(doc.name)like'%cats%'

## 1.4. join 语法的形式

HQL 支持两种关联join 的形式：implicit（隐式）与explicit（显式）。

上一节中给出的查询都是使用explicit（显式）形式的，其中form 子句中明确给出了join 关键字。这是建议使用的方式。

implicit（隐式）形式不使用join 关键字。关联使用"点号"来进行"引用"。implicit join 可以在任何HQL 子句中出现。implicit join 在最终的SQL 语句中以inner join 的方式出现。

from Cat as cat where cat.mate.name like'%s%'

## 1.5. 引用 identifier 属性

通常有两种方法来引用实体的identifier 属性：

- .特殊属性（lowercase）id 可以用来引用实体的identifier 属性_假设这个实体没有定义用 __non-identifier 属性命名的__ id_。
- .如果这个实体定义了identifier 属性，你可以使用属性名。

对组合identifier 属性的引用遵循相同的命名规则。如果实体有一个non-identifier 属性命名的id，这个组合identifier 属性只能用自己定义的名字来引用；否则，特殊id 属性可以用来引用identifier 属性。

**重要**

注意：从3.2.2 版本开始，这已经改变了很多。在前面的版本里，不管实际的名字，id_总是_指向identifier 属性；而用non-identifier 属性命名的id 就从来不在Hibernate 查询里引用。

## 1.6. select 子句

select 子句选择将哪些对象与属性返回到查询结果集中。考虑如下情况：

select matefrom Cat as cat    inner join cat.mate as mate

该语句将选择其它Cat 的mate（其他猫的配偶）。实际上，你可以更简洁的用以下的查询语句表达相同的含义：

select cat.mate from Cat cat

查询语句可以返回值为任何类型的属性，包括返回类型为某种组件（Component）的属性：

select cat.name from DomesticCat catwhere cat.name like 'fri%'

select cust.name.firstName from Customer as cust

查询语句可以返回多个对象和（或）属性，存放在Object[\] 队列中，

select mother, offspr, mate.namefrom DomesticCat as mother    inner join mother.mate as mate    left outer join mother.kittens as offspr

或存放在一个List 对象中：

select new list(mother, offspr, mate.name)from DomesticCat as mother    inner join mother.mate as mate    left outer join mother.kittens as offspr

假设类Family 有一个合适的构造函数- 作为实际的类型安全的Java 对象：

select new Family(mother, mate, offspr)from DomesticCat as mother    join mother.mate as mate    left join mother.kittens as offspr

你可以使用关键字as 给"被选择了的表达式"指派别名：

select max(bodyWeight) as max, min(bodyWeight) as min, count(\*) as nfrom Cat cat

这种做法在与子句select new map 一起使用时最有用：

select new map( max(bodyWeight) as max, min(bodyWeight) as min, count(\*) as n )from Cat cat

该查询返回了一个Map 的对象，内容是别名与被选择的值组成的名-值映射。

## 1.7. 聚集函数

HQL 查询甚至可以返回作用于属性之上的聚集函数的计算结果：

select avg(cat.weight), sum(cat.weight), max(cat.weight), count(cat)from Cat cat

受支持的聚集函数如下：

- .avg(...), sum(...), min(...), max(...)
- .count(\*)
- .count(...), count(distinct ...), count(all...)

你可以在选择子句中使用数学操作符、连接以及经过验证的SQL 函数：

select cat.weight + sum(kitten.weight)from Cat cat    join cat.kittens kittengroup by cat.id, cat.weight

select firstName||' '||initial||' '||upper(lastName)from Person

关键字distinct 与all 也可以使用，它们具有与SQL 相同的语义。

select distinct cat.name from Cat catselect count(distinct cat.name), count(cat) from Cat cat


