---
title:  "PostGis常用函数" 
author: pizzcato
date:   2021-09-04 13:09:17  +0800
categories: [postgis]
tag: 技巧
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

{% include imgaddclass.html %}