<%
    '--------------------------------------------------------------
    ' Class: ContactRecord
    '
    ' Description: Represents an abstract Contact record
    '
    ' Example usage:
    '   Dim contact : Set contact = (New ContactRecord)("abc", "John", "Doe", "john.doe@domain.com", "123-456-7890", "Developer")
    '--------------------------------------------------------------
    Class ContactRecord
        Private m_id
        Private m_firstName
        Private m_lastName
        Private m_email
        Private m_phone
        Private m_occupation

        Private m_valid
        Private m_errors

        ' ##### Property Getters #####

        Public Property Get Id
            Id = m_id
        End Property

        Public Property Get FirstName
            FirstName = m_firstName
        End Property

        Public Property Get LastName
            LastName = m_lastName
        End Property

        Public Property Get Email
            Email = m_email
        End Property

        Public Property Get Phone
            Phone = m_phone
        End Property

        Public Property Get Occupation
            Occupation = m_occupation
        End Property

        Public Property Get Errors
            Set Errors = m_errors
        End Property

        Public Default Function Init(id, firstName, lastName, email, phone, occupation)
            m_id = id
            m_firstName = firstName
            m_lastName = lastName
            m_email = email
            m_phone = phone
            m_occupation = occupation
            
            Set m_errors = Server.CreateObject("Scripting.Dictionary")
            m_valid = IsValid()

            Set Init = Me
        End Function

        Private Sub AddErrorMessage(message)
            m_errors.Add m_errors.Count + 1, message
        End Sub

        Private Function IsValid()

            If IsValidEmail(m_email) = False Then
                AddErrorMessage "Invalid email address"
            End If

            IsValid = (m_errors.Count = 0)
        End Function

    End Class
%>