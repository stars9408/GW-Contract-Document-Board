<%
' 게시판 전용 함수

Function FrontPaging(PageGetVal)
	
	Dim PageCount,PageStart,PageLast,PrevLastPage
	Dim B10,B1,N1,N10
	Dim PrevPage,NextFirstPage,NextPage

	PageCount = int((Numrows-1)/PageSize) +1 '전체페이지수

	if  Page mod 10 <> 0  then
		PageStart=	Page-(Page mod 10) + 1
	else
		PageStart=	Page-9
	end if

	PageLast=PageStart + 9
	if PageLast >PageCount then PageLast=PageCount 
	PrevLastPage=PageStart-10

	B10=""
	B1="<img src='/img/btn/icon_prev.gif' width=65 height=12 border=0>"
	N1="<img src='/img/btn/icon_next.gif' width=65 height=12 border=0>"
	N10=""

	if  Cv(PageGetVal)=true then	PageGetVal=PageGetVal&"&"

	if int(PageStart) >1 then
		echo "<a href='?" & PageGetVal  & "Page="&PrevLastPage&"'>"&B10&"</a>"
	else
		echo ""&B10&""
	end if

	if Page >1  and Page <>0 then
		PrevPage=Page-1
		echo "<a href='?" & PageGetVal  & "Page="&PrevPage&"' >"&B1&"</a>"
	else
		echo ""&B1&""
	end if
		
	echo ""
	for j=PageStart to PageLast 
		if int(Page) <> int(j) then 
		    echo "<a href='?" &  PageGetVal &"Page=" & j &"' >"&j&"</a>"
	    elseif int(Page) = int(j) then
		   echo "<strong>"&j&"</strong>"
	    end if

		if j <> PageLast then
		echo " | "
		end if
	next 
	echo "&nbsp;"

	if int(Page) <> int(PageCount) and Numrows <>0 and PageCount <>1 and PageCount <>0 then
		NextPage=Page+1
		echo "<a href='?" &  PageGetVal &"Page="&NextPage&"' class=text>"&N1&"</a>"
	else
    	echo ""&N1&"</a>"
    end if

	NextFirstPage=PageLast+1

	if int(NextFirstPage) <= int(PageCount) then
		echo "<a class=text href='?" &  PageGetVal & "Page="&NextFirstPage&"'>"&N10&"</a>"
	else 
		echo ""&N10&""
	end if

end Function 

Function AdminPaging()
	
	Dim PageCount,PageStart,PageLast,PrevLastPage
	Dim PrevPage,NextFirstPage,NextPage

	PageCount = int((Numrows-1)/PageSize) +1 '전체페이지수

	if  Page mod 10 <> 0  then
		PageStart=	Page-(Page mod 10) + 1
	else
		PageStart=	Page-9
	end if

	PageLast=PageStart + 9
	if PageLast >PageCount then PageLast=PageCount 
	PrevLastPage=PageStart-10

	if int(PageStart) >1 then
		echo "<a href='?" & PageGetVal  & "&Page="&PrevLastPage&"' class=text>[이전10개]</a>"
	else
		echo "[이전10개]"
	end if

	if Page >1  and Page <>0 then
		PrevPage=Page-1
		echo "&nbsp;&nbsp;<a href='?" & PageGetVal  & "&Page="&PrevPage&"' class=text>[이전]</a>"
	else
		echo "&nbsp;&nbsp;[이전]</a>"
	end if

	
	for j=PageStart to PageLast 
		if int(Page) <> int(j) then 
		    echo "&nbsp;<a href='?" &  PageGetVal &"&Page=" & j &"' class=text>"&j&"</a>"
	    elseif int(Page) = int(j) then
		   echo "&nbsp;<strong>"&j&"</strong>"
	    end if
	next 

	if int(Page) <> int(PageCount) and Numrows <>0 and PageCount <>1 and PageCount <>0 then
		NextPage=Page+1
		echo "&nbsp;&nbsp;<a href='?" &  PageGetVal &"&Page="&NextPage&"' class=text>[다음]</a>&nbsp;&nbsp;"
	else
    	echo "&nbsp;&nbsp;[next]</a>&nbsp;&nbsp;"
    end if

	NextFirstPage=PageLast+1

	if int(NextFirstPage) <= int(PageCount) then
		echo "<a class=text href='?" &  PageGetVal & "&Page="&NextFirstPage&"'>[다음10개]</a>"
	else 
		echo "[다음10개]"
	end if
end Function 


