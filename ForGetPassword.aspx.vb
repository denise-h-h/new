Imports System.Data.SqlClient
Imports System.Threading
Imports System.Net.Mail

Partial Class ForGetPassword
    Inherits System.Web.UI.Page

    Protected Sub btnConfirm_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirm.Click
        Dim conn_r As New SqlConnection(Application("CCSConn"))
        Dim sql, sql2, sql3 As String
        Dim sqlResult, sqlResult2, sqlResult3 As SqlDataReader
        Dim sqlcmd, sqlcmd2, sqlcmd3 As SqlCommand
        Dim cntExist, hvEmail As Integer
        Dim uemail As String = ""
        Dim upwd As String = ""
        Dim client1 As ClientScriptManager
        Dim alertMsg As String = ""
        Dim mailObj As New System.Net.Mail.MailMessage
        Dim ipAdd As String = Application("localMail")
        Dim logN As String = Trim(UserName.Text).ToLower

        client1 = Me.ClientScript

        If (logN.IndexOf("<") >= 0 Or logN.IndexOf(">") >= 0 Or logN.IndexOf("!") >= 0 Or logN.IndexOf("@") >= 0 Or _
            logN.IndexOf("#") >= 0 Or logN.IndexOf("*") >= 0 Or logN.IndexOf("select") >= 0 Or logN.IndexOf("table") >= 0 Or _
            logN.IndexOf("insert") >= 0 Or logN.IndexOf("update") >= 0 Or logN.IndexOf("delete") >= 0 Or logN.IndexOf("count") >= 0 Or _
            logN.IndexOf("text/javascript") >= 0 Or logN.IndexOf("where") >= 0 Or logN.IndexOf(",") >= 0 Or _
            logN.IndexOf("'") >= 0 Or logN.IndexOf("=") >= 0 Or logN.IndexOf("drop") >= 0) Then
            alertMsg = "alert('No script type language or symbol is allowed');"
            client1.RegisterStartupScript(Me.GetType(), "Message", alertMsg, True)

        Else
            sql = "select count(*) As countIt from webuser where username='" & Trim(UserName.Text) & "'"
            conn_r.Open()
            sqlcmd = New SqlCommand(sql, conn_r)
            sqlResult = sqlcmd.ExecuteReader
            While sqlResult.Read
                cntExist = sqlResult.Item("countIt")
            End While
            conn_r.Close()

            If cntExist = 0 Then 'Check if username existed or not
                alertMsg = "alert('User not exist');"
                client1.RegisterStartupScript(Me.GetType(), "Message", alertMsg, True)
            Else
                sql2 = "Select count(*) as countIt from webuser where username = '" & Trim(UserName.Text) & "' "
                sql2 = sql2 & "and Useremail is Not NULL and len(Useremail) > 0 "
                conn_r.Open()
                sqlcmd2 = New SqlCommand(sql2, conn_r)
                sqlResult2 = sqlcmd2.ExecuteReader
                While sqlResult2.Read
                    hvEmail = sqlResult2.Item("countIt")
                End While
                conn_r.Close()

                If hvEmail = 0 Then
                    alertMsg = "alert('User does not have registered email');"
                    client1.RegisterStartupScript(Me.GetType(), "Message", alertMsg, True)
                Else
                    sql3 = "Select Useremail, password from webuser where username = '" & Trim(UserName.Text) & "' "
                    sql3 = sql3 & "and Useremail is Not NULL and len(Useremail) > 0 "
                    conn_r.Open()
                    sqlcmd3 = New SqlCommand(sql3, conn_r)
                    sqlResult3 = sqlcmd3.ExecuteReader
                    While sqlResult3.Read
                        uemail = sqlResult3.Item("Useremail")
                        upwd = sqlResult3.Item("password")
                    End While
                    conn_r.Close()

                    Try
                        mailObj.From = New System.Net.Mail.MailAddress("root@nationmark.com", "System")
                        mailObj.To.Add(New System.Net.Mail.MailAddress(uemail, "User"))
                        mailObj.Subject = "Nation Mark Password:"
                        mailObj.Body = "Password: " & upwd
                        mailObj.IsBodyHtml = True
                        Dim smtp As New System.Net.Mail.SmtpClient(ipAdd)
                        smtp.Send(mailObj)

                        Response.Redirect("Login.aspx?suc=2")
                    Catch ex As Exception
                        alertMsg = "alert('Send Email failed: " & ex.Message & "');"
                        client1.RegisterStartupScript(Me.GetType(), "Message", alertMsg, True)
                    End Try
                End If
            End If
        End If

    End Sub
End Class
