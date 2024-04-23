<!-- #include virtual="/modules/contacts/data/contact-record.asp" -->
<%
    '--------------------------------------------------------------
    ' Class: ContactRepository
    '
    ' Description: Encapsulates interactions with the Contact objects within the persistence layer.
    '
    ' Example usage:
    '   Dim contactRepository_ : Set contactRepository_ = New ContactRepository
    '   contactRepository_.GetContacts("Mark", "", "")
    '--------------------------------------------------------------
    Class ContactRepository
        Private m_recordCount

        ' ##### Property Getters #####

        Public Property Get RecordCount
            RecordCount = m_recordCount
            If m_recordCount < 0 Then
                RecordCount = 0
            End If
        End Property

        Public Property Get HasRecords
            HasRecords = m_recordCount > 0
        End Property

        ' ##### Public Functions #####

        ' Description: Retrieves a contact from the database by its unique identifier
        ' Parameters:
        '   - id: An integer representing the unique identifier of the contact to retrieve
        ' Returns: A single ContactRecord object representing the contact with the specified id
        Public Function GetContactById(id)
            Dim sql : sql = "SELECT Id, FirstName, LastName, Email, Phone, Occupation, ProfilePicture FROM Contacts WHERE Id = ?"
            Dim rsContact : Set rsContact = db.Query(sql, Array(id))
            Set GetContactById = (New ContactRecord)(rsContact("id"), rsContact("firstName"), rsContact("lastName"), rsContact("email"), rsContact("phone"), rsContact("occupation"))
            db.CloseRecordSet(rsContact)
        End Function

        ' Description: Retrieves contacts from the database based on search term and sorting criteria
        ' Parameters:
        '   - searchTerm: A string representing the term to search for in contact records
        '   - orderBy: A string representing the field to sort the results by
        '   - orderDirection: A string representing the direction of sorting (ASC for ascending, DESC for descending)
        ' Returns: A recordset containing the contacts matching the search term and sorted as specified
        Public Function GetContacts(searchTerm, orderBy, orderDirection)
            Dim sql : sql = "SELECT Id, FirstName, LastName, Email, Phone, Occupation, ProfilePicture FROM Contacts WHERE UserId = ?"

            Dim params : params = Array(Session("UserId"))

            ' Filtering
            If Len(searchTerm) Then
                sql = sql & " AND (FirstName LIKE ? OR LastName LIKE ? OR Email LIKE ? OR Phone LIKE ? OR Occupation LIKE ?)"
                ' Add search term params to array in a loop so it can easily be added to later
                For i = 1 To 5
                    ArrayAdd params, "%" & searchTerm & "%"
                Next                
            End If

            ' Sorting
            If Len(orderBy) Then
                If Len(orderDirection) = 0 Then
                    orderDirection = "ASC"
                End If
                sql = sql & " ORDER BY " & orderBy & " " & orderDirection
            End If

            Set GetContacts = db.Query(sql, params)

            m_recordCount = GetContacts.RecordCount
        End Function

        ' Description: Counts the total number of contacts in the database
        ' Returns: An integer representing the number of contacts in the database
        Public Function CountRecords()
            db.Connect()
            Dim sql : sql = "SELECT COUNT(*) AS RecordCount FROM Contacts WHERE UserId = ?"
            Dim contacts : Set contacts = db.Query(sql, Array(Session("UserId")))
            CountRecords = contacts("RecordCount")
            db.CloseRecordSet(contacts)
        End Function

        ' Description: Inserts a new contact
        ' Parameters:
        '   - contact: A ContactRecord containing the details of the contact
        Public Function CreateContact(contact)
            Dim sql : sql = "INSERT INTO Contacts (Id, UserId, FirstName, LastName, Email, Phone) " & _ 
                "VALUES (?, ?, ?, ?, ?, ?)"
            db.Execute sql, Array(contact.Id, Session("UserId"), contact.FirstName, contact.LastName, contact.Email, contact.Phone)
        End Function

        ' Description: Updates an existing contact
        ' Parameters:
        '   - contact: A ContactRecord containing the details of the contact
        Public Function UpdateContact(contact)
            Dim sql : sql = "UPDATE Contacts SET FirstName = ?, LastName = ?, Email = ?, Phone = ? WHERE Id = ?"
            db.Execute sql, Array(contact.FirstName, contact.LastName, contact.Email, contact.Phone, contact.Id)
        End Function

        ' Description: Deletes a contact
        ' Parameters:
        '   - id: The unique id of the record to delete
        Public Function DeleteContact(id)
            Dim sql : sql = "DELETE FROM Contacts WHERE Id = ?"
            db.Execute sql, Array(id)
        End Function

    End Class
%>