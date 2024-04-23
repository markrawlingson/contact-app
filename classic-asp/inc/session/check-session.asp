<%
    If Len(Session("UserId")) = 0 Then
        Response.Redirect("/Identity/Account/Login")
    End If
%>