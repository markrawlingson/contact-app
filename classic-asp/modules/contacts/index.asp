<!-- #include virtual="/inc/session/check-session.asp" -->
<!-- #include virtual="/inc/functions.asp" -->
<!-- #include virtual="/inc/database.asp" -->
<!-- #include virtual="/inc/button.asp" -->
<%
    title = "Contacts"
    subtitle = "Friends & Connections"

    ' Define breadcrumbs
    Set breadcrumbs = Server.CreateObject("Scripting.Dictionary")
    breadcrumbs.Add "Contacts", "/contacts"

    styles = Array("/modules/contacts/css/contacts.css")

    javascript = Array("/modules/contacts/js/contacts.js")

    isSearchEnabled = True

    buttons = Array( _
        (New Button)("Add Contact", "/contacts/new", "", "bg-orange-500 hover:bg-orange-700 text-white font-semibold py-2 px-4 rounded", "button", true) _ 
    )

    content = "/modules/contacts/views/index.asp"
%>
<!-- #include virtual="/interface/master.asp" -->