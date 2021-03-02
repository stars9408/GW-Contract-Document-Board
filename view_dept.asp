<!--#include virtual="/connect.asp" -->
<!-- #include virtual="/Lib/Asp/Func/Board.Func.asp" -->
<!-- #include virtual="/downloadconfig.asp" -->

<!--#include virtual="/include/default.asp" -->

<% 
response.Expires=0
searcharea = request("searcharea")
searchword = request("searchword")
view_st = request("view_st")	
import_file = request("import_file")

IF session("secu_permit") = "0" and request("import_file") = "0" THEN

	With Response
		.Write "<script language=""javascript"">" & vbcrlf _
			& "<!--" & vbcrlf _
			& "	alert(""기밀문서함을 볼 수 있는 권한이 없습니다."");" & vbcrlf _
			& "	history.back();" & vbcrlf _
			& "//-->" & vbcrlf _
			& "</script>" & vbcrlf
		.End
	End With

END IF


'======================================================
pagego="view_dept.asp"
db_board_name=" userlist a, contract_file b "
page=request("page")
PageSize=15
If page="" Then page = 1
'======================================================


IF searcharea = "s_title" THEN
	sqlsearcharea = "b.pname"
ELSEIF searcharea = "s_file_name" THEN
    sqlsearcharea = " b.filename1 "
ELSEIF searcharea = "s_file_size" THEN
    sqlsearcharea = " b.file_size "
ELSEIF searcharea = "s_w_name" THEN
	sqlsearcharea = " a.pperiod "
ELSEIF searcharea = "s_w_date" THEN
	sqlsearcharea = " b.w_date"
ELSEIF searcharea = "s_content" THEN
	sqlsearcharea = " b.content"
ELSEIF searcharea = "s_venodr_file" THEN
	sqlsearcharea = " b.com_name "
	addSearcharea = " AND b.file_kind='발급처'"
ELSEIF searcharea = "s_propose_file" THEN
	sqlsearcharea = " b.com_name"
	addSearcharea = " AND b.file_kind='제출처'"
END IF 

	   
IF view_st = "v_title" THEN
	strOrderby = "order by b.pname"
ELSEIF view_st = "v_file_name" THEN
    strOrderby = " order by b.filename1 "
ELSEIF view_st = "v_file_size" THEN
    strOrderby = " order by b.file_size "
ELSEIF view_st = "v_emp_id" THEN
	strOrderby = " order by a.pperiod "
ELSEIF view_st = "v_w_date" THEN
	strOrderby = " order by b.w_date, b.w_date_time "
ELSE
	strOrderby = " order by b.db_idx desc "
END IF


IF searchword = ""   THEN

	'//전체 레코드 쿼리
	totSql = "SELECT COUNT(db_idx) FROM  " & db_board_name&" Where  a.emp_id = b.emp_id  " 

	'//해당 페이지 쿼리
		Sql = "SELECT TOP "& PAGESIZE &" "
		Sql = Sql & " * FROM "& db_board_name & " Where  a.emp_id = b.emp_id "

	If page > 1 then
	Sql = Sql & " AND db_idx NOT IN(SELECT TOP " & ((Page - 1) * PageSize) & " db_idx FROM " & db_board_name & ""
	Sql = Sql & " Where  a.emp_id = b.emp_id "&strOrderby&") "

	End If
	Sql = Sql & strOrderby

 Else

	'//전체 레코드 쿼리
	totSql = "SELECT COUNT(db_idx) FROM  " & db_board_name&" Where  a.emp_id = b.emp_id  and "&sqlsearcharea&" like '%"& searchword &"%' "& addSearcharea &""
	
	'//해당 페이지 쿼리
		Sql = "SELECT TOP "& PAGESIZE &" "
		Sql = Sql & " * FROM "& db_board_name & "  Where   a.emp_id = b.emp_id AND "&sqlsearcharea&" like '%"& searchword &"%'  "& addSearcharea &""

	If page > 1 then
	Sql = Sql & " AND db_idx NOT IN(SELECT TOP " & ((Page - 1) * PageSize) & " db_idx FROM " & db_board_name & ""
	Sql = Sql & " Where  a.emp_id = b.emp_id and "&sqlsearcharea&" like '%"& searchword &"%' "& addSearcharea &" "
	Sql = Sql & " "&strOrderby&") "

	End If
	Sql = Sql & strOrderby

End If


	Set totRs = Server.CreateObject("ADODB.RecordSet")
	totRs.Open totSql, db, adOpenForwardOnly, adLockReadOnly, adCmdText
	Total = totRs(0) '총레코드...
	PageCount = Int((Total-1)/PageSize) +1
	Num = Total - ((page-1) * PageSize)
	totRs.Close : Set totRs = Nothing

	Set Rs3 = Server.CreateObject("ADODB.RecordSet")

	Rs3.CursorLocation = 3
	Rs3.CursorType = 3
	Rs3.LockType = 3

	Rs3.Open Sql, db, adOpenForwardOnly, adLockReadOnly, adCmdText

	a=Rs3.RecordCount
	vnum=PageSize-a

%>

<script src="/jscript/comm.js" type="text/javascript"></script>

<SCRIPT LANGUAGE="JavaScript">


function makeWindows1()
  {
        this.document.location.href = "upload_file.asp";
  }

