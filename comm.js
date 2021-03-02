
var patterns = new Array();
patterns["num"]		= /^[0-9]+$/;
patterns["numhyphen"] = /^[0-9-\r\n]+$/;

function isNum(obj)
{
	if(obj.value.match(patterns["num"])) return true;
	else {
		alert("숫자만 입력하세요!");
		obj.focus();
		return false;
	}
}


function msglength(str) 
{
	var length = 0;

	for(var i = 0; i < str.length; i++)
	{
		if(escape(str.charAt(i)).length >= 4)
			length += 2;
		else if(escape(str.charAt(i)) == "%A7")
			length += 2;
		else
			if(escape(str.charAt(i)) != "%0D")
				length++;
	}	

	return length;
}

function chklength(obj, strMsg, nLen)
{
	if ( msglength(obj.value) > nLen ) {
		alert(strMsg + " " + nLen + "byte 가 초과 되었습니다.");
		obj.value = cutmessage(obj.value,nLen);		
	}
	
	return;
}


function chklens(str, nLen)
{
	var strReturn; 
	if ( msglength(str) > nLen ) {
		strReturn = cutmessage(str, nLen);		
	}
	
	return strReturn;
}

function cutmessage(str, max_length)
{
	var count = 0;
	 
	for(var i = 0; i < str.length; i++)
	{
		if(escape(str.charAt(i)).length >= 4)
			count += 2;
		else
			if(escape(str.charAt(i)) != "%0D")
				count++;

		if(count > max_length)
		{
			if(escape(str.charAt(i)) == "%0A")
				i--;
			break;		
		}
	}
	
	return str.substring(0, i);
}



function isNumhyphen3(str)
{
	if(str.match(patterns["numhyphen"])) return true;
	else
	{
		return false;
	}
}


function checkQuot(obj){
	if ((event.keyCode==222) ){ 
		alert ("허용된 문자가 아닙니다.");
		event.returnValue=false; 
	} else { 
		event.returnValue=true; 
	}
	obj.focus();
}

function check_email_validation(email){ 

    var emailpattern = /[-!#$%&'*+/^_~{}|0-9a-zA-Z]+(.[-!#$%&'*+/^_~{}|0-9a-zA-Z]+)*@[-!#$%&'*+/^_~{}|0-9a-zA-Z]+(.[-!#$%&'*+/^_~{}|0-9a-zA-Z]+)*/; 
    var raw_mail_address = email; 
	var result; 
    result = raw_mail_address.match(emailpattern); 

	return result
} 

function checkSPemail(strEmail) { 
        var regDoNot = /(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/; 
        var regMust = /^[a-zA-Z0-9\-\.\_]+\@[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3})$/; 
        if ( !regDoNot.test(strEmail) && regMust.test(strEmail) ) 
            return true; 
        else 
            return false; 
} 

function set_CommaComm(nStr){ 

	var formatNum = "";
	var formatNumVat = "";
    var minusFlag = "";

    var num = nStr.value;
    var e = event.keyCode;
    if (e ==35 || e==36 || e == 37 || e == 39) return;

    // 첫번째 문자 "-" 허용
    if (num.charAt(0) == "-") {
        minusFlag = "Y";
        num = num.substring(1);
    }
    
    // 숫자이외 전부 없애버렷!! 
    formatNum = Number(num.replace(/\..*|[^\d]/g,""));
    formatNum = formatNum.toLocaleString().slice(0,-3);
    formatNumComma = formatNum.toLocaleString().slice(0,-3);
    if (minusFlag == "Y"){
		formatNum = "-" + formatNum;
	}
  return nStr.value = formatNum;

}

function showEmoticon()
{
	addDiv.style.visibility = "visible"; 
}

function hideEmoticon()
{
	addDiv.style.visibility = "hidden"; 
}

function login_chk(){
	alert("로그인 후 사용 바랍니다.");
}

function edukrinfra(){
	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	



	obj.action="edu_ok.asp";
	obj.submit();

}


function moviekrinfra(){
	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	

	obj.action="/application/movieday_ok.asp";
	obj.submit();

}


function event_day(){

	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	

	if(obj.p_applyday.value == ""){
		alert("희망신청일을 입력하세요");
		obj.p_applyday.focus();
		return;
	}

	obj.action="/application/event_day_ok.asp";
	obj.submit();

}

//P&ID
function event_day_pnid(){

	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	


	obj.action="/application/event_day_ok.asp";
	obj.submit();

}

//intergraph
function event_intergraph(){

	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	


	obj.action="/application/event_day_ok.asp";
	obj.submit();

}


//이벤트 신청 공통
function event_comm(){

	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	

	var con = document.getElementById("roadingimg");
	con.style.display = '';

	obj.action="/application/event_day_ok.asp";
	obj.submit();

}

//이벤트 신청 공통
function event_comm_new_lodingimg(){

	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	

	roadingimg.style.display=""; //로딩이미지

	obj.action="/application/event_day_ok.asp";
	obj.submit();

}


//루미온 신청 공통 
function lumion_comm_new_lodingimg(){

	obj = document.frmMain;

	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_name.value == ""){
		alert("성함을 입력하세요");
		obj.p_name.focus();
		return;
	}

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	

	if(obj.p_tel.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel.focus();
		return;
	}	

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	

	if(obj.p_address.value == ""){
		alert("주소를 입력하세요");
		obj.p_address.focus();
		return;
	}	

	roadingimg.style.display=""; //로딩이미지

	obj.action="/application/event_day_ok.asp";
	obj.submit();

}


function lumion_menual(){

	obj = document.frmMain;

	if(obj.p_name.value == ""){
		alert("이름을 입력하세요");
		obj.p_name.focus();
		return;
	}


	if (obj.p_company.value=="")
	{
		alert("회사명을 입력하세요");
		obj.p_company.focus();
		return;	
	}


	if(obj.p_tel1.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel1.focus();
		return;
	}	

	if(obj.p_tel2.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel2.focus();
		return;
	}


	if(obj.p_tel3.value == ""){
		alert("전화번호를 입력하세요");
		obj.p_tel3.focus();
		return;
	}

	if(obj.p_email.value == ""){
		alert("이메일을 입력하세요");
		obj.p_email.focus();
		return;
	}	

	if(obj.p_position.value == ""){
		alert("직급을 입력하세요");
		obj.p_position.focus();
		return;
	}	


	if(obj.p_applyday.value == ""){
		alert("희망신청일을 입력하세요");
		obj.p_applyday.focus();
		return;
	}

    obj.p_tel.value = obj.p_tel1.value +"-"+ obj.p_tel2.value +"-"+ obj.p_tel3.value;

	obj.action="/application/event_day_ok.asp";
	obj.submit();

}


function FormatNumber(nNum) { 
var sNum = ""; 
var len= 0; 
do{ 
sNum = nNum % 10 + ((len++ % 3 == 0 && len > 1)?",":"") + sNum; 
}while( (nNum = Math.floor(nNum / 10)) > 0) 

return sNum; 
} 