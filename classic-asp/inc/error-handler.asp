<!-- include virtual="/inc/functions.asp" -->
<!-- include virtual="/inc/mailer.asp" -->
<!-- include virtual="/templates/mail/mailer-types.asp" -->
<%
    ' Send email to support for tracking, cataloguing, and triage
    Dim mailer : Set mailer = New Mailer

    ' Create a dictionary of key/value pairs
    Dim dict : Set dict = Server.CreateObject("Scripting.Dictionary")
    dict.Add placeholder_errorNumber, Err.Number
    dict.Add placeholder_errorDescription, Err.Description

    ' Get the template and supply dictionary to replace template variables
    Dim body : body = GetTemplate("error", dict)

    ' Send email to support so this error is captured and can be catalogued for triage
    mailer.SendEmail(Application("SupportEmail"), "system@contact-example.com", "A System Error Has Occurred", body)
%>
<!DOCTYPE html>
<html>
<head>
    <title>Error - <%= Application("ApplicationName") %></title>
</head>
<body>
    <h1>Whoops</h1>
    <p>An error has occurred within the application</p>
    <p>You should never actually see this page. It's included as an example only.</p>
    <p>Error Number: <%= Err.Number %></p>
    <p>Error Description: <%= Err.Description %></p>
</body>
</html>