Function GetNormalMovingUid_eBoard(uid,t_n,a)
	
	vi=" Uid > "&uid

	if cmode = "search" then
		
		if Region1 <>"" then
			vi=vi & " and  Region1='"&Region1&"'"
			if Region2 <>"" then	vi=vi & " and  Region2='"&Region2&"'"
		end if

		if field <> "" and  search <>""  then 
		   v1 = v1 & " and  " & field & " like '%" & search & "%'"
		else
			v1 = v1 & " and uid <0 "	
		end if
	end if

	'다음글
	nsql="select top 1 title,uid,writer,regdate,hit from tbl_Admineboard where  Uid > "&uid&"  "&v1&"  order by Uid"
	nuid = Con.Sr(nsql)
	
	if Con.allcount >0 then
		x=nuid(0,0) &"^" & nuid(1,0)
		r1=nuid(2,0)&"^" & nuid(3,0)&"^" & nuid(4,0)
	else
		x="^"
		r1="^^"
	end if

	bsql="select top 1 title,uid,writer,regdate,hit from tbl_Admineboard where Uid < "&uid&"  "&v1&" order by Uid desc"  
	buid= Con.Sr(bsql)
	if Con.allcount >0 then
		x1 =buid(0,0) &"^" & buid(1,0)
		r2 = buid(2,0)&"^" & buid(3,0)&"^" & buid(4,0)
	else
		x1="^" 
		r2="^^" 
	end if

	' 이전글 제목^이전글 uid^다음글 제목^다음글 uid

	GetNormalMovingUid_eBoard = x &"^" & x1&"_&&_" & r1 & "||" & r2

end Function 

Function GetNormalMovingUid(uid,t_n,a,ctype)
	
	dim ru(1),buidc,nuidc

	v1 = " and bn="& t_n 
	
	if Cv(Div)= true then
		   v1 = v1 & " and  div='"&Div&"'"
	end if
	
	if cmode = "search" then
		if field <> "" and  search <>""  then 
		   v1 = v1 & " and  " & field & " like '%" & search & "%'"
		else
			v1 = v1 & " and uid <0 "	
		end if
	end if

	'다음글
	nsql="select top 1 title,uid,writer,regdate,hit from tbl_Adminboard where  Uid > "&uid&"  "&v1&"  order by Uid"
	nuid = Con.Sr(nsql)
	
	if Con.allcount >0 then
		nuidc=nuid(1,0)
		x=nuid(0,0) &"^" & nuid(1,0)
		r1=nuid(2,0)&"^" & nuid(3,0)&"^" & nuid(4,0)
	else
		nuidc=0
		x="^"
		r1="^^"
	end if

	bsql="select top 1 title,uid,writer,regdate,hit from tbl_Adminboard where Uid < "&uid&"  "&v1&" order by Uid desc"  
	buid= Con.Sr(bsql)
	if Con.allcount >0 then
		buidc=buid(1,0)
		x1 =buid(0,0) &"^" & buid(1,0)
		r2 = buid(2,0)&"^" & buid(3,0)&"^" & buid(4,0)
	else
		buidc=0
		x1="^" 
		r2="^^" 
	end if

	if ctype="onlyuid" then
		ru(0)=buidc
		ru(1)=nuidc
		GetNormalMovingUid =ru
	else
		GetNormalMovingUid = x &"^" & x1&"_&&_" & r1 & "||" & r2
	end if


end Function 

Function GetNormalMovingUid2(uid,t_n,a)
	
	if cmode = "search" then
		if field <> "" and  search <>""  then 
		   v1 = " and  " & field & " like '%" & search & "%'"
		else
			v1 = " and num <0 "	
		end if
	end if

	'다음글
	nsql="select top 1 title,num from tbl_notice where  num > "&uid&"  "&v1&"  order by num"
	nuid = a.Sr(nsql)
	
	if a.allcount >0 then
		x=nuid(0,0) &"^" & nuid(1,0)
	else
		x="^"
	end if

	bsql="select top 1 title,num from tbl_notice where num < "&uid&"  "&v1&" order by num desc"  
	buid= a.Sr(bsql)

	if a.allcount >0 then
		x1=buid(0,0) &"^" & buid(1,0)
	else
		x1="^" 
	end if

	GetNormalMovingUid2 = x &"^" & x1

end Function

