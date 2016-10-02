<#macro html page_title page_tab="">
<!doctype html>
<html lang="zh-CN">
<head>
    <#include "./header.ftl">
    <@header page_tab=page_tab/>
    <title>${pageTitle!}</title>
    <script>
        $(document).ready(function(){
            $(".shuru").click(function(){
                $(".search_chose").toggle(200);
            });
        });
    </script>
</head>
<body>
<!--头部 -->
    <#include "./topBar.ftl">
    <@topBar/>
<!--头部 -->
<div class="wrapper">

    <div class="container">
        <#nested />
    </div>
</div>
<!-- 页脚 -->
    <#include "./footer.ftl">
    <@footer/>
</body>
</html>
</#macro>