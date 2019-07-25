#常见问题

## 发起流程或保存流程模板时，出现异常：Expected one result
SEVERE: Error while closing command context
org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2

异常原因：流程引擎BUG,由于操作不当引起。
解决方法：修改数据库表ACT_RE_PROCDEF，确保同一个KEY_的VERSION_字段不能重复。查询重复的SQL语句如下：
select t.*, t.rowid from ACT_RE_PROCDEF t where t.key_='xczyOrder' and t.version_ in(
select t.version_ from ACT_RE_PROCDEF t  where t.key_='xczyOrder' group by t.version_ having count(t.version_) >1 ) 
order by t.version_

手动修改重复的VERSION_后，问题即可解决。

---