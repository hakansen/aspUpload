<!-- #include file="required.asp" -->
<%
Server.ScriptTimeout = 60 * 20
Dim objConn, strFile
Dim intCampaignRecipientID

strFile = Request.QueryString("file")

If strFile <> "" Then

    Response.Buffer = False
    Dim objStream
    Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Type = 1 'adTypeBinary
    objStream.Open
    objStream.LoadFromFile(Server.Mappath(upload_folder) & "\" & strFile)
    Response.ContentType = "application/x-unknown"
    Response.Addheader "Content-Disposition", "attachment; filename=" & strFile
    Response.BinaryWrite objStream.Read
    objStream.Close
    Set objStream = Nothing

End If
%>
