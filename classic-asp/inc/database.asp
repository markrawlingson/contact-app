<!-- #include virtual="/inc/adovbs.asp" -->
<!-- #include virtual="/inc/database-connection-states.asp" -->
<%

    '--------------------------------------------------------------
    ' Class: Database
    '
    ' Description: Encapsulates interactions with the persistence layer
    '
    ' Example usage:
    '   Dim db : Set db = New Database
    '   db.Connect
    '--------------------------------------------------------------
    Class Database
        Private m_server
        Private m_databaseName
        Private m_username
        Private m_password
        Private m_connection

        ' Constructor
        Private Sub Class_Initialize()
            ' Settings censored for public repo
            m_server = ""
            m_databaseName = "contact-app"
            m_username = ""
            m_password = ""
            Set m_connection = Server.CreateObject("ADODB.Connection")
        End Sub

        ' Destructor
        Private Sub Class_Terminate()
            If Not m_connection Is Nothing Then
                m_connection.Close
                Set m_connection = Nothing
            End If
        End Sub

        ' ##### Property Getters #####

        Public Property Get State
            State = m_connection.State
        End Property

        ' Establish database connection
        Public Sub Connect()
            ' If the connection is closed, open it
            If m_connection.State = databaseConnectionState_Closed Then
                m_connection.Open "Provider=MSOLEDBSQL;Data Source=" & m_server & ";Initial Catalog=" & m_databaseName & ";UID=" & m_username & ";PWD=" & m_password & ";"

                ' If the connection failed, raise an error
                If m_connection.State <> 1 Then
                    Err.Raise 1, "Failed to establish a database connection"
                    Response.Redirect "/inc/error-handler.asp"
                End If
            End If
        End Sub

        ' Disconnect from the database
        Public Sub Disconnect()
            If Not m_connection Is Nothing And m_connection.State = databaseConnectionState_Open Then
                m_connection.Close
                Set m_connection = Nothing
            End If
        End Sub

        ' Query the database and return a recordset
        Public Function Query(sql, params)
            Connect()
            
            ' Instantiate command object
            Dim cmd: Set cmd = Server.CreateObject("ADODB.Command")
            cmd.ActiveConnection = m_connection
            cmd.CommandText = sql

            ' Create parameter objects
            Dim i
            For i = LBound(params) To UBound(params)
                Dim param: Set param = cmd.CreateParameter("param" & i, adVarChar, adParamInput, Len(params(i)), params(i))
                cmd.Parameters.Append param
            Next

            Set Query = cmd.Execute
        End Function

        ' Close a recordset
        Public Function CloseRecordSet(recordSet)
            recordSet.Close
            Set recordSet = Nothing
        End Function
        
        ' Execute a parameterized query
        ' Used for INSERT, UPDATE, DELETE
        Public Sub Execute(query, params)
            ' Ensure the database connection is open
            Connect()
            
            Dim cmd: Set cmd = Server.CreateObject("ADODB.Command")
            cmd.ActiveConnection = m_connection
            cmd.CommandText = query

            ' Create parameter objects
            Dim i
            For i = LBound(params) To UBound(params)
                Dim param: Set param = cmd.CreateParameter("param" & i, adVarChar, adParamInput,Len(params(i)), params(i))
                cmd.Parameters.Append param
            Next

            ' Execute the command
            cmd.Execute

            ' Clean up
            Set cmd = Nothing
        End Sub

    End Class

    ' Create an instance of the database class
    ' that will be automatically available anywhere this file is included
    Dim db : Set db = New Database

%>