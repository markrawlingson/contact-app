<!-- #include virtual="/inc/aspJSON1.17.asp" -->
<!-- #include virtual="/inc/functions.asp" -->
<!-- #include virtual="/inc/database.asp" -->
<!-- #include virtual="/modules/contacts/data/contact-repository.asp" -->
<%
    Dim contactRepository_ : Set contactRepository_ = New ContactRepository
    Dim searchTerm : searchTerm = Sanitize(Request.QueryString("searchTerm"))
    Dim rsContacts : Set rsContacts = contactRepository_.GetContacts(searchTerm, "FirstName", "ASC")

    ' Variable to keep track of the current section
    Dim currentSection : currentSection = ""
%>
<div id="contacts" class="h-full">
    <!-- No Records -->
    <% If (contactRepository_.CountRecords() > 0 Or Len(searchTerm) > 0) And rsContacts.EOF Then %>
    <div class="flex flex-col items-center justify-center h-full p-8">

        <div class="font-semibold pt-2 text-center">
            <div class="text-2xl font-extrabold tracking-tight leading-none">No contacts found</div>
            <div class="text-gray-500 dark:text-gray-400 text-sm">Try checking your search term for typos or search with different criteria.</div>
        </div>

    </div>
    <% End If %>
    <!--/ No Records -->
<%
    ' Loop through the recordset
    Do While Not rsContacts.EOF
        ' Get the first letter of the first name
        Dim firstName : firstName = UCase(Left(rsContacts("FirstName"), 1))

        ' Check if the current contact belongs to a new section and begin a new section if so
        If firstName <> currentSection Then
%>
    <div class="sticky top-0 -mt-px px-10 py-1 md:px-10 border-t border-b font-medium text-gray-600 uppercase bg-gray-50 dark:bg-gray-900">
        <h2><%= firstName %></h2>
    </div>
<%
            ' Update the current section
            currentSection = firstName
        End If
%>
        <div class="contact flex items-center px-6 py-4 md:px-8 cursor-pointer border-b hover:bg-gray-100 dark:hover:bg-hover" data-id="<%= rsContacts("id") %>">
            
            <!-- Blank Avatar Placeholder -->
            <div class="flex flex-0 items-center justify-center w-10 h-10 rounded-full overflow-hidden">
                <div class="w-16 h-16 bg-gray-200 rounded-full overflow-hidden">    
                    <div class="flex items-center justify-center w-full h-full text-white text-xl font-bold">
                        <i class="fa-solid fa-user"></i>
                    </div>
                </div>
            </div>

            <div class="min-w-0 ml-4">
                <div class="leading-5 font-medium truncate text-gray-600"><span class="firstName"><%= rsContacts("FirstName") %></span> <span class="lastName"><%= rsContacts("LastName") %></span></div>
                <div class="leading-5 truncate text-gray-400 text-sm email"><%= rsContacts("Email") %></div>
                <div class="leading-5 truncate text-gray-400 text-sm hidden phone"><%= rsContacts("Phone") %></div>
            </div>

        </div>
<%
        rsContacts.MoveNext
    Loop
%>
</div>
<%
    ' Clean up
    db.CloseRecordSet(rsContacts)
%>