<!-- #include file="_variables.asp" -->
<%
IF  instr(Request.servervariables("HTTP_REFERER"), Request.servervariables("SERVER_NAME")) > 1 THEN
   filePath = Server.Mappath(upload_folder)
   Set Upload = Server.CreateObject("Persits.Upload.1")
   Upload.SetMaxSize (10*1024*1024), True
   Upload.Save

   Set File = Upload.Files("file1")
   If Not File Is Nothing Then
      ' Obtain file name
      Filename = file.Filename
      isFileOK = false
      For i = 0 to UBound(supportedFileTypes)
         If lCase(supportedFileTypes(i)) = lCase(file.Ext) Then
            isFileOK = true
            Exit For
         End If
      Next

      If NOT isFileOK THEN Response.Write "This file type does not supported." : response.end
      If Upload.FileExists(filePath  &"\"& Filename ) Then
         Response.Write "File with this name already exists."
      Else
         ' otherwise save file
         File.SaveAs filePath &"\"& File.Filename
         Response.Write "File Uploaded."
      End If
   Else ' file not selected
      Response.Write "File not selected."
   End If


   If Err.Number = 8 Then
      Response.Write "Your file is too large. Please try again."
   Else
      If Err <> 0 Then
         Response.Write "An error occurred: " & Err.Description
      End If
   End If
ELSE
Response.write "Invalid Request"
END IF
%>
