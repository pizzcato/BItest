---
title: geoserver style配置
author: pizzcato
date: 2021-05-27 11:54:45  +0800
categories: [GIS,geoserver]
---

## style显示文字

![geoserver文字](https://i.loli.net/2021/05/27/sjLFauIvcZoVThB.png)

## style设置分级显示不同内容

主要由`/StyledLayerDescriptor/NamedLayer/UserStyle/se:FeatureTypeStyle/se:Rule[n]/se:MinScaleDenominator`和`/StyledLayerDescriptor/NamedLayer/UserStyle/se:FeatureTypeStyle/se:Rule[n]/se:MaxScaleDenominator`决定。  
**其中`se:MinScaleDenominator`元素控制显示的比例尺下限，`se:MaxScaleDenominato`控制显示的比例尺上限**  
![比例尺](https://i.loli.net/2021/05/27/liaw37eDIpCxJ8P.png)  
表示地图的比例尺在1:0(缩放最小)~1:100000(1厘米：1公里) 时显示，超出此范围则不显示。  

## 适配文字位置  

当地图标签比较密集时，会出现部分问题可能会被其他元素遮挡而不显示，这时候可以添加元素`/StyledLayerDescriptor/NamedLayer/UserStyle/se:FeatureTypeStyle/se:Rule[n]/se:TextSymbolizer/se:VendorOption`  
例如：
  
```xml
<se:VendorOption name="maxDisplacement">10</se:VendorOption>
```  

maxDisplacement表示在该范围内文字会自动寻找合适的位置显示  

## 例子

### 分级渲染

{% include codeHeader.html %}

```xml
{% include_relative /file/level.sld %}
```

### 点类型+文字  

{% include codeHeader.html %}

```xml
{% include_relative /file/PLAT_BACKGROUND.sld %}
```  

### 线类型+文字

{% include codeHeader.html %}

```xml
{% include_relative /file/LINE_BACKGROUND.sld %}
```  

### 多边形类型模板  

{% include codeHeader.html %}

```xml
{% include_relative /file/polygon_style.xml %}
```  

{% include imgaddclass.html %}