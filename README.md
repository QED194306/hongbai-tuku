# 红白图库

红白主题插画图库，提供可直接外链的图片地址（用于 AO3 等不支持上传图片的站点）。

## 文件

| 文件 | 尺寸 | 说明 |
| --- | --- | --- |
| `docs/light.png` | 2000px 宽 | 浅色版，基本无损，推荐外链使用 |
| `docs/mid.png` | 2000px 宽 | 中间版，基本无损，推荐外链使用 |
| `docs/dark.png` | 2000px 宽 | 深色版，基本无损，推荐外链使用 |
| `docs/1.png` | 865×1246 | 竖版图 1，原尺寸 |
| `docs/2.png` | 847×1399 | 竖版图 2，原尺寸 |
| `docs/3.png` | 850×805 | 图 3，原尺寸 |
| `docs/preview.jpg` | 1474×794 | 预览缩略图 |
| `original/` | 5947×3203 | 横版主图的全分辨率原件 |

## 在 AO3 使用

AO3 不能上传图片，只能引用外部地址。在作品编辑页切换到 **HTML** 模式，粘贴：

```html
<img src="图片地址" alt="红白图" />
```

想点击放大时用：

```html
<a href="图片地址" target="_blank"><img src="图片地址" style="max-width:100%;" /></a>
```

## 更新图片

把新的原图替换到 `original/`，然后运行：

```powershell
pwsh -File tools/resize.ps1
```
