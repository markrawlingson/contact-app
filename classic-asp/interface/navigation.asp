<%
    Set menu = Server.CreateObject("Scripting.Dictionary")
    menu.Add "Contacts", Array("/contacts", "fa fa-address-book")
%>

<!-- #include virtual="/modules/user/_sidebar.asp" -->
<ul>
<%
    ' Loop through menu dictionary and create menu items
    For Each key In menu.Keys
        Dim menuItem : menuItem = menu(key)
%>
    <a href="<%= menuItem(0) %>">
        <li class="px-4 py-2 bg-gray-200 hover:bg-orange-500 hover:text-white rounded">
            <i class="<%= menuItem(1) %> pr-2"></i>
            <%= key %>
        </li>
    </a>
<%
    Next
%>
</ul>