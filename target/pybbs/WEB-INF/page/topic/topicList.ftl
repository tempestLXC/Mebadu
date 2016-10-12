<#include "../common/layout.ftl">
<@html page_title="作品">
<link href="/static/css/index_article.css" rel="stylesheet" type="text/css" />

<div class="nav_bar_area clear">
    <div class="nav_bar_content">
        <div class="nav_bar_box">
            <div class="nav_bar_button">
                <i></i>
                全部作品
            </div>
            <ul class="nav_bar_list">
                    <li><a href="/t/topicList?type=2&view=list">全部</a></li>
                <#list sections as section>
                <#--<option value="${section.tab}">${section.name!}</option>-->
                    <li><a href="/t/topicList?type=2&view=list&tab=${section.tab}">${section.name}</a></li>
                </#list>
            </ul>
        </div>
        <#--<div class="nav_bar_box">-->
            <#--<div class="nav_bar_button">-->
                <#--<i></i>-->
                <#--编辑精选-->
            <#--</div>-->
            <#--<ul class="nav_bar_list">-->
                <#--<li class="nav_active_list_button"><a href="">全部</a></li>-->
                <#--<li><a href="">平面</a></li>-->
                <#--<li><a href="">ui</a></li>-->
                <#--<li><a href="">网页</a></li>-->
                <#--<li><a href="">动漫</a></li>-->
                <#--<li><a href="">摄影</a></li>-->
            <#--</ul>-->
        <#--</div>-->
        <#--<div class="nav_bar_box">-->
            <#--<div class="nav_bar_button">-->
                <#--<i></i>-->
                <#--最新上传-->
            <#--</div>-->
            <#--<ul class="nav_bar_list">-->
                <#--<li><a href="">全部</a></li>-->
                <#--<li><a href="">平面</a></li>-->
                <#--<li><a href="">ui</a></li>-->
                <#--<li><a href="">网页</a></li>-->
                <#--<li><a href="">动漫</a></li>-->
                <#--<li><a href="">摄影</a></li>-->
            <#--</ul>-->
        <#--</div>-->
    </div>
</div>
<div class="clear"></div>

<!--内容区域-->

<div class="content_area">
    <!--左部内容区域-->
    <div class="left_content">

    <#list page.getList() as topic>
        <!--单个数据模块start-->
        <div class="left_content_detail">
            <a href="/t/${topic.id!}">
                <img class="figure_image" src="${topic.cover_uri!}">
            </a>
            <div class="figure_text">
                <a href="/t/${topic.id!}">
                    <p class="figure_title">
                    <#if topic.title?length lt 13 >
                        ${topic.title}
                    <#else>
                        ${topic.title[0..12]}...
                    </#if>
                    </p>
                </a>
                <p class="figure_type">原创文章</p>
                <p class="figure_data">
                    <span class="figure_data_hot">${topic.view!0}</span>人气／
                    <span class="figure_data_comment">${topic.reply_count!0}</span>评论／
                    <span class="figure_data_recommend">${topic.recommend_count!0}</span>推荐
                </p>
                <p class="figure_desprition">
                    ${topic.sub_title!}
                </p>
                <div class="figure_author">
                    <img class="figure_author_header" src="${topic.getAvatarByNickname(topic.author)}">
                    <span class="figure_author_name">${topic.author!}</span>
                    <span class="upload_time">${topic.formatDate(topic.in_time)}</span>
                </div>
            </div>
        </div>
        <!--单个数据模块end-->
    </#list>

    </div>

    <!--右部内容区域-->
    <div class="right_content">
        <p class="good_article_title">精选文章</p>
        <div class="good_article_list">
        <#list recomList.getList() as recom>
            <!--单个数据模块 start-->
            <div class="good_article_detail">
                <a href="/t/${recom.id!}">
                    <img class="good_article_header" src="${recom.cover_uri!}">
                    <div class="good_article_text">
                        <p class="good_article_content"><#if recom.title?length lt 11 >
                        ${recom.title}
                        <#else>
                        ${recom.title[0..10]}...
                        </#if></p>
                        <p class="good_article_hot"><span>${recom.view!0}</span>人气</p>
                    </div>
                </a>
            </div>
            <!--单个数据模块 end-->
        </#list>
        </div>
        <p class="hot_author_title">热门作者</p>
        <div class="hot_author_list">
        <#list users.getList() as user>
            <!--单元模块start-->
            <div class="hot_author_detail">
                <a href="/user/${user.nickname}">
                <img src="/static/image/hot_${user_index+1}.jpg" alt="" class="hot_rank" />
                <img src="${user.avatar}" alt="" class="hot_author_header" />
                <div class="hot_author_introduce">
                    <p class="hot_author_name">${user.nickname}</p>
                    <#--<p class="hot_author_titlename">GUI设计</p>-->
                </div>
                </a>
            </div>
            <!--单元模块end-->
        </#list>
        </div>

    </div>

</div>


<!--分页 -->
<div class="pages">
    <#include "../components/paginate.ftl"/>
	<@paginate currentPage=page.getPageNumber() totalPage=page.getTotalPage() actionUrl="/" />
</div>
<!--分页 -->


<!--广告 -->
<div class="ad wrap"><img src="/static/image/add/07.jpg" /></div>
<!--广告 -->

<div class="clear"></div>

</@html>
