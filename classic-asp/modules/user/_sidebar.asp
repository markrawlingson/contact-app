<!-- #include virtual="/modules/user/user-repository.asp" -->
<%
    Dim userRepository_ : Set userRepository_ = New UserRepository
    userRepository_.GetUser(Session("UserId"))
    If Len(userRepository_.Id) Then
%>
<!-- User Details -->
<div class="flex items-center justify-center mb-6">
    <div class="flex flex-col items-center">
        <div class="w-16 h-16 bg-orange-500 rounded-full overflow-hidden">    
<% If userRepository_.HasProfilePicture Then %>
            <img src="<%= userRepository_.ProfilePicture %>" alt="User Avatar">
<% Else %>
            <div class="flex items-center justify-center w-full h-full text-white text-3xl font-bold">
                <%= Left(userRepository_.FullName, 1) %>
            </div>
<% End If %>
        </div>
        <div class="text-lg mt-2 font-semibold tracking-tight leading-none"><%= userRepository_.FullName %></div>
        <div class="text-sm font-light text-gray-500 text-secondary"><%= userRepository_.Email %></div>
    </div>
</div>
<% 
    End If
%>