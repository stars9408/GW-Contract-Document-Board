<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!--METADATA TYPE= "typelib"  NAME= "ADODB Type Library"
      FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"  -->

<!--#include virtual="/config/configx.asp" -->
<!--#include virtual="/Library/common.asp" -->

<% 
	Server.ScriptTimeout = 9999999
	'response.Expires=-1

	if session("id") = "" then 
%>
    	<script language="javascript">
    		alert("그룹웨어 연결이 종료 되었습니다.!\n 다시 로그인해 주세요!");
    		parent.parent.location.href="http://office.krinfra.co.kr/default.asp";
    	</script>
<%
	    Response.end
	end if
	
	'response.Expires=0

	Set db = Server.CreateObject("ADODB.Connection")
	'Set dbwww = Server.CreateObject("ADODB.Connection")
	'Set erpdb = Server.CreateObject("ADODB.Connection") 
	'Set erpBase = Server.CreateObject("ADODB.Connection") 
	'Set erpNeoe = Server.CreateObject("ADODB.Connection") 
	'Set dbcall = Server.CreateObject("ADODB.Connection") 

	'그룹웨어 연결
	db.CursorLocation = 3
	strConnection = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID="&gwdbid&";Password="&gwdbpwd&";Initial Catalog="&gwdbname&";Data Source="&dbip&""
	db.Open strConnection

	'ERP 연결 dzmfg
	strConnection = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID="&erpdbid_dzmfg&";Password="&erpdbpwd_dzmfg&";Initial Catalog="&erpdbname_dzmfg&";Data Source="&erpdbip_dzmfg&""
	'erpdb.Open strConnection


	'ERP 연결 
	'erpBase.CursorLocation = 3
	strConnection = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID="&erpdbid_base&";Password="&erpdbpwd_base&";Initial Catalog="&erpdbname_base&";Data Source="&erpdbip_base&""
	'erpBase.Open strConnection

	'ERP 연결 NEOE
	strConnection_erpNeoe = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID="&erpdbid_neoe&";Password="&erpdbpwd_neoe&";Initial Catalog="&erpdbname_neoe&";Data Source="&erpdbip_neoe&""
	'erpNeoe.Open strConnection_erpNeoe


	'홈페이지 연결 
	strConnection_www = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID="&homedbid&";Password="&homedbpwd&";Initial Catalog="&homedbname&";Data Source="&homedbip&""
	'dbwww.Open strConnection_www

	'Call 홈페이지 연결 
	strConnection_call = "Provider=SQLOLEDB.1;Persist Security Info=True;User ID="&ascdbid&";Password="&ascdbpwd&";Initial Catalog="&ascdbname&";Data Source="&ascdbip&""
	'dbcall.Open strConnection_call


	upload_component = "0" '/업로드가능 1 ABC, 2 DEXT
	setUploadSize = 5000000 '/업로드파일크기
	home_dir1        = "http://office.krinfra.co.kr/"

	upload_path = "E:/www/gw/src/"
	u_path = "E:/www/gw/src/file_upload/data_file/"
	cheditorFile = "E:\\www\\gw\\src\\upload\\img"
	file_path_single = "E:/www/gw/src/file_upload_single/data_file/"
	file_path_project = "E:/www/gw/src/si_project/data_file/"
	do_path = "/krinfragw1/"
	sign_path = "/sign/"

	 'KISA WEB Security Template
	Application("CASTLE_ASP_VERSION_BASE_DIR") = "/castle2"
	Server.Execute(Application("CASTLE_ASP_VERSION_BASE_DIR") & "/castle_referee.asp")

%>

<!--#include virtual="/include/open_history.asp" -->
