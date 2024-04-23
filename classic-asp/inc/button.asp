<%
    '--------------------------------------------------------------
    ' Class: Button
    ' 
    ' Description: Abstract representation of an HTML button and its properties
    '
    ' Example usage:
    '   (New Button)("Add Tour", "page.asp", "fa fa-trash", "p-2", "anchor", False)
    '--------------------------------------------------------------

    Const buttonType_anchor = "anchor"
    Const buttonType_button = "button"

    Class Button
        Private m_text
        Private m_url
        Private m_icon
        Private m_classList
        Private m_buttonType
        Private m_isModal

        Public Default Function Init(text, url, icon, classList, buttonType, isModal)
            m_text = text
            m_url = url
            m_icon = icon
            m_classList = classList
            m_buttonType = buttonType
            m_isModal = isModal

            Set Init = Me
        End Function

        ' ##### Property Getters #####

        Public Property Get Text
            Text = m_text
        End Property

        Public Property Let Text(value)
            m_text = value
        End Property

        Public Property Get Url
            Url = m_url
        End Property

        Public Property Let Url(value)
            m_url = value
        End Property

        Public Property Get Icon
            Icon = m_icon
        End Property

        Public Property Let Icon(value)
            m_icon = value
        End Property

        Public Property Get ClassList
            ClassList = m_classList
        End Property

        Public Property Let ClassList(value)
            m_classList = value
        End Property

        Public Property Get ButtonType
            ButtonType = m_buttonType
        End Property

        Public Property Let ButtonType(value)
            ButtonType = value
        End Property

        Public Property Get IsModal
            IsModal = m_isModal
        End Property

        Public Property Let IsModal(value)
            is_modal = value
        End Property

        ' ##### End Property Getters #####

        Public Function GetButton()
            If m_buttonType = buttonType_anchor Then
                button_ = "<a class=""" & m_classList & """" & _
                    " href=""" & m_url & """"
            ElseIf m_buttonType = buttonType_button Then
                button_ = "<button class=""" & m_classList & """"
            End If
            
            ' Add rel:"modal:open" to load the page via ajax if button is modal
            If m_isModal Then
                button_ = button_ & " rel=""modal:open"""
            End If

            If Len(m_url) Then
                button_ = button_ & " data-url=""" & m_url & """"
            End If
                
            button_ = button_ & ">"
            
            ' Add icon if one is specified
            If Len(m_icon) > 0 Then
                button_ = button_ & "<i class=""" & m_icon & """></i>"
            End If

            ' Add text
            button_ = button_ & m_text

            ' Close tag
            If m_buttonType = buttonType_anchor Then
                button_ = button_ & "</a>"
            ElseIf m_buttonType = buttonType_button Then
                button_ = button_ & "</button>"
            End If
            
            GetButton = button_
        End Function
    End Class

%>