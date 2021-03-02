<%


Function getDateNew(date_now)

	if instr(date_now, "오후") then	
		date_now = replace(date_now, "오후", "")
		date_now = date_now & " pm"
	else
		date_now = replace(date_now, "오전", "") 
	end if

getDateNew = date_now

End Function



Function getDateNew_ampm(date_now)

	if instr(date_now, "오후") then	
		date_now = replace(date_now, "오후", "")
		date_now = date_now & " pm"
	else
		date_now = replace(date_now, "오전", "") 
		date_now = date_now & " am"
	end if

getDateNew_ampm = date_now

End Function


Function getFileNameIcon(file_name)

   if file_name <>"" then
       select case right(file_name, 3)
		case "txt"				
				File_n = "<img src=/image/file_image/txt.gif border='0' width=16 height=16>"
		case "doc"
				File_n = "<img src=/image/file_image/doc.gif border='0' width=16 height=16>"
		case "ocs"
				File_n = "<img src=/image/file_image/doc.gif border='0' width=16 height=16>"
		case "xls"
				File_n = "<img src=/image/file_image/xls.gif border='0' width=16 height=16>"
		case "lsx"
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

getFileNameIcon = File_n

End Function


Function getDateExperience(sDate, eDate)

	months = DateDiff("m", sDate, eDate)

	days = DateDiff("d", sDate, eDate)

	For i = 0 To months - 1

		nDate = DateAdd("m", i, sDate)

		days = days - Day(DateSerial(year(nDate), month(nDate) + 1, 1 - 1))

	Next



	years = 0

	Do While months > 12

		months = months - 12

		years = years + 1

	loop
	
	'Response.write days

	'getDateExperience = years & "년 " & months & "개월 " & days & "일"

	If days < 0 Then
		getDateExperience = CInt(months) - 1
	Else
		getDateExperience = CInt(months)

	End If 

End Function 






%>
