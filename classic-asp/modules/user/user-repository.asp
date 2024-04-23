<%

    Class UserRepository
        private m_id
        private m_firstName
        private m_lastName
        private m_email
        private m_profilePicture

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

        Public Property Get FullName
            FullName = m_firstName & " " & m_lastName
        End Property

        Public Property Get Email
            Email = m_email
        End Property

        Public Property Get ProfilePicture
            ProfilePicture = m_profilePicture
        End Property

        Public Property Get HasProfilePicture
            HasProfilePicture = Len(ProfilePicture) > 0
        End Property

        ' ##### Public Functions #####

        Public Function GetUser(id)

            ' Get user from database
            Dim rsUser : Set rsUser = db.Query("SELECT Id, FirstName, LastName, Email, ProfilePicture FROM Users WHERE Id = ?", Array(Session("UserId")))
            If Not rsUser.EOF Then
                m_id = rsUser("Id")
                m_firstName = rsUser("FirstName")
                m_lastName = rsUser("LastName")
                m_email = rsUser("Email")
                GetUser = True
            Else
                GetUser = False
            End If

            db.CloseRecordSet(rsUser)

        End Function

    End Class

%>