# GitBook 插件
<!--email_off-->  
记录一本站点使用到的插件,如果有其它的需求，可以到 [插件官网](https://plugins.gitbook.com/) 区搜索相关插件。 如果要指定插件的版本可以使用 `plugin@0.3.1`。下面的插件在 GitBook 的 `3.2.3` 版本中可以正常工作，因为一些插件可能不会随着 GitBook 版本的升级而升级，即下面的插件可能不适用高版本的 GitBook，所以这里指定了 GitBook 的版本。
<!--/email_off-->
- [GitBook 插件](#gitbook-%E6%8F%92%E4%BB%B6)
  - [Search pro](#search-pro)
  - [Splitter](#splitter)
  - [Expandable-chapters-small](#expandable-chapters-small)
  - [Anchor-navigation-ex](#anchor-navigation-ex)
  - [Local Video](#local-video)

## Search pro
支持中文搜索, 需要将默认的 `search` 和 `lunr` 插件去掉。  

[插件地址](https://plugins.gitbook.com/plugin/search-plus)

```json
{
    "plugins": ["-lunr", "-search", "search-pro"]
}
```

## Splitter
使侧边栏的宽度可以自由调节

![](https://raw.githubusercontent.com/yoshidax/gitbook-plugin-splitter/master/gitbook-splitter-demo.gif)  

[插件地址](https://plugins.gitbook.com/plugin/splitter)
```json
"plugins": [
    "splitter"
]
```

## Expandable-chapters-small
使左侧的章节目录可以折叠

[插件地址](https://plugins.gitbook.com/plugin/expandable-chapters-small)

```json
plugins: ["expandable-chapters-small"]
```

## Anchor-navigation-ex
添加Toc到侧边悬浮导航以及回到顶部按钮。需要注意以下两点：
* 本插件只会提取 h[1-3] 标签作为悬浮导航
* 只有按照以下顺序嵌套才会被提取
```
# h1
## h2
### h3
必须要以 h1 开始，直接写 h2 不会被提取
## h2
```

[插件地址](https://plugins.gitbook.com/plugin/anchor-navigation-ex)
```json
{
    "plugins": [
        "anchor-navigation-ex"
    ],
    "pluginsConfig": {
        "anchor-navigation-ex": {
            "isRewritePageTitle": true,
            "isShowTocTitleIcon": true,
            "tocLevel1Icon": "fa fa-hand-o-right",
            "tocLevel2Icon": "fa fa-hand-o-right",
            "tocLevel3Icon": "fa fa-hand-o-right"
        }
    }
}
```



## Local Video
使用Video.js 播放本地视频  
[插件地址](https://plugins.gitbook.com/plugin/local-video)  
```json
"plugins": [ "local-video" ]
```
使用示例：为了使视频可以自适应，我们指定视频的`width`为100%，并设置宽高比为`16:9`，如下面所示
```
{% raw %}
<video id="my-video" class="video-js" controls preload="auto" width="100%"
poster="https://zhangjikai.com/resource/poster.jpg" data-setup='{"aspectRatio":"16:9"}'>
  <source src="用户手册工具演示视频.mp4" type='video/mp4' >
  <p class="vjs-no-js">
    To view this video please enable JavaScript, and consider upgrading to a web browser that
    <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
  </p>
</video>
{% endraw %}
```
另外我们还要再配置下css，即在website.css中加入
```css
.video-js {
    width:100%;
    height: 100%;
}
```
<br />
{% raw %}
<video id="my-video" class="video-js" controls preload="auto" width="100%" poster="resource/demoVideoPic.png" data-setup='{"aspectRatio":"16:9"}'>
  <source src="resource/demoVideo.mp4" type='video/mp4' >
  <p class="vjs-no-js">
    To view this video please enable JavaScript, and consider upgrading to a web browser that
    <a href="https://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a>
  </p>
</video>
{% endraw %}


