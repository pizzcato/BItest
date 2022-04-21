---
title: GEOSERVER主动请求被动缓存的方法
author: pizzcato
date: 2022-04-21 13:06:14  +0800
categories: [GIS]
tag: GIS
math: true
---

>使用于openlayers读取geoserver图片瓦片图层

## 前提

geoserver的图层已经配置好了被动缓存

## 思路

* geoserver底层是以900913(web墨卡托坐标系,即x,y,z格式)存储缓存文件  
* openlayers在页面上的请求链接是使用了3857坐标系的bbox,格式是minx,miny,maxx,maxy  
* 在判断时,geoserver会将请求的链接转换成web墨卡托的xyz,转换时会转成整型,所以页面请求链接只要bbox的坐标偏差不大,是可以读取到缓存的
* 根据熟知的4326经纬度可以转换成3857,再通过3857转换成900913
* 根据900913的xyz可以逆向转换回3857坐标

```mermaid
graph LR
    A(开始)-->B[4326经纬度范围]-->C[3857墨卡托]-->D[900913XYZ范围]-->E[xyz切片]-->F[切片对应3857范围]-->G(发送页面请求)
```

## Python伪代码

### 通用参数

{% include codeHeader.html %}  

```py
# 像素坐标不同等级下的转换系数
res = {
    0: 156543.033928023,
    1: 78271.5169640117,
    2: 39135.7584820059,
    3: 19567.8792410029,
    4: 9783.93962050147,
    5: 4891.96981025073,
    6: 2445.98490512537,
    7: 1222.99245256268,
    8: 611.496226281342,
    9: 305.748113140671,
    10: 152.874056570335,
    11: 76.4370282851677,
    12: 38.2185141425838,
    13: 19.1092570712919,
    14: 9.55462853564596,
    15: 4.77731426782298,
    16: 2.38865713391149,
    17: 1.19432856695575,
    18: 0.597164283477873,
    19: 0.2985821417389375,
    20: 0.14929107086946875
}
# 切片像素
tileSize = 256
# 原点坐标
originX = -20037508.342789244
originY = 20037508.342789244
```

### 4326 to 3857

{% include codeHeader.html %}  

```py
def millerToXY(lon, lat):
    x = 6378137 * math.pi * lon / 180
    y = 6378137 * math.log(math.tan(math.pi / 360 * (lat + 90)))
    return (x, y)

```

### 3857 to 900913

{% include codeHeader.html %}  

```py
def calXY(x, y, level):
    reso = res[level]
    sx = (x - originX) / (reso * tileSize)
    sy = (y - originY) / (reso * tileSize)
    return (sx, sy)
```

### 900913 to 3857

{% include codeHeader.html %}  

```py
def calXY_back(sx, sy, level):
    reso = res[level]
    x=math.fabs(sx*reso*tileSize+originX)
    y=math.fabs(sy*reso*tileSize+originY)
    return (x, y)
```

### 请求

URL模板:  
`http://{ip}:{port}/geoserver/{workspace}/wms?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&FORMAT=image/png&TRANSPARENT=true&LAYERS={workspace}:{LAYERNAME}&TILED=true&STYLES={style}&VIEWPARAMS={viewparams}&WIDTH=256&HEIGHT=256&CRS=EPSG:3857&BBOX={minx},{miny},{maxx},{maxy}

参数说明:

* ip  
  geoserver的ip  
* port  
  geoserver的端口  
* workspace  
  图层所在的工作空间  
* LAYERNAME  
  图层名  
* style  
  渲染图层使用的样式  
* viewparams  
  渲染时使用的图层传参  
* minx,miny,maxx,maxy  
  切片的3857边界坐标点  
