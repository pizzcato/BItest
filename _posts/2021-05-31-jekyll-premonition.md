---
title:  "Jekyll Premonition 自定义"
date:   2021-05-31 11:59:34  +0800
categories: [Jekyll]
math: true
---

1. _config.yml中添加  

    ```yml
    premonition:
      types:
        important: #标签名字
          meta:
            fa-icon: fa-bell #标签使用的fa图标
    ```

1. Premonition插件使用的样式文件(/_sass/addon/premonition.scss)的`.premonition`下添加  

    ```scss
    &.important {
        @include box-type($error-important, $error-light-color);
      }
    ```

    其中.important就是标签的名字`error-important`为背景和文字的标志颜色

> important "name"
> content  

```markdown
> important "name"
> content  
```  
