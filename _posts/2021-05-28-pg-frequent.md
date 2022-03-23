---
title:  "PG/GP常用函数" 
author: pizzcato
date:   2021-05-28 10:40:42  +0800
categories: [database,greenplum]
tag: 技巧
---

## 查看pg/gp版本

```sql
select version();
```

![图 1](https://i.loli.net/2021/05/28/3y6zHjxUJePbpgm.png)  

## 查看postgis版本

```sql
select postgis_version() ;
--or
select postgis_full_version() ;
```

![图 3](https://i.loli.net/2021/05/28/B4kK6MRSLfIscZJ.png)  

## 查看锁表和相关操作

> info "基于gp测试"

{% include codeHeader.html %}  

```sql
--查询锁表
select t.relname,pid from pg_locks l join pg_class t on l.relation = t.oid where t.relkind = 'r'
--查询是否锁表了
select oid from pg_class where relname='lockTableName';
select pid from pg_locks where relation='上面查出的oid';
--如果查询到了结果，表示该表被锁 则需要释放锁定
select pg_cancel_backend('上面查到的pid');

```

## 查看分区

* 方式1  

    ```sql
    SELECT
        nmsp_parent.nspname AS parent_schema ,
        parent.relname AS parent ,
        nmsp_child.nspname AS child ,
        child.relname AS child_schema
    FROM
        pg_inherits JOIN pg_class parent
            ON pg_inherits.inhparent = parent.oid JOIN pg_class child
            ON pg_inherits.inhrelid = child.oid JOIN pg_namespace nmsp_parent
            ON nmsp_parent.oid = parent.relnamespace JOIN pg_namespace nmsp_child
            ON nmsp_child.oid = child.relnamespace
    WHERE
        parent.relname = 'cfg_road_mapping_g10_geo'; 
    ```

* 方式2

    > important " only for postgresql"
    > greenplum 5.11.2 不支持

```sql
select * from  
pg_partition_tree('tdlte_mro_pnn_grid10_cell_day')
```

## 根据sql查询建表语句  

> info  ""
> 不含distributed语句  

{% include codeHeader.html %}  

```sql
with ct as (
SELECT
      nmsp_parent.nspname AS parent_schema ,
      parent.relname AS parent ,
      nmsp_child.nspname AS child ,
      child.relname AS child_schema
  FROM
      pg_inherits JOIN pg_class parent
          ON pg_inherits.inhparent = parent.oid JOIN pg_class child
          ON pg_inherits.inhrelid = child.oid JOIN pg_namespace nmsp_parent
          ON nmsp_parent.oid = parent.relnamespace JOIN pg_namespace nmsp_child
          ON nmsp_child.oid = child.relnamespace
 ) ,
 get_pk as (
select distinct  
   tc.constraint_name, tc.table_name, kcu.column_name, 
   tc.is_deferrable,tc.initially_deferred,constraint_type
 FROM
   information_schema.table_constraints AS tc 
   JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
   JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
   where  constraint_type='PRIMARY KEY'
 )
SELECT     
'--drop table '||schamename||'.'|| relname || ';'||E'\n' ||
'CREATE TABLE ' ||schamename||'.'|| relname || E'\n(\n' ||
array_to_string(
  array_agg(
    '  "' || tabledefinition.column_name || '" ' ||  type || ' '|| not_null ||    ' ' || coalesce(constraint_type,' ')||' '||column_default order by attnum
  )
  , E',\n'
) || E'\n);\n'||case when  max(constraint_type) is null then  coalesce(indexdef||';','') else '' end  ||E'\n'
from
(


SELECT 
  c.relname,c.schamename, a.attname AS column_name,pi.indexdef, a.attnum,
  pg_catalog.format_type(a.atttypid, a.atttypmod) as type,
  case 
    when a.attnotnull
  then 'NOT NULL' 
  else '' 
  END as not_null,
  case when  pg_get_expr(pa.adbin,pa.adrelid	)  is not null then 'default '||pg_get_expr(pa.adbin,pa.adrelid	) else '' end as column_default
FROM
 (select pc.oid as oid2,pc.*,pn.nspname as schamename from pg_class pc, pg_namespace pn where pc.relnamespace=pn.oid  
  and  pc.relname not in (select distinct child_schema from ct ) and  pc.relname !~~ 'rulr%' ) c left join pg_indexes pi on c.relname=pi.tablename
,
  pg_attribute a left join pg_attrdef pa on a.attrelid =pa.adrelid and a.attnum	  =pa.adnum,
  pg_type t  
    
  where  a.attnum > 0
  AND a.attrelid = c.oid2
  AND a.atttypid = t.oid
  and c.relkind='r'
ORDER BY a.attnum
) as tabledefinition left join get_pk pk on  pk.table_name=tabledefinition.relname and  pk.column_name=tabledefinition.column_name
group by schamename,relname,indexdef
```  

![image.png](https://i.loli.net/2021/05/28/n9aWzL1kF4Y2XJE.png)  


## pg kill 进程

```sql
SELECT pg_terminate_backend(*pid*);
```

```sql
select 'SELECT pg_terminate_backend('|| pid||');' from  pg_stat_activity where  query='SELECT 1'
```  
