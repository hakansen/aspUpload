
<%
Response.CharSet = "UTF-8"
Response.CodePage = 65001
on error resume next

function IsObjInstalled(strClassString)
         IsObjInstalled = false : Err = 0
	      Set testObj = Server.CreateObject(strClassString)
		      if (0 = Err) then IsObjInstalled = true else IsObjInstalled = false
	      Set testObj = nothing
end function


Components = Array("scripting.filesystemobject","Persits.Upload.1")

IsCompOK = true
Compmsg = "Component Checker"
for i = 0 to Ubound(Components)
   IF NOT IsObjInstalled(Components(i)) THEN
      Compmsg = Compmsg &"<br>"& Components(i) &" does not installed or working properly."
      IsCompOK = false
   End IF
next
IF NOT IsCompOK THEN response.write Compmsg : response.end


%>
<!-- #include file="_variables.asp" -->
<!-- #include file="classes/aspJSON1.19.asp" -->
<!-- #include file="classes/fileServices.asp" -->
<%

Set fileService = New fileServices
%>
