<!--#include virtual="/inc/mailer/mail-template-types.asp" -->
<!--#include virtual="/inc/mailer/placeholder-types.asp" -->
<%
    '--------------------------------------------------------------
    ' Class: Mailer
    '
    ' Description: Encapsulates email interactions
    '
    ' Example usage:
    '   Dim mailer : Set mailer = New Mailer
    '   mailer.Send("mark@rawlingson.ca", "hello@domain.com", "Hello World", "Some interesting body")
    '--------------------------------------------------------------
    Class Mailer
        Private apiKey
        Private apiUrl
        
        Private Sub Class_Initialize()
            apiKey = "SENDGRID_API_KEY" ' Secret obviously not committed to repo
            apiUrl = "https://api.sendgrid.com/v3/mail/send"
        End Sub
        
        Public Function Send(to, from, subject, body)
            Dim xmlhttp
            Set xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
            
            xmlhttp.Open "POST", apiUrl, False
            xmlhttp.setRequestHeader "Authorization", "Bearer " & apiKey
            xmlhttp.setRequestHeader "Content-Type", "application/json"
            
            Dim payload
            payload = "{""personalizations"":[{""to"":[{""email"":""" & toEmail & """}]},""from"":{""email"":""" & fromEmail & """},""subject"":""" & subject & """,""content"":[{""type"":""text/plain"",""value"":""" & body & """}]}"
            
            xmlhttp.send payload
            
            If xmlhttp.Status = 202 Then
                SendEmail = True ' Email sent successfully
            Else
                SendEmail = False ' Email sending failed
            End If
            
            Set xmlhttp = Nothing
        End Function
    End Class
%>