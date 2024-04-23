<%

    ' Yes, this file is in alphabetical order. It's easier to find things that way.

    '--------------------------------------------------------------
    ' Sub: ArrayAdd
    '
    ' Description: Redimensions an array and adds the given item to it
    '
    ' Parameters:
    '   array   - The array to add the item to
    '   item    - The item to add to the array
    '
    '
    ' Example usage:
    '   ArrayAdd myArray, "Tomatoes"
    '--------------------------------------------------------------
    Sub ArrayAdd(array, item)
        ReDim Preserve array(UBound(array) + 1)
        array(UBound(array)) = item
    End Sub

    '--------------------------------------------------------------
    ' Function: GetGuid
    '
    ' Description: Generates a new GUID
    '
    ' Parameters:
    '   None
    '
    ' Returns:
    '   String containing a GUID
    '
    ' Example usage:
    '   GetGuid()
    '--------------------------------------------------------------
    Function GetGuid()
        Dim TypeLib : Set TypeLib = Server.CreateObject("Scriptlet.TypeLib")
        GetGuid = Left(TypeLib.Guid, Len(TypeLib.Guid) - 2) ' Remove curly braces
        Set TypeLib = Nothing
    End Function

    '--------------------------------------------------------------
    ' Function: GetTemplate
    '
    ' Description: Grabs the contents of an html template file
    '
    ' Parameters:
    '   template   - The path of the file to get the contents for
    '   dictionary - A dictionary containing template variables and values
    '                to replace them with
    '
    ' Returns:
    '   String containing the html contents of the file, 
    '   or empty string if the file doesn't exist
    '
    ' Example usage:
    '   Dim template
    '   template = GetTemplate(mailTemplate_error)
    '--------------------------------------------------------------
    Function GetTemplate(template, dictionary)
        Dim fs, templatePath, templateContents
        
        ' Create a FileSystemObject
        Set fs = Server.CreateObject("Scripting.FileSystemObject")
        
        ' Construct the path to the template file
        templatePath = Server.MapPath(template)
        
        ' Check if the template file exists
        If fs.FileExists(templatePath) Then
            ' Open the template file for reading
            Dim file, fileStream
            Set fileStream = fs.OpenTextFile(templatePath)
            
            ' Read the contents of the template file
            templateContents = fileStream.ReadAll
            
            ' Close the file stream
            fileStream.Close
            
            ' Release resources
            Set fileStream = Nothing
            Set file = Nothing
        Else
            ' If the template file does not exist, return an empty string
            templateContents = ""
        End If
        
        ' Release resources
        Set fs = Nothing
        
        ' Check if the dictionary is initialized
        If IsObject(dictionary) Then
            ' Replace template contents based on dictionary
            Dim key
            For Each key In dictionary.Keys
                templateContents = Replace(templateContents, key, dictionary(key))
            Next
        End If

        ' Return the template contents
        GetEmailTemplate = templateContents
    End Function

    '--------------------------------------------------------------
    ' Function: IsValidEmail
    '
    ' Description: This function checks if an email address is valid
    '
    ' Parameters:
    '   email - The input to be checked
    '
    ' Returns:
    '   True if the email is valid, False otherwise
    '
    ' Example usage:
    '   IsValidEmail("I've got a lovely bunch of coconuts (diddle-dee-dee)")
    '   IsValidEmail("mark@rawlingson.ca")
    '--------------------------------------------------------------
    Private Function IsValidEmail(email)
        Dim emailPattern : Set emailPattern = New RegExp
        emailPattern.Pattern = "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
        IsValidEmail = emailPattern.Test(email)
    End Function

    '--------------------------------------------------------------
    ' Function: IsValidPhoneNumber
    '
    ' Description: This function checks if a phone number is valid
    '
    ' Parameters:
    '   phone - The input to be checked
    '
    ' Returns:
    '   True if the phone number is valid, False otherwise
    '
    ' Example usage:
    '   IsValidPhoneNumber("There they are a standing in a row (bum bum bum)")
    '   IsValidPhoneNumber("(905) 442-1333")
    '--------------------------------------------------------------
    Private Function IsValidPhoneNumber(phone)
        Dim phonePattern : Set phonePattern = New RegExp
        phonePattern.Pattern = "^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$"
        IsValidPhoneNumber = phonePattern.Test(phone)
    End Function

    '--------------------------------------------------------------
    ' Function: Sanitize
    '
    ' Description: This function sanitizes input data by allowing
    ' only whitelisted characters (alphanumeric and some common
    ' symbols) and removing any potentially dangerous characters.
    '
    ' Parameters:
    '   input - The input string to be sanitized.
    '
    ' Returns:
    '   A sanitized version of the input string, containing only
    '   allowed characters
    '
    ' Example usage:
    '   Dim sanitizedValue
    '   sanitizedValue = Sanitize(Request.QueryString("parameterName"))
    '--------------------------------------------------------------
    Function Sanitize(input)
        Dim whitelistPattern : Set whitelistPattern = New RegExp
        whitelistPattern.Pattern = "[^a-zA-Z0-9\s\.,!?@#()-{}]" ' Match anything not in the whitelist

        ' Replace any characters not in the whitelist with an empty string
        ' and return the sanitized input
        Sanitize = whitelistPattern.Replace(input, "")
    End Function

    '--------------------------------------------------------------
    ' Function: TrimStart
    '
    ' Description: Trim the first character from the beginning of a string
    '
    ' Parameters:
    '   str - The input string to be trimmed.
    '
    ' Returns:
    '   The input string minus the first character
    '
    ' Example usage:
    '   Dim trimmed
    '   trimmed = TrimStart(Request.QueryString("parameterName"))
    '--------------------------------------------------------------
    Function TrimStart(str)
        If Len(str) > 0 Then
            str = Right(str,Len(str)-1)
        End If
        TrimStart = str
    End Function

    '--------------------------------------------------------------
    ' Function: TrimEnd
    '
    ' Description: Trim the last character from the end of a string
    '
    ' Parameters:
    '   str - The input string to be trimmed.
    '
    ' Returns:
    '   The input string minus the last character
    '
    ' Example usage:
    '   Dim trimmed
    '   trimmed = TrimEnd(Request.QueryString("parameterName"))
    '--------------------------------------------------------------
    Function TrimEnd(str)
        If Len(str) > 0 Then
            str = Left(str,Len(str)-1)
        End If
        TrimEnd = str
    End Function

%>