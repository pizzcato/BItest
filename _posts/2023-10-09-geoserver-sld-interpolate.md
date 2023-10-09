---
title: geoserver 颜色插值
author: pizzcato
date: 2023-10-9 15:24:58  +0800
categories: [GIS,geoserver]
---

## 颜色插值说明

颜色插值,就是根据某个字段属性的值,根据划定的颜色范围自动映射成相应的颜色.
如有些用红色表示最坏,绿色表示最好,而中间的颜色就可以自动划分,生成渐变有序的渲染效果.

## style设置

在sld中修改原先的`<se:SvgParameter></se:SvgParameter>`来实现.

示例:

before:

```xml
<se:SvgParameter name="stroke">#848587</se:SvgParameter>
```

after:

{% include codeHeader.html %}

```xml
<se:SvgParameter name="stroke">
<ogc:Function name="Interpolate">
    <!-- Property to transform -->
    <ogc:PropertyName>l</ogc:PropertyName>

    <!-- Mapping curve definition pairs (input, output) -->
    <ogc:Literal>0</ogc:Literal>
    <ogc:Literal>#ff0000</ogc:Literal>

    <ogc:Literal>100</ogc:Literal>
    <ogc:Literal>#00ff00</ogc:Literal>

    <ogc:Literal>500</ogc:Literal>
    <ogc:Literal>#0000ff</ogc:Literal>

      <!-- Interpolation method -->
    <ogc:Literal>color</ogc:Literal>
</ogc:Function>
</se:SvgParameter>
```

上述样式表示将边框(`stroker`) 的颜色进行线性插值,根据**l**`<ogc:PropertyName>l</ogc:PropertyName>`字段属性值,从0对应的#ff0000(红色)到 100对应的#00ff00(绿色)再到 500对应的#0000ff(蓝色)进行插值  

参考链接[Styling using Transformation Functions](https://docs.geoserver.org/stable/en/user/styling/sld/tipstricks/transformation-func.html)