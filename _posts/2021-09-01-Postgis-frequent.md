---
title:  "PostGis常用函数" 
author: pizzcato
date:   2021-09-04 13:09:17  +0800
categories: [postgis]
tag: 技巧
math: true
mermaid: true
---


## 查看postgis版本

```sql
select postgis_version() ;
--or
select postgis_full_version() ;
```

![图 3](https://i.loli.net/2021/05/28/B4kK6MRSLfIscZJ.png)  

## 對象操作

|功能|函數|說明|示例|
|-|-|-|-|
|圖形縮放|[ST_TransScale(geometry geomA, float deltaX, float deltaY, float XFactor, float YFactor)](http://postgis.net/docs/manual-3.0/ST_TransScale.html)|將圖形縮放(XFactor,YFactor)倍,基於(deltaX,deltaY)|{% ihighlight sql %} select spolygon,ST_TransScale(spolygon,longitude,latitude,0.5,0.5)as geom from tablexxx {% endihighlight %}<br />![image.png](https://i.loli.net/2021/09/04/SK1NWFhcOuULIQH.png)|
|外環線|[ST_ExteriorRing(geometry a_polygon)](http://postgis.net/docs/manual-3.0/ST_ExteriorRing.html)|基于多边形(a polygon)获取外边边界的线|{% ihighlight sql %} select ST_ExteriorRing(geom) from cfg_city_info where city='xxx' {% endihighlight %}<br />![图 3](https://s2.loli.net/2022/03/23/LOTUlgSrPENnJsf.png)  


{% include imgaddclass.html %}


## 消除多边形内部孔洞(支持multipolygon)

![图 2](https://s2.loli.net/2022/03/23/EtMZKvUH2wcjm6D.png)  

解决思路

```mermaid
graph LR
A(开始)-->x((文字))-->B[dump成单个多边形集合]-->c[获取单个多边形对应的外环线]-->d[基于外环线重新生成多边形]-->e[多边形重新合并]-->f(结束)
A(开始)-->Y((代码))-->G[st_dump]-->H[ST_ExteriorRing]-->I[ST_makepolygon]-->J[st_union]-->f(结束)
```
