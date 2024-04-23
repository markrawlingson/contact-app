<!-- #include virtual="/inc/functions.asp" -->
<!-- #include virtual="/inc/database.asp" -->
<!-- #include virtual="/inc/aspJSON1.17.asp" -->
<!-- #include virtual="/inc/session/session-repository.asp" -->
<%
    ' Bug out if the request is coming from outside the local machine
    If (Request.ServerVariables("LOCAL_ADDR") <> Request.ServerVariables("REMOTE_ADDR")) Then
        Response.Redirect("/error/403")
    End If

    Dim sessionId : sessionId = Sanitize(Request.QueryString("sessionId"))
    
    ' Instantiate the session repository
    Dim sessionRepository_ : Set sessionRepository_ = New SessionRepository

    ' Restore the session
    sessionRepository_.RestoreSession(sessionId)

    ' Redirect to the contact application
    Response.Redirect(Application("ApplicationRoot"))
%>