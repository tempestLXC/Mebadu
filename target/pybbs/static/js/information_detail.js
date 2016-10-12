$(function(){
	
	$(".support_article").click(function(){
		$(this).css({backgroundPositionX:-123});
		$(this).text($(this).text()-0+1);
		
	});
	
	$(document).on("click",".apply_comment",function(){
		$(this).parents(".comment_detail").find(".comment_second_textarea").show();
	});
	
	$(document).on("click",".cancel_button",function(){
		$(this).parents(".comment_second_textarea").hide();
	})
	
})
