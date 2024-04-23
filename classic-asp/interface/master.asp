<%
    ' Author            : Mark Rawlingson
    ' Date              : February 23rd, 2024
    ' Purpose           : The purpose of this file is to centralize common data index pages within a single, reuseable structure
    ' Description       : This file relies upon several external dependencies which must be defined outside of the include:
    '                       - styles: An array of stylesheets to be included within the page (optional)
    '                       - title: The title of the page
    '                       - subtitle: The subtitle of the page (optional)
    '                       - content: The content to be displayed within the main content area - this should be a relative path to the content file
    '                       - buttons: An array of buttons to be displayed within the header (optional)
    '                       - javascript: An array of javascript files to be included within the page (optional)
%>
<!doctype html>
<html>
<head>
  <title><%= Application("ApplicationName") %> - <%= title %></title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<%
    ' Include any additional stylesheets
    If IsArray(styles) Then
        For Each stylesheet in styles
%>
    <link rel="stylesheet" href="<%= stylesheet %>">
<%
        Next
    End If

    Set styles = Nothing
%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
</head>
<body class="flex h-screen">
    
    <div class="flex flex-col md:flex-row w-full">
        
        <!-- Navigation -->
        <div class="relative md:w-64">
            <div class="fixed inset-y-0 left-0 bg-gray-50 h-full w-full md:w-64 p-4 border-r">
                <!-- #include virtual="/interface/navigation.asp" --> 
            </div>
        </div>

        <!-- Main content -->
        <div class="relative flex-1 w-full m:h-32">
            <div class="sticky top-0 z-10 bg-white border-b p-8 w-full flex justify-between items-center">
                <div>
                    <div class="text-4xl font-extrabold tracking-tight leading-none"><%= title %></div>
                    <% If Len(subtitle) Then %>
                        <div class="ml-0.5 font-light text-gray-500 text-secondary"><%= subtitle %></div>
                    <% End If %>
                </div>
                
                <% If isSearchEnabled Then %>
                <input type="text" id="search" name="search" class="w-64 bg-gray-50 text-gray-700 border rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white" placeholder="Search" />
                <% End If %>

                <% If IsArray(buttons) Then %>
                    <div class="mt-4">
                    <% 
                        For Each button_ In buttons
                            Response.Write(button_.GetButton())
                        Next
                    %>
                    </div>
                <% End If %>
            </div>

            <% Server.Execute(content) %>
            
        </div>

    </div>
    
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://kit.fontawesome.com/737af9599b.js" crossorigin="anonymous"></script>
    <script
        src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="/js/global.js"></script>
<%
    ' Include any additional javascript files
    If IsArray(javascript) Then
        For Each script in javascript
%>
    <script type="text/javascript" src="<%= script %>"></script>
<%
        Next
    End If

    Set javascript = Nothing
%>
</body>
</html>
<% db.Disconnect() %>