Function GetMovingUid(uid,t_n,a,tableval)
	
	xx = a.Sr("select egroup,idx from "&tableval&" where uid="&uid)
	egroup =  xx(0,0)
	idx = xx(1,0)
	
	v1 = " and t ="& t_n 
	
	if cmode = "search" then
		if field <> "" and  search <>""  then 
		   v1 = v1 & " and  " & field & " like '%" & search & "%'"
		else
			v1 = v1 & " and uid <0 "	
		end if
	end if

	'다음글
	nsql="select top 1 title,uid,name,regdate,hit from "&tableval&" where idx ="&idx&" and egroup < "&egroup&v1 & " order by idx ,egroup desc"
	
	nuid = a.Sr(nsql)
	
	if a.allcount >0 then
		x=nuid(0,0) &"^" & nuid(1,0)
		r1=nuid(2,0)&"^" & nuid(3,0)&"^" & nuid(4,0)
	else
		nsql="select top 1 title,uid,name,regdate,hit from "&tableval&" where  idx > "&idx&v1& " order by idx ,egroup desc" 
		xnuid = a.Sr(nsql)

		if a.allcount >0 then
			x=xnuid(0,0) &"^" & xnuid(1,0)
			r1=xnuid(2,0)&"^" & xnuid(3,0)&"^" & xnuid(4,0)
		else
			x="^"
			r1="^^"
		end if
	end if

	'이전글
	bsql="select top 1 title,uid,name,regdate,hit from "&tableval&" where idx ="&idx&" and egroup > "&egroup&" order by idx desc,egroup" 
	buid= a.Sr(bsql)
	if a.allcount >0 then
		x1=buid(0,0) &"^" & buid(1,0)
		r2 = buid(2,0)&"^" & buid(3,0)&"^" & buid(4,0)
	else
		bsql="select top 1 title,uid,name,regdate,hit from "&tableval&" where idx < "&idx&v1&" order by idx desc,egroup"   
		xbuid= a.Sr(bsql)
		if a.allcount >0 then
			x1 = xbuid(0,0) &"^" & xbuid(1,0)
			r2  = xbuid(2,0)&"^" & xbuid(3,0)&"^" & xbuid(4,0)
		else
			x1="^" 
			r2="^^"
		end if
	end if

	GetMovingUid = x &"^" & x1 &"_&&_" & r1 & "||" & r2

end Function



