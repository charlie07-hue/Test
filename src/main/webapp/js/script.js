$(function(){
    $(".depth1 > li").mouseover(function(){
        $(this).find('.depth2').stop().slideDown(300);
    }).mouseleave(function(){
        $(this).find('.depth2').stop().slideUp(300);
    });

    var q_left = $('.menu').position().left+1200;
    var q_top = $('.menu').position().top;
    $('.quickMenu').css({
        'top':q_top,
        'left':q_left
    });

    function scroll() {
        
        //console.log($(window).scrollTop());
        var new_top = $(window).scrollTop()+q_top;
        var new_left = $('.menu').position().left+1200;
        // $('.quickMenu').css({
        //     'top':new_top
        // });
        $('.quickMenu').stop().animate({
            'top':new_top,
            'left':new_left
        },500);
    }
    $(window).scroll(function() {
        scroll();
    });
    $(window).resize(function() {
        scroll();
    });
    $(".board_title").click(function(){
        $('.board_title').removeClass('on');
        $(this).addClass('on');
        //console.log($(this).text());
        if ($(this).text()=='공지사항') {
            $('#board_notice').show();
            $('#board_data').hide();
        } else {
            $('#board_notice').hide();
            $('#board_data').show();
        }
    });
    $('#goTop').click(function(){
        $('html').animate({'scrollTop':0},200);
    });
});

function setEditor(holder){
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: holder,
		sSkinURI: "/project/smarteditor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
				//alert("아싸!");	
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	return oEditors;
}
