---
title: 制作概览/大屏等页面使用的geojson地图文件
author: pizzcato
date: 2021-05-25 10:57:41 +0800
categories: [GIS,geojson]
tag: [GIS]
math: true
---


## 利用qgis

{% include tips.html content="geojson本身数据的空间对象类型都支持，但是目前概览也能够加载的只有点(point） 和 多边形(polygon/multipolygon)" %}
{% include important.html content="不论那种方式都建议先[简化一下对象](#利用qgis简化图层)再导出" %}  

### 方式一:qgis直连数据库导入

在qgis中设置连接数据库,导入地图空间数据,**根据需求**[添加过滤条件](#qgis图层添加过滤条件),然后选择图层,[导出为geojson文件](#qgis导出geojson文件)

### 方式二:导出边框的wkt数据在qgis中添加图层后导出  

>简化可以在添加到qgis之前在[数据库中处理](#函数说明),也可以导入到qgis以后[再处理](#利用qgis简化图层)  

1. 数据库中通过`st_astext`(pg/gp)或`t.geom.get_wkt()`(Oracle)等函数/方法获取边框的wkt坐标集
2. Qgis中通过[**QuickWKT**插件](#quickwkt插件的安装和使用)来快速生成边框(**注意将需要生成在一个文件中的边框添加到同一个图层文件**)

### 用到的操作  

#### qgis图层添加过滤条件

1. 右键图层选择`Filter...`  

    ![图 2](https://i.loli.net/2021/05/25/k1Oo8dDHmg4sSeX.png)  

1. 在输入框中输入过滤条件  

    ![图 3](https://i.loli.net/2021/05/25/dlbSTNaDFA8cQWI.png)  
    * 输入的内容为过滤条件,即 `where` 子句的内容,可以通过双击`Fields`中的字段名来快速添加入输入框
    * `Values`可以用来显示`Fields`的某个示例值(`Sample`)或全部值(`All`)

1. 点击`Test`可以获取结果的记录数,点击`OK`来使过滤条件生效

#### qgis导出geojson文件

1. 右键图层选择`Export`->`Save Features as...`  

    ![图 2](https://i.loli.net/2021/05/25/k1Oo8dDHmg4sSeX.png)  

1. 设置导出信息  

    ![图 4](https://i.loli.net/2021/05/25/AjX1RoKStWnez3k.png)  

1. 设计完成后点击`OK`执行  

#### QuickWKT插件的安装和使用

QuickWKT是一个qgis的第三方插件,用以通过wkt坐标集文本快速创建qgis图层

1. 安装  

    1. qgis菜单栏->Plugins->Manage and install plugins
    1. 搜索**QuickWKT**选择安装

1. 使用  

    1. 点击WKT按钮  

        ![wkt](https://i.loli.net/2021/05/25/wagtm6JE5nDfUPc.png)  

    1. 输入wkt坐标集,输入图层标题,点击ok创建图层  

    {% include important.html content="Layer title不同或勾选了`Create a new layer for every geometry`选项,则导入时会以新的图层而不是添加的现有图层的方式导入" %}  

#### 利用qgis简化图层

菜单栏->Vector->Geometry Tools->Simplify...

![图 5](https://i.loli.net/2021/05/25/8KTpaosRSOWUh7V.png)  


## 利用sql查询拼接成所需文本

>此方法只测试了postgresql/greenplum

geojson的格式是比较固定的,所以可以通过拼接字符串的方式来直接拼接成一个geojson文件的内容  

例:  

{% include codeHeader.html %}
```sql
select
area
, '{
"type": "FeatureCollection",
"name": "' || area || '",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [' || string_agg('{ "type": "Feature", "properties": { "name": "' || region || '" }, "geometry":' ||
 st_asgeojson( st_simplify(geom, 9e-4)), E'},\n' )|| E'}\n' || E']\n}\n'
from
cfg_city_info cci
where
city = 'TIANJIN'
group by
area
```  

### 逻辑说明

1. 简化数据库的空间对象
1. 将空间对象转换为geojson元素
1. 将多个geojson元素拼接在一起,并补充额外需要的信息来,**生成页面所需geojson文件的文本**

### 函数说明

* [st_simplify](http://postgis.net/docs/manual-3.0/ST_Simplify.html):利用[道格拉斯抽稀法](https://zh.wikipedia.org/wiki/%E9%81%93%E6%A0%BC%E6%8B%89%E6%96%AF-%E6%99%AE%E5%85%8B%E7%AE%97%E6%B3%95)简化边框:
  对于数据库的区域边框,往往需要满足定位的精度要求从而需要比较高的精度,导致边框的坐标集太大。而页面上由于加载的时延要求和比较粗略的展示需求,不需要特别高的精度。这时候就可以通过算法简化坐标。
  `9e-4`就是简化的容差值,**单位同经纬度**,可以根据需求来设置,**值越大代表处理后的结果越简化**
{% include important.html content="必须简化坐标,否则过大的geojson文件会导致页面加载缓慢和页面处理压力" %}  

* [st_asgeojson](http://postgis.net/docs/manual-3.0/ST_AsGeoJSON.html):生成空间对象的geojson元素
  >生成的结果还需要补充才是完整的geojson文件

* string_agg:字符串聚合
  将多行字符串聚合

### 拼接高铁高速使用的高铁线路/高速线路图

> important "注意"
> 其中相当于省份外框的name必须要和`zc_hst_summary_conf.js`中的`defaultMapName`配置项相同,才能将省份边框设置为背景图,无法选中

{% include codeHeader.html %}

```sql
with t as (
select 1 as type, name_cn as name, geom as geom from  cfg_province_info 
where  province_name ='SHANXI'
union all 
select 2 ,road_name as name,st_buffer(geom,0.009)as geom from cfg_map_rail_shanxi
)
select 
'{
"type": "FeatureCollection",
"name": "' || 'SHANXI_GAOTIE' || '",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [' || string_agg('{ "type": "Feature", "properties": '||case when type=2 then  '{ "name": "' || NAME ||'" }' else  '{ "name": "' || NAME || '","Kind":"2" }' end ||', "geometry":' ||
 st_asgeojson( st_simplify(geom, 9e-3)), E'},\n' order by type )|| E'}\n' || E']\n}\n'
from T
```

## 进一步简化geojson文件

* 页面所需的geojson文件是不需要任何换行和缩进的,如果geojson文件存在较多的缩进和换行,可以通过join line[^1]的方式来取消
* 经纬度的坐标没必要太精细,可以同通过正则来截断坐标,减少文件的大小

  |查询|替换|
  |-|-|
  |(\d+\.\d{6})\d+|$1|  

  其中{6}代表截断到6位小数,足以满足页面的需要  
  *不同编辑器的正则解析有些区别*

[^1]: vscode可以F1在所有命令中搜索join lines;<br>也可以在网上搜索相关的在线工具,如[Merge Text Lines](https://www.browserling.com/tools/join-lines)

{% include imgaddclass.html %}