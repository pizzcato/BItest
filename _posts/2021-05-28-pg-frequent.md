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
SELECT                                          
'CREATE TABLE ' || relname || E'\n(\n' ||
array_to_string(
  array_agg(
    '    ' || column_name || ' ' ||  type || ' '|| not_null
  )
  , E',\n'
) || E'\n);\n'
from
(
SELECT 
  c.relname, a.attname AS column_name,
  pg_catalog.format_type(a.atttypid, a.atttypmod) as type,
  case 
    when a.attnotnull
  then 'NOT NULL' 
  else 'NULL' 
  END as not_null 
FROM pg_class c,
  pg_attribute a,
  pg_type t
  WHERE c.relname = 'cfg_scene_grid50'
  AND a.attnum > 0
  AND a.attrelid = c.oid
  AND a.atttypid = t.oid
ORDER BY a.attnum
) as tabledefinition
group by relname
```  

![image.png](https://i.loli.net/2021/05/28/n9aWzL1kF4Y2XJE.png)  
