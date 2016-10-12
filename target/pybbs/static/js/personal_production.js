$(".nav_list li").click(function(){
	var index=$(this).index();
	$(".nav_active").removeClass("nav_active");
	$(this).addClass("nav_active");
	$(".production_list").removeClass("production_list_active").eq(index).addClass("production_list_active");
})
$(".production_category_button").click(function(){
	var mainCate=$(".production_list_active").index();
	var secondIndex=$(this).index();
	$(".production_category_active").removeClass("production_category_active");
	$(this).addClass("production_category_active");
});
$(document).on("click",".del_button",function(){
	$(".del_box").show();
});
$(".del_cancel_button").click(function(){
	$(".del_box").hide();
});
$(".del_sure_button").click(function(){//确定删除
	$(".del_box").hide();
});

