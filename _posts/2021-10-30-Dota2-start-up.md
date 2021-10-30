---
title:  "Dota2载入图Mod" 
author: pizzcato
date:   2021-10-30 08:42:52  +0800
categories: [Dota2]
tag: Mod
---

<style>
strong{color:red}
em{color:navy}
</style>

## 图片准备  

图片格式可以为jpg/png/psd,但是要求长和宽必须为**2的幂数**  
![图 1](https://i.loli.net/2021/10/30/ipfkO4E1uMs8v3P.png)  

图片的像素会影响生成文件的大小,我使用的上图分辨率,最后生成的*vtex_c*大小约为5m

## in Workshop Tools  

1. 选择Material editor  
1. 新建一个贴图文件*vmat*  
1. 保存vmat到工作目录的materials文件夹下[^1]  
1. *Shaders*选择**Unlit**[^2]  
  ![图 2](https://i.loli.net/2021/10/30/xPwofYbhGMzSVLy.png)  

## in Unlit Options

1. 勾选Translucent支持图层的透明度(jpg不支持透明度,可选可不选,最好选上)  
1. 在Color贴图里选择要使用的图片[^3]  
  ![图 4](https://i.loli.net/2021/10/30/5kPxqeu84gUlWfH.png)  
1. 点击![图 5](https://i.loli.net/2021/10/30/n1vPyxFUzoRG8Lp.png)进入[Texture Settings](#in-texture-settings)  

## in Texture Settings

> important ""
>此项设置我也不是很清楚原理,也不清楚具体是哪项设置起效的

按图上设置就vans了  
![图 6](https://i.loli.net/2021/10/30/dBbi4JGhFXPK5R6.png)  

**需要注意的是有时候只修改Texture Settings保存后有可能不会更新生成的*vtex_c*文件,此时可以先手动删除生成好的文件,然后保存重新触发编译生成即可**  

---

[^1]: 路径没有强制要求。在使用的时候替换的是vmat文件，vmat的位置可以任意；vtex是由vmat引用的，mod时vtex的路径需要和创建导入时的保持一致  
[^2]: 默认中没有Unlit选项,在Dev中  
[^3]: 选择后会生成对应路径和文件名的*Vtex*,在mod使用时需要保持路径和文件名  

{% include imgaddclass.html %}
