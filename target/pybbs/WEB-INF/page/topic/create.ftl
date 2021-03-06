<#include "../common/layout.ftl">
<@html page_title="发布话题">

<link href="/static/css/upload_file.css" rel="stylesheet" type="text/css"/>
<div class="content">
    <div class="upload_title">
        <div class="upload_title_detail">
            <div class="upload_production_icon"></div>
            <span>上传作品</span>
        </div>
        <div class="upload_title_detail detail_right">
            <div class="upload_article_icon"></div>
            <span>上传文章</span>
        </div>
    </div>
    <form method="post" action="/t/create" id="topicForm" name="topicForm">
        <div class="upload_line">
            <div class="line_left"></div>
            <div class="line-right"></div>
        </div>
        <div class="upload_content">
            <div class="upload_image">
                <img id="preview" src="/static/image/upload_defalt.jpg" alt=""/>
                <div id="upload_button" class="upload_button">编辑封面（520x400）</div>
            </div>
            <div class="upload_input_content">
                <p class="article_input_title">
                    <span class="input_title_left">标题<em class="red_font">*</em></span>
                    <span class="input_title_num"><em class="red_font">0</em>/<em>50</em></span>
                </p>
                <input type="text" class="title_input" id="title" name="title" placeholder="标题">
                <div class="select_area">
                    <select name="tab" id="tab">
                        <option value="">选择分类（必选项）</option>
                        <#list sections as section>
                            <option value="${section.tab}">${section.name!}</option>
                        </#list>
                    </select>
                    <select name="subsection_id" id="subsection_id">
                        <#list subsections as subsection>
                            <option value="${subsection.id}">${subsection.title!}</option>
                        </#list>
                    </select>
                    <input type="text" class="author_fil" name="original" placeholder="请填写作者"/>
                </div>
                <p class="article_input_title">
                    <span class="input_title_left">简介：</span>
                    <span class="input_title_num"><em class="red_font">0</em>/<em>140</em></span>
                </p>
                <textarea name="sub_title" id="sub_title" rows="3" cols="3" class="article_brief" maxlength="140"></textarea>
            </div>
            <div class="clear"></div>
            <p class="edit_upload_title">内容：</p>
            <div class="edit_upload_content">
                <textarea name="content" id="content" rows="" cols="100" class="form-control"
                          placeholder="支持Markdown语法哦~"></textarea>
            </div>

            <input type="hidden" name="cover_uri" id="cover_uri" >
            <input type="hidden" name="type" id="type" value="2" ><#--1、作品 2、文章-->
            <button type="button" class="public_button">发布</button>
        <#--<div class="preview_button">预览</div>-->
        </div>
    </form>
</div>

</@html>
<script>
    $(document).ready(function () {
        $(".shuru").click(function () {
            $(".search_chose").toggle(200);
        });
    });
</script>
<link rel="stylesheet" href="/static/css/bootstrap.css"/>
<link rel="stylesheet" href="/static/libs/editor/editor.css"/>
<script type="text/javascript" src="/static/libs/webuploader/webuploader.withoutimage.js"></script>
<script type="text/javascript" src="/static/libs/markdownit.js"></script>
<script type="text/javascript" src="/static/libs/editor/editor.js"></script>
<script type="text/javascript" src="/static/libs/editor/ext.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/upload_file.js"></script>