function edit_file()
	{
		var flag=0;
		l=folder_FORM.elements.length;
		for (i=0;i<l;i++) {
			if (folder_FORM.elements[i].checked) {
				flag++;
			}
		}
		if (flag<1) {
			alert('수정할 자료를 선택해 주세요!');
			return;
		}
		
		if (flag>1 ) {
			alert('자료를 1개이상 선택하여 수정 할수 없습니다.\n\n다시 확인해주시기 바랍니다.');
			return;
		}
		
		else {
			document.folder_FORM.flag.value = "edit_file";
			document.folder_FORM.submit();
		}
	}

function delete_file()
	{

		var flag=0;
		l=folder_FORM.elements.length;
		for (i=0;i<l;i++) {
			if (folder_FORM.elements[i].checked) {
				flag++;
			}
		}
		if (flag<1) {
			alert('삭제할 자료를 선택해 주세요!');
			return;
		}

		if ( confirm ("선택한 자료를 삭제하시겠습니까?") ){
		
		}
		else {
			return;
		}

		document.folder_FORM.flag.value = "delete_file";
		document.folder_FORM.submit();

	}

</SCRIPT>

<div class="conSection">
	<h2><!--#include virtual="/contract_file_upload/file_title.asp" --></h2> 

	<form name='folder_FORM' action='from_file.asp'>
	<input type="hidden" name="flag" value="">
	<input type="hidden" name="page" value="<%=page%>">
	<input type="hidden" name="import_file" value="<%=import_file%>">

	<div class="tb_topWrap">
		<span class="btnWrap_left">
			[총 : <%= Total%>개[<%= Page%>/<%= PageCount%>]
		</span>
		<span class="btnWrap_right">
			<a href="upload_file.asp?import_file=<%=import_file%>" class="btn btnBlueLine"><i class="fa fa-pencil" aria-hidden="true"></i>등록하기</a>   
		</span>
	</div>
	<table border="0" cellpadding="0" cellspacing="0" class="tb_basic">
		<TR>
			<th>번호</th>
			<th>프로젝트명</th>
			<th>계약기간</th>
			<th>검수 형태</th>
			<th>검수 차수</th>
			<th>공급자</th>
			<th>공급받는 자</th>
			<th>파일</th>
			<th>등록일</th>
		</TR>
		<TR>
		<% 
			IF RS3.EOF  THEN  
		%>
		<tr>
			<td colspan="7">해당 자료가 없습니다.</td>
		</tr>
		<%
			ELSE

			j=vnum
			checkcount=0
				
			Do Until Rs3.Eof

			db_idx		= rs3("db_idx")
			pname		= rs3("pname")
			ptype		= rs3("proceduretype")
			pstep		= rs3("procedurestep")
			providee    = rs3("providee")
			provider    = rs3("provider")
			pperiod1	= rs3("period1")
			pperiod2	= rs3("period2")
			w_date		= left(rs3("w_date"),10)
			emp_id		= rs3("emp_id")
			filename1	= Trim(rs3("filename1"))
			user_name	= Trim(rs3("user_name"))

			IF len(pname)>30 THEN
				pname = left(pname,30) & "..."
			END IF				
						

			File_n = getImage(filename1)

			%>  
			<tr>
				<td><%=Num%></td>
				<td class="a_left"><a href="content_file.asp?db_idx=<%=db_idx%>&page=<%=page%>"><%=pname%></a></td>
				<td><%=pperiod1%> ~ <%=pperiod2%></td>
				<td><%=ptype%></td>
				<td><%=pstep%></td>
				<td><%=provider%></td>
				<td><%=providee%></td>
				<td><%If Trim(filename1)<>"" Then%><a href="/filedownurl/downloadcomm.asp?fileDir=<%=fileDir_contract_file_upload%>&filename=<%=filename1%>"><%=File_n%></a><%End If%></td>
				<td><%=w_date%></td>
			</tr>
			<%      
				j=j-1
				Num = Num - 1
				rs3.MoveNext     
				Loop'/si_project/data_file//KL_Smart_Library_purchase[0].zip

				rs3.close
				set rs3 = nothing
			%>
	</table>
	<%  
		END IF  
	%>
	</form>
	<!-- 페이징 -->
	<table border="0" cellpadding="0" cellspacing="0" class="tb_paging">     
		<tr>
			<td align="center">
				<%paging%>
			</td>
		</tr>
	</table>
	<!-- 검색 -->

	<form name='folder_search' action='view_dept.asp'>
	<input type="hidden" name="import_file" value="<%=import_file%>">
	<div class="searchWrap">
		<div class="brd_searchWrap">
			<select name="searcharea" class="form_basic">
			<option value="pname" <%if searcharea="pname" then%>selected<%end if%>>프로젝트명</option>
			<option value="ppmname" <%if searcharea="ppmname" then%>selected<%end if%>>프로젝트PM</option>
			<option value="pcontents" <%if searcharea="pcontents" then%>selected<%end if%>>내용</option>
			</select>
			<input type="text" name="searchword" size="20" class="form_basic">
			<input type="submit" value="&#xf002 검색" class="fa btn_t02 btnGray">
		</div>
	</div>

	</form>
	<form name="research" method="post" action="<%=pagego%>?page=<%=page%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="searchstring" value="<%=searchstring%>">
		<input type="hidden" name="page" value="<%=page%>">
		<input type="hidden" name="db_idx" value="<%=db_idx%>">
		<input type="hidden" name="pagego" value="<%=pagego%>">
		<input type="hidden" name="searcharea" value="<%=searcharea%>">
		<input type="hidden" name="searchword" value="<%=searchword%>">
	</form>
</div>
<%
db.close
Set db = Nothing
%>

