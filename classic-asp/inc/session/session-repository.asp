<%
    '--------------------------------------------------------------
    ' Class: SessionRepository
    '
    ' Description: Responsible for retrieving the session data from the persistence layer
    '              to restore the user's session
    '
    ' Example usage:
    '   Dim sessionRepository_ : Set sessionRepository_ = New SessionRepository
    '   Dim sessionId : sessionId = Sanitize(Request.QueryString("sessionId"))
    '   sessionRepository_.RestoreSession(sessionId)
    '--------------------------------------------------------------
    Class SessionRepository

        ' Queries the database for the session data based on the session id
        Private Function GetSession(sessionId)
            Dim sql : sql = "SELECT Id, Value, Expires FROM Sessions WHERE Id = ?"
            Set GetSession = db.Query(sql, Array(sessionId))
        End Function

        ' Restores the user's session by decoding the session data and storing it in session variables
        Public Function RestoreSession(sessionId)
            Dim rsSession : Set rsSession = GetSession(sessionId)
            
            Dim returnUrl : returnUrl = "/Identity/Account/Login"

            If rsSession.EOF Then
                Response.Redirect(returnUrl)
            Else
                Dim sessionData : sessionData = rsSession("Value")
                Dim sessionExpiration : sessionExpiration = rsSession("Expires")
                
                ' Bug out if the session has expired
                If sessionExpiration < Now Then
                    Response.Redirect(returnUrl)
                End If

                Dim json : Set json = New aspJSON
                json.loadJSON(sessionData)

                Session("UserId") = json.data("UserId")

            End If

            db.CloseRecordSet(rsSession)
        End Function
    End Class
%>