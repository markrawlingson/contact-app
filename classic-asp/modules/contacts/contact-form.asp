<!-- #include virtual="/inc/session/check-session.asp" -->
<!-- #include virtual="/inc/functions.asp" -->
<!-- #include virtual="/inc/database.asp" -->
<!-- #include virtual="/inc/button.asp" -->
<!-- #include virtual="/modules/contacts/data/contact-repository.asp" -->
<%
    ' Get contact id from querystring and sanitize it
    Dim contactId : contactId = Sanitize(Request.QueryString("id"))
    Dim contact : Set contact = New ContactRecord

    Dim context : context = "Add"

    If Len(contactId) Then
        Dim contactRepository_ : Set contactRepository_ = New ContactRepository
        Set contact = contactRepository_.GetContactById(contactId)
        context = "Edit"
    End If
%>
<div class="modal">
    <div class="pt-2 tracking-tight font-semibold text-2xl text-center">
        <%= context %> a Contact
    </div>
    <div class="p-8">
        <form id="contact-form" class="w-full max-w-md" method="post">
            <input type="hidden" id="contact-id" value="<%= contactId %>" />
            <div class="mb-4">
                <label for="first-name" class="block uppercase tracking-wide leading-none text-gray-700 text-xs font-bold mb-2">First Name</label>
                <input type="text" id="first-name" name="first-name" value="<%= contact.FirstName %>"
                    class="appearance-none block w-full bg-gray-50 text-gray-700 border rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white"
                    placeholder="" maxlength="32">
            </div>
            <div class="mb-4">
                <label for="last-name" class="block uppercase tracking-wide leading-none text-gray-700 text-xs font-bold mb-2">Last Name</label>
                <input type="text" id="last-name" name="last-name" value="<%= contact.LastName %>" class="appearance-none block w-full bg-gray-50 text-gray-700 border rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white" placeholder="" maxlength="32">
            </div>
            <div class="mb-4">
                <label for="email" class="block uppercase tracking-wide leading-none text-gray-700 text-xs font-bold mb-2">Email Address</label>
                <input type="email" id="email" name="email" value="<%= contact.Email %>" class="appearance-none block w-full bg-gray-50 text-gray-700 border rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white" placeholder="" maxlength="32">
            </div>
            <div class="mb-6">
                <label for="phone" class="block uppercase tracking-wide leading-none text-gray-700 text-xs font-bold mb-2">Phone Number</label>
                <input type="tel" id="phone" name="phone" value="<%= contact.Phone %>" class="appearance-none block w-full bg-gray-50 text-gray-700 border rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white" placeholder="" maxlength="15">
            </div>
            <div class="flex items-center justify-center">
                <button class="bg-orange-500 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"><%= context %> Contact</button>
            </div>
        </form>
    </div>
</div>