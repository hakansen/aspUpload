<%
Class fileServices

     Private pvObjUploadRequest
     Public fso,IsObjInstalled
     Private Sub Class_Initialize
          Dim RequestBin, Boundary, Value
          Dim lngPosBegin, lngPosEnd, lngBoundaryPos
          Dim lngPos, lngPosFile, lngPosBound
          Dim strName, strFileName, strContentType
          Dim objUploadControl

          Set pvObjUploadRequest = Server.CreateObject("Scripting.Dictionary")
          set fso = server.createObject("scripting.filesystemobject")

          RequestBin = Request.BinaryRead(Request.TotalBytes)

          lngPosBegin = 1
          lngPosEnd = InStrB(lngPosBegin, RequestBin, GetByteString(Chr(13)))
          Boundary = MidB(RequestBin, lngPosBegin, lngPosEnd - lngPosBegin)
          lngBoundaryPos = InstrB(1, RequestBin, Boundary)

          Do Until (lngBoundaryPos = InstrB(RequestBin, Boundary & getByteString("--")))

               Set objUploadControl = CreateObject("Scripting.Dictionary")

               lngPos = InstrB(lngBoundaryPos, RequestBin, GetByteString("Content-Disposition"))
               lngPos = InstrB(lngPos, RequestBin, GetByteString("name="))
               lngPosBegin = lngPos + 6
               lngPosEnd = InstrB(lngPosBegin, RequestBin, GetByteString(Chr(34)))
               strName = LCase(GetString(MidB(RequestBin, lngPosBegin, lngPosEnd - lngPosBegin)))
               lngPosFile = InstrB(lngBoundaryPos, RequestBin, GetByteString("filename="))
               lngPosBound = InstrB(lngPosEnd, RequestBin, Boundary)

               If lngPosFile <> 0 AND lngPosFile < lngPosBound Then

                    lngPosBegin = lngPosFile + 10
                    lngPosEnd = InStrB(lngPosBegin, RequestBin, GetByteString(Chr(34)))
                    strFileName = GetString(MidB(RequestBin, lngPosBegin, lngPosEnd - lngPosBegin))

                    objUploadControl.Add "FileName" , strFileName
                    lngPos = InStrB(lngPosEnd, RequestBin, GetByteString("Content-Type:"))
                    lngPosBegin = lngPos + 14
                    lngPosEnd = InStrB(lngPosBegin, RequestBin, GetByteString(Chr(13)))

                    strContentType = GetString(MidB(RequestBin, lngPosBegin, lngPosEnd - lngPosBegin))
                    objUploadControl.Add "ContentType" , strContentType

                    lngPosBegin = lngPosEnd + 4
                    lngPosEnd = InstrB(lngPosBegin, RequestBin, Boundary) - 2
                    Value = MidB(RequestBin, lngPosBegin, lngPosEnd - lngPosBegin)
               Else

                    lngPos = InstrB(lngPos, RequestBin, GetByteString(Chr(13)))
                    lngPosBegin = lngPos + 4
                    lngPosEnd = InStrB(lngPosBegin, RequestBin, Boundary) - 2
                    Value = GetString(MidB(RequestBin, lngPosBegin, lngPosEnd - lngPosBegin))
               End If

               objUploadControl.Add "Value" , Value

               pvObjUploadRequest.Add strName, objUploadControl

               lngBoundaryPos = InStrB(lngBoundaryPos + LenB(Boundary), RequestBin, Boundary)
          Loop
     End Sub

     Private Sub Class_TerMINate
          Dim objDictionary

          For Each objDictionary In pvObjUploadRequest.Items
               objDictionary.RemoveAll
               Set objDictionary = Nothing
          Next
          pvObjUploadRequest.RemoveAll
          Set pvObjUploadRequest = Nothing
     End Sub

     Private Function GetByteString(strString)
          Dim Char
          Dim i

          For i = 1 To Len(strString)
                Char = Mid(strString, i , 1)
               GetByteString = GetByteString & ChrB(AscB(Char))
          Next
     End Function

     Private Function GetString(strBin)
          Dim intCount

          GetString = ""

          For intCount = 1 To LenB(strBin)
               GetString = GetString & Chr(AscB(MidB(strBin, intCount, 1)))
          Next
     End Function

     Public Function Value(Name)
          Name = LCase(Name)
          If pvObjUploadRequest.Exists(Name) Then
               Value = pvObjUploadRequest.Item(Name).Item("Value")
          Else
               Value = Empty
          End If
     End Function

     Public Function ContentType(Name)
          Name = LCase(Name)
          If pvObjUploadRequest.Exists(Name) Then
               If pvObjUploadRequest.Item(Name).Exists("ContentType") Then
                    ContentType = pvObjUploadRequest.Item(Name).Item("ContentType")
               Else
                    ContentType = Empty
               End If
          Else
               ContentType = Empty
          End If
     End Function

     Public Function FileNamePath(Name)
          Name = LCase(Name)
          If pvObjUploadRequest.Exists(Name) Then
               If pvObjUploadRequest.Item(Name).Exists("FileName") Then
                    FileNamePath = pvObjUploadRequest.Item(Name).Item("FileName")
               Else
                    FileNamePath = Empty
               End If
          Else
               FileNamePath = Empty
          End If
     End Function

     Public Function FileName(Name)
          Dim strFileName

          Name = LCase(Name)
          If pvObjUploadRequest.Exists(Name) Then
               If pvObjUploadRequest.Item(Name).Exists("FileName") Then
                    strFileName = pvObjUploadRequest.Item(Name).Item("FileName")
                    FileName = Right(strFileName, Len(strFileName) - InStrRev(strFileName, "\"))
                    'FileName = strFileName
               Else
                    FileName = Empty
               End If
          Else
               FileName = Empty
          End If
     End Function

End Class
%>
