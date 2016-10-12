<#macro header page_tab="">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script src="${static_resource_uri}/js/jquery-2.2.2.min.js"></script>
<link rel="stylesheet" href="${static_resource_uri}/css/comm.css"/>
<link rel="stylesheet" href="${static_resource_uri}/css/header_comm.css"/>

<#if page_tab="index">
<link href="${static_resource_uri}/css/style.css" rel="stylesheet" type="text/css"/>
</#if>

<#if page_tab == "user">
<link href="${static_resource_uri}/css/personal_production.css" rel="stylesheet" type="text/css"/>
</#if>

</#macro>