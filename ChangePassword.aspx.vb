Imports System.Data.SqlClient
Imports System.Threading

Partial Class ChangePassword
    Inherits System.Web.UI.Page

    Protected Sub btnConfirm_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirm.Click
        Dim conn_r As New SqlConnection(Application("CCSConn"))
        Dim sql, sql2, sql3, sql4 As String
        Dim sqlResult, sqlResult2, sqlResult3 As SqlDataReader
        Dim sqlcmd, sqlcmd2, sqlcmd3, sqlcmd4 As SqlCommand
        Dim cntExist, uid, cntValid As Integer
        Dim client1 As ClientScriptManager
        Dim alertMsg As String = ""
        Dim logN As String = Trim(UserName.Text).ToLower
        Dim cf As New CommonFunction

        client1 = Me.ClientScript

        If (logN.IndexOf("<") >= 0 Or logN.IndexOf(">") >= 0 Or logN.IndexOf("!") >= 0 Or logN.IndexOf("@") >= 0 Or _
            logN.IndexOf("#") >= 0 Or logN.IndexOf("*") >= 0 Or logN.IndexOf("select") >= 0 Or logN.IndexOf("table") >= 0 Or _
            logN.IndexOf("insert") >= 0 Or logN.IndexOf("update") >= 0 Or logN.IndexOf("delete") >= 0 Or _
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
                sql2 = sql2 & "and encrypwd = '" & cf.MD5_Encry(Trim(oldPwd.Text)) & "'"
                conn_r.Open()
                sqlcmd2 = New SqlCommand(sql2, conn_r)
                sqlResult2 = sqlcmd2.ExecuteReader
                While sqlResult2.Read
                    cntValid = sqlResult2.Item("countIt")
                End While
                conn_r.Close()

                If cntValid = 0 Then 'Check if the old password correct or not
                    alertMsg = "alert('Old password is wrong, please re-enter');"
                    client1.RegisterStartupScript(Me.GetType(), "Message", alertMsg, True)
                Else
                    sql3 = "Select id from webuser where username = '" & Trim(UserName.Text) & "' and encrypwd = '" & cf.MD5_Encry(Trim(oldPwd.Text)) & "'"
                    conn_r.Open()
                    sqlcmd3 = New SqlCommand(sql3, conn_r)
                    sqlResult3 = sqlcmd3.ExecuteReader
                    While sqlResult3.Read
                        uid = sqlResult3.Item("id")
                    End While
                    conn_r.Close()

                    'update password
                    sql4 = "update webuser set password = '" & Trim(newPwd.Text) & "', encrypwd ='" & cf.MD5_Encry(Trim(newPwd.Text)) & "' "
                    sql4 = sql4 & "where id= '" & uid & "' "
                    conn_r.Open()
                    sqlcmd4 = New SqlCommand(sql4, conn_r)
                    sqlcmd4.ExecuteNonQuery()
                    conn_r.Close()

                    Response.Redirect("Login.aspx?suc=1")
                End If
            End If
        End If


    End Sub
End Class
