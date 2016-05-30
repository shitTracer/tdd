$(window).ready(function(){
	checkbox('.check_list');
	rdoBox('.rdo_list');
	//feelBtn();
})
$(window).resize(function(){
        pop_reposition();
});

// 공유하기 
function feelBtn(){
	var feel_cts = $(".feel_wrap");
	
	feel_cts.each(function(){
		var btn = $(this).children('.feel_btn');
		var view = btn.siblings();
		
		btn.click(function(){
			$(this).parent().toggleClass('on');
			if($(this).parent().hasClass('on')){
				view.fadeIn();
			}else{
				view.fadeOut();
			}
		})
	})
}

// checkbox
function checkbox(obj){
	$(obj).find('input').each(function(){
		// 마크업에 checked 가 있을 시 on class 추가
		if($(obj).find('input:checked')) {
			$(obj).find('input:checked').parent().addClass('on');
		}
		// 마크업에 disabled 가 있을 시 on class 추가
		if($(obj).find('input:disabled')) {
			$(obj).find('input:disabled').parent().addClass('non');
		}

		var $chk = $(this);
		$chk.on('click',function(){
			$chk.parent().toggleClass('on');

			if($chk.parent().hasClass('on')){
				$chk.attr('checked',true).prop('checked',true);
			}else{
				$chk.attr('checked',false).prop('checked',false);
			}
		})
	})
}

// radio
function rdoBox(obj){
	$(obj).find('input').each(function(){
		// 마크업에 checked가 있을 시 on class 추가
		if($(obj).find('input:checked')) {
			$(obj).find('input:checked').parent().addClass('on');
		}
		// 마크업에 disabled 가 있을 시 non class 추가
		if($(obj).find('input:disabled')) {
			$(obj).find('input:disabled').parent().addClass('non');
		}

		var $radio = $(this);
		$radio.on('click',function(){
			$radio.parent().toggleClass('on');

			if($radio.parent().hasClass('on')){
				$radio.parent().siblings().find('input').attr('checked',false).prop('checked',false);
				$radio.parent().siblings().removeClass('on');
				$radio.attr('checked',true).prop('checked',true);
			}
		})
	})
}

// popup
function toggleLayer(obj, s ) {

    var zidx = $("#layMask").css("z-index");

    if(s == "on") {
        var left = ( $(window).scrollLeft() + ($(window).width() - obj.width()) / 2 );
        var top = ( $(window).scrollTop() + ($(window).height() - obj.height()) / 2 );
        
        if(top<0) top = 0;
        if(left<0) left = 0;

        if($(".popup_layer").length > 1) {
            var layer_idx = Number(zidx) + 10;
        }

        $("#layMask").css("z-index", layer_idx);
        obj.css({"left":left, "top":top, "z-index":layer_idx}).addClass("popup_layer");
      
        wrapWindowByMask();
        obj.fadeIn(300);
		$('#layMask').center();
        //obj.find('.percent').addClass('on');
    }

    if(s == "off") {
        if($(".popup_layer").length > 1) {
            //var layer_idx = zidx - 10;
            //$("#layMask").css("z-index", layer_idx);
        } else {
            $("#layMask").fadeOut(300);
        }

        obj.removeClass("popup_layer").fadeOut(300);
        //obj.find('.percent').removeClass('on');
    }

	// 키보드 esc 눌렀을 때 닫힘
	$(document).keydown(function(e){
		if(e.keyCode === 27){
			if( $(".pop_layer").hasClass("popup_layer")){
				$(".pop_layer").fadeOut().removeClass("popup_layer");
				$('#layMask').fadeOut(300);
			}
			return false;
		}
	});

	// layMask 클릭시 닫힘
	$('#layMask').click(function(){
		obj.removeClass("popup_layer").fadeOut(300);
		$(this).fadeOut(300);
	});

}

function wrapWindowByMask() { 
    var mask = $("#layMask");
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();
    mask.css({'width':maskWidth,'height':maskHeight});
    mask.fadeIn(300);
}

//pop_reposition
function pop_reposition(){
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();
    $('#layMask').css({'width':maskWidth,'height':maskHeight});
    $(".pop_layer").each(function () {
        var left = ( $(window).scrollLeft() + ($(window).width() - $(this).width()) / 2 );
        var top = ( $(window).scrollTop() + ($(window).height() - $(this).height()) / 2 );
        if(top<0) top = 0;
        if(left<0) left = 0;
        $(this).css({"left":left, "top":top});
    });

}
jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
}
