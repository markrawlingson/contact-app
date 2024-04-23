<!-- #include virtual="/inc/functions.asp" -->
<!-- #include virtual="/inc/database.asp" -->
<!-- #include virtual="/modules/contacts/data/contact-repository.asp" -->
<%
    ' Create a new ContactRecord object
    Dim contact : Set contact = New ContactRecord

    Dim contactId : contactId = Sanitize(Request("id"))

    ' If there's no id, we are creating a new contact
    ' Create a new GUID
    If Len(contactId) = 0 Then
        contactId = GetGuid()
        ' Set the context
        Dim context : context = "create"
    End If

    ' Initialize the ContactRecord object with the form data
    contact.Init contactId, Sanitize(Request("firstName")), Sanitize(Request("lastName")), Sanitize(Request("email")), Sanitize(Request("phone")), "" 

    ' Data integrity check
    ' This is just a fail safe, we rely on frontend to check for errors to notify the user
    If contact.Errors.Count > 0 Then
        Response.Write(contact.Errors.Item(1))
        ' Bugout
        Response.End()
    End If

    ' Create an instance of ContactRepository
    Dim contactRepository_ : Set contactRepository_ = New ContactRepository
    
    If context = "create" Then
        ' Add the contact to the database
        contactRepository_.CreateContact(contact)
    Else
        ' Update the contact in the database
        contactRepository_.UpdateContact(contact)
    End If

%>