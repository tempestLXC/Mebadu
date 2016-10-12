<#macro paginate currentPage totalPage actionUrl urlParas="" showdivide="yes">
    <#if (totalPage <= 0) || (currentPage > totalPage)><#return></#if>
    <#local startPage = currentPage - 2>
    <#if (startPage < 1)><#local startPage = 1></#if>

    <#local endPage = currentPage + 2>
    <#if (endPage > totalPage)><#local endPage = totalPage></#if>
    <#if totalPage &gt; 1 && showdivide == "yes">
    <#--<div class="divide mar-top-5"></div>-->
    </#if>
<#--<ul class="pagination pagination-sm <#if totalPage == 1>hidden-xs hidden-sm hidden-md hidden-lg</#if>">-->
    <#if (currentPage <= 3)>
        <#local startPage = 1>
    </#if>
    <#if ((totalPage - currentPage) < 2)>
        <#local endPage = totalPage>
    </#if>

    <#if (currentPage == 1)>
    <a class="pr">
        <img src="${static_resource_uri}/image/left_jt.png" />
    </a>
    <#else>
    <a href="${actionUrl}?p=#{currentPage - 1}${urlParas!}" class="pr">
        <img src="${static_resource_uri}/image/left_jt.png" />
    </a>
    </#if>

    <#list startPage..endPage as i>
        <#if currentPage == i>
            <a class="now">#{i}</a>
        <#else>
            <a href="${actionUrl}?p=#{i}${urlParas!}">#{i}</a>
        </#if>
    </#list>

    <#if (currentPage == totalPage)>
    <a class="pr">
        <img src="${static_resource_uri}/image/right_jt.png" />
    </a>
    <#else>
    <a href="${actionUrl}?p=#{currentPage + 1}${urlParas!}" class="pr">
        <img src="${static_resource_uri}/image/right_jt.png" />
    </a>
    </#if>
<#--</ul>-->
</#macro>