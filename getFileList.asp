<!--#include file="required.asp" -->
<%

response.clear : response.ContentType = "application/json"
    set objFolder = fileService.fso.GetFolder(Server.Mappath(upload_folder)&"\")
    set oJSON = New aspJSON
    oJSON.data.add "success", true
    oJSON.data.Add "files", oJSON.Collection()
        For Each File In objFolder.Files
            set fJSON = oJSON.addToCollection(oJSON.data("files"))
            fJSON.add "Type" , ""& File.Type &""
            fJSON.add "Name" , ""& File.Name &""
            fJSON.add "Ext" , ""& fileService.fso.GetExtensionName(File.ShortPath) &""
            fJSON.add "Size" , ""& File.Size &""
            fJSON.add "DateCreated" , ""& File.DateCreated &""
            ''fJSON.add "ref" , ""& request.servervariables("HTTP_REFERER") &""
            ''fJSON.add "server" , ""& request.servervariables("SERVER_NAME") &""
        Next


    Response.Write oJSON.JSONoutput()
%>
