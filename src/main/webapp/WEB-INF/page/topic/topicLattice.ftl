<#include "../common/layout.ftl">
<@html page_title="作品">
<link href="/static/css/index_production.css" rel="stylesheet" type="text/css" />

<div class="nav_bar_area clear">
    <div class="nav_bar_content">
        <div class="nav_bar_box">
            <div class="nav_bar_button">
                <i></i>
                全部作品
            </div>
            <ul class="nav_bar_list">
                <li><a href="/t/topicList?type=1&view=lattice">全部</a>
                <#list sections as section>
                    <#--<option value="${section.tab}">${section.name!}</option>-->
                    <li><a href="/t/topicList?type=1&view=lattice&tab=${section.tab}">${section.name}</a></li>
                </#list>
                <#--<li><a href="">全部</a></li>-->
                <#--<li><a href="">平面</a></li>-->
                <#--<li><a href="">ui</a></li>-->
                <#--<li><a href="">网页</a></li>-->
                <#--<li><a href="">动漫</a></li>-->
                <#--<li><a href="">摄影</a></li>-->
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


<!--首页推荐 -->
<div class="index">
    <div class="wrap">
        <!--标题 -->

        <!--列表 -->
        <div class="index_list">
            <ul>
            <#list page.getList() as topic>
                <!--每个但愿模块start-->
                <li>
                    <a href="/t/${topic.id!}">
                      <span class="index_pic"><img src="${topic.cover_uri!}" /></span>

                      <span class="index_title">
                          <#if topic.title?length lt 13 >
                          ${topic.title}
                          <#else>
                          ${topic.title[0..12]}...
                          </#if>
                      </span>
                        <div class="index_type">
                            <div class="production_mark">好文转载</div>
                            <span class="production_type">插画</span>
                        </div>
                      <span class="index_data">
                        <i>${topic.view!0}</i> 人气 / <i>${topic.reply_count!0}</i> 评论 / <i>${topic.recommend_count!0}</i>推荐
                      </span>
                      <span class="index_user">
                        <em class="tx"><img src="${topic.getAvatarByNickname(topic.author)}" /> <i>${topic.author!}</i></em>
                        <em class="time">${topic.formatDate(topic.in_time)}</em>
                      </span>
                    </a>
                </li>
                <!--每个但愿模块end-->
            </#list>
            </ul>
        </div>
        <!--列表 -->

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
