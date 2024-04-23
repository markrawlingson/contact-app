<!-- #include virtual="/inc/functions.asp" -->
<!-- #include virtual="/inc/database.asp" -->
<!-- #include virtual="/modules/contacts/data/contact-repository.asp" -->

<%
    Dim contactId : contactId = Sanitize(Request("id"))
    
    ' Check if contact id is provided in the query string
    If Len(contactId) Then

        ' Create an instance of ContactRepository
        Dim contactRepository_ : Set contactRepository_ = New ContactRepository
        
        ' Delete the contact with the given id
        contactRepository_.DeleteContact(contactId)

        Response.Write(1)
        Set contactRepository_ = Nothing
    Else
        ' Raise an error here so the calling script knows something went wrong
        Err.Raise 2, "Failed to delete contact, no contact id found"
    End If
%>