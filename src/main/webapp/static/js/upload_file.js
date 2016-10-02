$(function () {

    //初始化编辑器
    var editor = new Editor({element: $("#content")[0], status: []});
    editor.render();

    //	input内容控制
    $(".title_input").on("input", function () {
        $(".input_title_num").eq(0).find(".red_font").text($(this).val().length);
    }).blur(function () {
        if (!$(this).val().trim().length) {
            $(this).addClass("warnBorder");
        }
    }).focus(function () {
        $(this).removeClass("warnBorder");
    });
    //	textarea内容控制
    $(".article_brief").on("input", function () {
        $(".input_title_num").eq(1).find(".red_font").text($(this).val().length);
    }).blur(function () {
        if (!$(this).val().trim().length) {
            $(this).addClass("warnBorder");
        }
    }).focus(function () {
        $(this).removeClass("warnBorder");
    });
    var articleUploadMark = true;//上传文章标示
    //	文章切换效果
    $(".upload_title_detail").click(function () {
        var index = $(this).index();
        if (index == 0) {
            $("#type").attr("value",1);
            articleUploadMark = false;
            $(".upload_title_detail").eq(0).find(".upload_production_icon").css({"background-position-x": -202});
            $(".upload_title_detail").eq(1).find("div").css({"background-position-y": -140});
        } else {
            $("#type").attr("value",2);
            articleUploadMark = true;
            $(".upload_production_icon").eq(0).css({"background-position-x": -234});
            $(".upload_title_detail").eq(1).find("div").css({"background-position-y": -110});
        }
        $(".upload_title_detail").find("span").css({"color": "#999"});
        $(this).find("span").css({"color": "#333"})
        $(".upload_line div").eq(index).animate({width: 104}, 300).css({background: "#333"});
        $(".upload_line div").eq(1 - index).animate({width: 146}, 300).css({background: "#eee"});
    });

    $(".public_button").click(function () {//发布提交按钮事件
        //if($(".warnBorder").length == 0 ||$(".warnBorder").length >50 ) return false;
        debugger;
        if (checkNULL($("#title"))) {
            return false;
        }
        if (!checkLength($("#title").val(), 50, 1)) {
            $("#title").focus();
            return false;
        }

        if (checkNULL($("#sub_title"))) {
            return false;
        }
        if (!checkLength($("#sub_title").val(), 140, 0)) {
            $("#sub_title").focus();
            return false;
        }


        if (checkNULL($("#tab"))) {
            alert("请选择分类");
            return false;
        }

        //var em = $("#error_message");

        var content = editor.value();
        if(content.length == 0) {
            //errors++;
            //em.html("回复内容不能为空");
            alert("正文内容不能为空！");
            return false;
        }

        //alert("提交");
        $("#topicForm").submit();
    });

    function checkNULL(object) {
        if (object == null) {
            object.focus();
            return true;
        }
        var value = object.val();

        if (value == null || value.length < 1) {
            object.focus();
            return true;
        }
        return false;

    }

    function checkLength(str, maxLength, minLength) {
        if (str.length > maxLength || str.length < minLength) {
            return false;
        }
        return true;
    }

    $("#upload_button").click(function(){
        toolImage.bind(null,"t_cover");
    });

});