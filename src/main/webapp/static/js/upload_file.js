$(function(){
	//	input内容控制
	$(".title_input").on("input",function(){
		$(".input_title_num").eq(0).find(".red_font").text($(this).val().length);
	});
	//	textarea内容控制
	$(".article_brief").on("input",function(){
		$(".input_title_num").eq(1).find(".red_font").text($(this).val().length);
	});
	var articleUploadMark=true;//上传文章标示
	//	文章切换效果
	$(".upload_title_detail").click(function(){
		var index=$(this).index();
		if(index==0){
			articleUploadMark=false;
			$(".upload_title_detail").eq(0).find(".upload_production_icon").css({"background-position-x":-202});
			$(".upload_title_detail").eq(1).find("div").css({"background-position-y":-140});
		}else{
			articleUploadMark=true;
			$(".upload_production_icon").eq(0).css({"background-position-x":-234});
			$(".upload_title_detail").eq(1).find("div").css({"background-position-y":-110});
		}
		$(".upload_title_detail").find("span").css({"color":"#999"});
		$(this).find("span").css({"color":"#333"})
		$(".upload_line div").eq(index).animate({width:104},300).css({background:"#333"});
		$(".upload_line div").eq(1-index).animate({width:146},300).css({background:"#eee"});
	})
})