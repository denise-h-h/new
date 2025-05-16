Imports System.Data.SqlClient
Imports System.Threading
Imports System.Web.Configuration
Imports System.Web.HttpRequest


Partial Class Login
    Inherits System.Web.UI.Page

    Private Function GetFormVal(ByVal Param As String) As String
        If Len(Request.Form(Param) & "") > 0 Then
            GetFormVal = Request.Form(Param) & ""
        ElseIf Len(Server.UrlDecode(Request.QueryString(Param) & "")) > 0 Then
            GetFormVal = Server.UrlDecode(Request.QueryString(Param) & "")
        Else
            GetFormVal = ""
        End If
    End Function

    Private Function getClientIP() As String
        Dim sIPAddress As String
        sIPAddress = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
        If sIPAddress = "" Then
            sIPAddress = Request.ServerVariables("REMOTE_ADDR")
        End If
        getClientIP = sIPAddress 'Request.ServerVariables("REMOTE_HOST") 'Request.UserHostAddress()
    End Function

    Private Function isIPBlocked(ByVal ipAddress As String) As Boolean
        Dim conn_r As New SqlConnection(Application("CCSConn"))
        Dim sql As String
        Dim sqlResult As SqlDataReader
        Dim sqlcmd As SqlCommand

        isIPBlocked = False

        sql = "select TOP (1) id from IPBlackList where IP = '" & ipAddress & "' and Active = 'True'"
        conn_r.Open()
        sqlcmd = New SqlCommand(sql, conn_r)
        sqlResult = sqlcmd.ExecuteReader
        If sqlResult.HasRows Then
            isIPBlocked = True
        Else
            isIPBlocked = False
        End If
		conn_r.Close()
    End Function

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        Dim conn_r As New SqlConnection(Application("CCSConn"))
        Dim conn_r2 As New SqlConnection(Application("CCSConn"))
        Dim conn_r3 As New SqlConnection(Application("CCSConn"))
        Dim sql, sql2, sql3 As String
        Dim sqlResult, sqlResult2 As SqlDataReader
        Dim sqlcmd, sqlcmd2, sqlcmd3 As SqlCommand
        Dim cf As New CommonFunction
        Dim logN As String = Trim(logName.Text).ToLower

        If (logN.IndexOf("<") >= 0 Or logN.IndexOf(">") >= 0 Or logN.IndexOf("!") >= 0 Or logN.IndexOf("@") >= 0 Or _
            logN.IndexOf("#") >= 0 Or logN.IndexOf("*") >= 0 Or logN.IndexOf("select") >= 0 Or logN.IndexOf("table") >= 0 Or _
            logN.IndexOf("insert") >= 0 Or logN.IndexOf("update") >= 0 Or logN.IndexOf("delete") >= 0 Or logN.IndexOf(",count") >= 0 Or _
            logN.IndexOf(" count") >= 0 Or logN.IndexOf("text/javascript") >= 0 Or logN.IndexOf("where") >= 0 Or logN.IndexOf(",") >= 0 Or _
            logN.IndexOf("'") >= 0 Or logN.IndexOf("=") >= 0 Or logN.IndexOf("drop") >= 0) Then
            Session("authority") = ""
            Response.Redirect("Login.aspx")
        Else
            sql = "select * from vWebuser "
            sql = sql & "where username ='" & Trim(logName.Text) & "' "
            sql = sql & "and encrypwd='" & cf.MD5_Encry(Trim(pwd.Text)) & "' "
            'sql = sql & "and password = '" & Trim(pwd.Text) & "' "
            sql = sql & "and active=1 "
            'sql = sql & "and ((len(customerGroup)=0 or customerGroup is null))"
            conn_r.Open()
            sqlcmd = New SqlCommand(sql, conn_r)
            sqlResult = sqlcmd.ExecuteReader
            If sqlResult.HasRows Then
                While sqlResult.Read
                    Response.Cookies("CCSUserName").Value = sqlResult.Item("UserName")
                    Response.Cookies("CCSUserName").Expires = DateTime.Now().AddDays(365)

                    Session("authority") = "1"
                    Session("CCSpermission") = sqlResult.Item("CCSpermission")
                    Session("UserFullName") = sqlResult.Item("UserFullName")
                    Session("Username") = sqlResult.Item("UserName")
                    Session("GroupName") = sqlResult.Item("GroupName")
                    Session("GroupDescription") = sqlResult.Item("GroupDescription")
                    Session("CCSCustomerCode") = sqlResult.Item("CCSCustomerCode")
                    Session("CCSSubCustomerCode") = sqlResult.Item("CCSSubCustomerCode")
                    If Not IsDBNull(sqlResult.Item("CustomerGroup")) Then
                        Session("CustomerGroup") = sqlResult.Item("CustomerGroup")
                    Else
                        Session("CustomerGroup") = ""
                    End If
                    Session("LoginInTime") = Now
                    Session("UserID") = sqlResult.Item("id")

                    Dim instance As New FormsAuthenticationConfiguration
                    Dim value As New TimeSpan

                    'instance.Timeout = System.TimeSpan.FromMinutes(260)

                    Dim logid As String = ""

                    sql2 = "set nocount on; "
                    sql2 = sql2 & "insert into log (UserID,LoginTime,LoginIP) "
                    sql2 = sql2 & "values(" & sqlResult.Item("id")
                    sql2 = sql2 & ", GetDate(),'" & Request.ServerVariables("REMOTE_HOST") & "'); "
                    sql2 = sql2 & "Select Cast(scope_identity() AS int); "
                    conn_r2.Open()
                    sqlcmd2 = New SqlCommand(sql2, conn_r2)
                    logid = sqlcmd2.ExecuteScalar
                    conn_r2.Close()

                    Session("LogID") = logid

                    sql3 = "select count(*) As countIT from AlertMessage where eventid = 1 and AlertToUserID = " & sqlResult.Item("id") & " and ((status=1) "
                    sql3 = sql3 & "or ((POPUpAlert=1) and (status <>3)))"
                    conn_r2.Open()
                    sqlcmd3 = New SqlCommand(sql3, conn_r2)
                    sqlcmd3.CommandTimeout = 100
                    sqlResult2 = sqlcmd3.ExecuteReader
                    While sqlResult2.Read
                        If sqlResult2.Item("countIt") > 0 Then
                            Session("AlertAgrCount") = "1"
                        Else
                            Session("AlertAgrCount") = "0"
                        End If
                    End While
                    conn_r2.Close()
                End While
                conn_r.Close()
                dispose()
                Response.Redirect("Default.aspx")
            Else
                'Update IPTodayBlackList
                Dim ipAddress As String = getClientIP()
                Dim freq As Integer = 1
                Dim lastDateTime As Date

                sql3 = "insert into IPTodayBlackList (IP, LastDatetime, Frequency) values ('" & ipAddress & "', GetDate(), 1)"  'update database
                sql2 = "select TOP (1) id, LastDatetime, Frequency from IPTodayBlackList where IP = '" & ipAddress & "'"        'check last status
                conn_r2.Open()
                sqlcmd2 = New SqlCommand(sql2, conn_r2)
                sqlResult2 = sqlcmd2.ExecuteReader
                If sqlResult2.HasRows Then
                    While sqlResult2.Read
                        lastDateTime = Convert.ToDateTime(sqlResult2.Item("LastDatetime"))
                        If lastDateTime.Year = Date.Now.Year And lastDateTime.Month = Date.Now.Month And lastDateTime.Day = Date.Now.Day Then
                            freq = Convert.ToInt32(sqlResult2.Item("Frequency")) + 1
                        End If
                        sql3 = "update IPTodayBlackList set LastDatetime = GetDate(), Frequency = '"
                        sql3 = sql3 & freq.ToString() & "' where id = '" & sqlResult2.Item("id") & "'"
                    End While
                End If
                conn_r2.Close()

                conn_r2.Open()                              'update database
                sqlcmd3 = New SqlCommand(sql3, conn_r2)
                sqlcmd3.ExecuteNonQuery()
                conn_r2.Close()

                'Update IPBlackList
                If freq >= 5 Then
                    sql2 = "select id from IPBlackList where IP = '" & ipAddress & "' and Active = 'True'"
                    conn_r2.Open()
                    sqlcmd2 = New SqlCommand(sql2, conn_r2)
                    sqlResult2 = sqlcmd2.ExecuteReader
                    If Not sqlResult2.HasRows Then
                        sql3 = "insert into IPBlackList (IP, LastDateTime, Remark, Active) values ('" & ipAddress & "', GetDate(), 'Login with incorrect username or password 5 times', 'True')"
                        conn_r3.Open()
                        sqlcmd3 = New SqlCommand(sql3, conn_r3)
                        sqlcmd3.ExecuteNonQuery()
                    End If
                    conn_r2.Close()
                End If

                ' Redirect
                Session("authority") = ""
                Response.Redirect("Login.aspx")
            End If
        End If


    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim client1 As ClientScriptManager
        Dim sucCode As String = GetFormVal("suc")
        Dim sucStr As String = ""

        client1 = Me.ClientScript

        If Not IsPostBack Then
            Dim get_mycookie As HttpCookie = Request.Cookies("CCSUserName")
            If Not get_mycookie Is Nothing Then
                logName.Text = get_mycookie.Value
            End If

            Dim ipAddress As String = getClientIP()
            Dim ipBlocked As Boolean = isIPBlocked(ipAddress)
            If ipBlocked Then
                btnLogin.Enabled = False
                logName.Text = ""
                logName.BackColor = Drawing.Color.LightGray
                logName.Enabled = False
                pwd.BackColor = Drawing.Color.LightGray
                pwd.Enabled = False
                sucStr = "alert('Your IP is blocked by the system! Please contact the system admin.');"
                client1.RegisterStartupScript(Me.GetType(), "Message", sucStr, True)
            Else
                If sucCode = "1" And sucCode.Length > 0 Then
                    sucStr = "alert('Password changed successfully');"
                    client1.RegisterStartupScript(Me.GetType(), "Message", sucStr, True)
                ElseIf sucCode = "2" And sucCode.Length > 0 Then
                    sucStr = "alert('The password had been sent to you');"
                    client1.RegisterStartupScript(Me.GetType(), "Message", sucStr, True)
                End If
            End If
        End If

    End Sub
End Class
