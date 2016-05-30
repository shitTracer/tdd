//var serverUrl = "http://122.99.170.230";
//var serverUrl = "http://122.99.170.157:8080";
//var serverUrl = "http://218.38.16.204:7000";
var serverUrl = "http://218.38.16.214:7000";
//var serverUrl = "http://192.168.10.20:8080";

var androidUrl = 'https://play.google.com/store/apps/details?id=com.app.Tdd';
var iphoneUrl = 'https://play.google.com/store/apps/details?id=com.app.Tdd';
var shareUrl = "http://tdd.theminjoo.kr";


function validateEmail(emailValue){
	var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;	//이메일 유효성
	
	if(emailValue.length == 0 ){
		alert("이메일을 입력해주세요.");
		return;
	}

	if(!regEmail.test(emailValue)) {
		alert('이메일 상세주소를 입력해주세요.');
		return false;
	}
                                   
                                   
	
	return true;
	
}

function validatePwd(pwdValue,pwdValue2){
	var engPw = /[a-zA-Z]/;	//비밀번호 유효성 영문
	var numPw = /[0-9]/;	//비밀번호 유효성 숫자
	var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;    //특수문자
	

	
	if(pwdValue.length < 8 ){
		alert('비밀번호는 영문,숫자조합 8자 이상 입력하셔야 합니다.');
		return;
	}
	
	if(pwdValue2.length < 8 ){
		alert('비밀번호는 영문,숫자조합 8자 이상 입력하셔야 합니다.');
		return;
	}
	
//특수문자
//	if(!engPw.test(PASS) || !numPw.test(PASS) || !pattern3.test(PASS) ) {
//		alert('비밀번호는 반드시\n영문/숫자/특수문자 조합 8자리 이상으로\n입력해주세요.');
//		return false;
//	}
	
	if(!engPw.test(pwdValue) || !numPw.test(pwdValue) ) {
		alert('비밀번호는 영문,숫자조합 8자 이상 입력하셔야 합니다.');
		return false;
	}
	
	if(!engPw.test(pwdValue2) || !numPw.test(pwdValue2) ) {
		alert('비밀번호는 영문,숫자조합 8자 이상 입력하셔야 합니다.');
		return false;
	}
	
	
	if(pwdValue != pwdValue2){
  		alert("비밀번호가 일치하지 않습니다.");
  		return false;
  	}
	
	return true;
}


//현재날짜 포멧 하기 //포멧할 문자열(yyyy-MM-dd) 파람으로 리턴값은 String
function nowDateFormat(){
	    var d = new Date(),
	        month = '' + (d.getMonth() + 1),
	        day = '' + d.getDate(),
	        year = d.getFullYear();

	    if (month.length < 2) month = '0' + month;
	    if (day.length < 2) day = '0' + day;

	    return [year, month, day].join('-');
}

function getParameter(name)
{
var rtnval = '';

var nowAddress = decodeURI(location.href);
	var parameters = (nowAddress.slice(nowAddress.indexOf('?')+1,nowAddress.length)).split('&');

	for(var i = 0 ; i < parameters.length ; i++)
	{
		var varName = parameters[i].split('=')[0];
		if(varName.indexOf(name) > -1)
		{
			if(varName.toUpperCase() == name.toUpperCase())
			{
				rtnval = parameters[i].split('=')[1];
				break;
			}
		}
		else
			rtnval = "";
	}

  return rtnval;
}


function alertCallback(){
	//alert('오류');
}



function navigatorAlert(str){
	if(navigator.userAgent.toLowerCase().indexOf('android')>=0) {
		navigator.notification.alert(str, alertCallback, "더당당", "확인");
	}else{
		alert(str);
	}
}



