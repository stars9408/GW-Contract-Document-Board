<!doctype html>
<html lang="ko">
<head>
<meta charset="euc-kr">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>:: Virtual Office ::</title>

<link rel="stylesheet" type="text/css" href="/css/default.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">

<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/css/yay.min.css">
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script language="javascript" src="/js/smallcalendarNew_rpa.js"></script>

<script>
$(document).ready(function() {
 $(".box").append("<img src='/images/dataloading.gif'/>").find("img").load(function(){loadComplete();});
});
function loadComplete(){
 //alert("imgload");
}
</script>
</head>
<script>

$.ajax({
    url: URL,
    dataType: 'json',
    type: 'POST',
    data: {
        //data
    },
    beforeSend: function() {
        //마우스 커서를 로딩 중 커서로 변경
        $('html').css("cursor", "wait");
    },
    complete: function() {
        //마우스 커서를 원래대로 돌린다
        $('html').css("cursor", "auto");
    },
    success: function(data) {
        //통신성공
    }
});


</script>
<script>
//AJAX 통신 시작
$( document ).ajaxStart(function() {
    //마우스 커서를 로딩 중 커서로 변경
    $('html').css("cursor", "wait"); 
});
//AJAX 통신 종료
$( document ).ajaxStop(function() {
    //마우스 커서를 원래대로 돌린다
    $('html').css("cursor", "auto"); 
});
 


</script>