Function GetMovingUidNo(No)

	bx= No +1
	nx = No -1
	
	if No  =1 then
		nx=0
	elseif No = NumRows then
		bx=0
	end if
	
	pc = int((NumRows-1)/pagesize) +1 '전체페이지수
	pl=page_start + 9
	if pl >pc then pl=pc 

	bpa = page-1 
	npa = page +1 

	if page = 1 then bpa = 0
	if page = pc then npa =0 
	
	''''''''''''''''
	bpst=page_start-10
	npst=pl+1
	
	if page_start = 1 then	 bpst =0 
	if pl = page then npst =0
	
	bp = page
	np = page
	bps = page_start
	nps = page_start

	if clng(No) = (NumRows-(page-1)*pagesize) then
		bp = bpa
		if page = page_start  then bps = bpst
	end if

	if clng(No) = ((NumRows-(page*pagesize))+1)  then
		np = npa
		if page = pl  then nps = npst
	end if
	
	GetMovingUidNo = bp&"^"&bps&"^"&bx&"^"&np&"^"&nps&"^"&nx

end Function 


Function GetNormalMovingUidMemo(uid,Con,ctype,table,sql)
	
	dim ru(1),buidc,nuidc


	'다음글
	nsql="select top 1 title,mem_idx,fromid,toid,newreadnum from " & table & " where  "&sql&" mem_idx> "&uid&"  order by mem_idx"
	nuid = Con.Sr(nsql)
	
	if Con.allcount >0 then
		nuidc=nuid(1,0)
		x=nuid(0,0) &"^" & nuid(1,0)
		r1=nuid(2,0)&"^" & nuid(3,0)&"^" & nuid(4,0)
	else
		nuidc=0
		x="^"
		r1="^^"
	end if

	bsql="select top 1 title,mem_idx,fromid,toid,newreadnum from " & table & " where  "&sql&" mem_idx < "&uid&" order by mem_idx desc"  
	buid= Con.Sr(bsql)
	if Con.allcount >0 then
		buidc=buid(1,0)
		x1 =buid(0,0) &"^" & buid(1,0)
		r2 = buid(2,0)&"^" & buid(3,0)&"^" & buid(4,0)
	else
		buidc=0
		x1="^" 
		r2="^^" 
	end if

	if ctype="onlyuid" then
		ru(0)=buidc
		ru(1)=nuidc
		GetNormalMovingUid =ru
	else
		GetNormalMovingUidMemo = x &"^" & x1&"_&&_" & r1 & "||" & r2
	end if


end Function 



Function paging()
'맨앞으로 
	If page <> 1 Then 
		Response.Write "<a href='JavaScript:re_search(1)'>[처음으로]</a>&nbsp;" 
	Else
		Response.Write "[처음으로]&nbsp;"
	End If

		blockpage=Int((page-1)/10)*10+1 


	If blockpage = 1 Then 
		Response.Write "[이전10]&nbsp;&nbsp;" 
	Else 
	Response.Write "<a href='JavaScript:re_search("& blockpage-10 &")'>[이전10]</a>&nbsp;&nbsp;" 
	End If 
'페이지 	숫자
i = 1 
	Do Until i > 10 Or blockpage > pagecount
		If blockpage=int(page) Then 
			response.write "<B><font class='pagecall' color=#330099>["&blockpage&"]</font></B>&nbsp;&nbsp;"
	
		Else
			Response.Write "<a href='JavaScript:re_search("& blockpage &")'>["&blockpage&"]</a>&nbsp;&nbsp;"
		End If 

blockpage=blockpage+1 
i=i+1 
	Loop   

	If blockpage > PageCount Then 
		Response.Write "&nbsp;[다음10]&nbsp;"

	Else 
		Response.Write "<a href='JavaScript:re_search("& blockpage &")'>&nbsp;[다음10]</a>&nbsp;" 
	End If'

'맨뒤로
	If Cint(page) < Cint(PageCount) Then
		Response.Write "<a href='JavaScript:re_search("& PageCount &")'>[끝으로]</a>&nbsp;" 
	
	Else
		Response.Write "[끝으로]&nbsp;"
	End If

End Function


Function getImage(file_name)

   if file_name <>"" then
       select case right(file_name, 3)

		case "txt"				
				File_n = "<img src=/image/file_image/txt.gif border='0' width=16 height=16>"
		case "doc"
				File_n = "<img src=/image/file_image/doc.gif border='0' width=16 height=16>"
		case "ocx"
				File_n = "<img src=/image/file_image/doc.gif border='0' width=16 height=16>"
		case "xls"
				File_n = "<img src=/image/file_image/xls.gif border='0' width=16 height=16>"
		case "hwp"
				File_n = "<img src=/image/file_image/hwp.gif border='0' width=16 height=16>"
		case "zip"
				File_n = "<img src=/image/file_image/zip.gif border='0'  width=16 height=16>"
		case "exe"
				File_n = "<img src=/image/file_image/exe.gif border='0'  width=16 height=14>"				
		case "bmp"
				File_n = "<img src=/image/file_image/bmp.gif border='0' width=16 height=16>"
		case "gif"
				File_n = "<img src=/image/file_image/gif.gif border='0' width=16 height=16>"
		case "jpg"
				File_n = "<img src=/image/file_image/jpg.gif border='0' width=16 height=16>"
		case "htm"
				File_n = "<img src=/image/file_image/htm.gif border='0' width=16 height=16>"
		case "tml"
				File_n = "<img src=/image/file_image/html.gif border='0' width=15 height=15>"				
		case "psd"
				File_n = "<img src=/image/file_image/psd.gif border='0' width=16 height=16>"
		case else	
				File_n = "<img src=/image/file_image/txt.gif border='0' width=16 height=16>"
	end select
   end if

getImage = File_n

End Function



Private Function GetString(str, strlen)
  dim rValue
  dim nLength
  dim f, tmpStr, tmpLen
  
  nLength = 0.00
  rValue = ""

  for f = 1 to len(str)
   tmpStr = MID(str,f,1)
   tmpLen = ASC(tmpStr)
   if  (tmpLen < 0) then
    ' 한글
    nLength = nLength + 1.8        '한글일때 길이값 설정
    rValue = rValue & tmpStr
   elseif (tmpLen >= 97 and tmpLen <= 122) then
    ' 영문 소문자
    nLength = nLength + 0.75       '영문소문자 길이값 설정
    rValue = rValue & tmpStr
   elseif (tmpLen >= 65 and tmpLen <= 90) then
    ' 영문 대문자
    nLength = nLength + 1           ' 영문대문자 길이값 설정
    rValue = rValue & tmpStr
   else
    ' 그외 키값
    nLength = nLength + 0.6         '특수문자 기호값...
    rValue = rValue & tmpStr   
 
   end if

   If (nLength > strlen) then
    rValue = rValue & ".."
    exit for
   end if
  next

  getString = rValue

End Function



%>
