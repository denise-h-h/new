Imports System.Data.SqlClient
Imports System.Threading

Partial Class _Default
    Inherits System.Web.UI.Page
    Shared userID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Session("authority") <> "1" Then
                Response.Redirect("login.aspx")
            Else
                Dim conn_r As New SqlConnection(Application("CCSConn"))
                Dim sql, sql2, sql3, sql4 As String
                Dim sqlResult, sqlResult2, sqlResult3, sqlResult4 As SqlDataReader
                Dim sqlcmd, sqlcmd2, sqlcmd3, sqlcmd4 As SqlCommand
                Dim disDate As New DisplayDate
                Dim OtherUnRead, permitDL As Integer
                Dim client1 As ClientScriptManager
                Dim alertMsg As String = ""
                Dim theGuid As String = Mid(Guid.NewGuid.ToString, 1, 5)

                client1 = Me.ClientScript

                Response.ExpiresAbsolute = DateTime.Now.AddDays(-1D) '
                Response.Expires = -1500
                Response.CacheControl = "no-cache"

                userID = Trim(Session("UserID"))

                searchReport.PostBackUrl = "ServiceReport/ServiceReportList.aspx?gid=" & theGuid
                SLALink.NavigateUrl = "SystemReport/SLAReport.aspx?gid=" & theGuid
                btnSerachArc.PostBackUrl = "ArchiveData/ArchiveServiceReportList.aspx?gid=" & theGuid

                userName.Text = Session("UserFullName")
                userAuth.Text = Trim(Session("GroupDescription"))
                If Len(Session("LoginInTime")) > 0 Then
                    logTime.Text = disDate.DisplayDate(FormatDateTime(Session("LoginInTime"), vbShortDate)) & "&nbsp;" & FormatDateTime(Session("LoginInTime"), vbShortTime)
                End If

                'sql = "select max(calltime) as LastArchiveTime from ArchiveServiceCall"
                'conn_r.Open()
                'sqlcmd = New SqlCommand(sql, conn_r)
                'sqlResult = sqlcmd.ExecuteReader
                'While sqlResult.Read
                '    archiveDate.Text = disDate.DisplayDate(sqlResult.Item("LastArchiveTime"))
                'End While
                'conn_r.Close()

                sql2 = "select count(*) as TotalUnReadAlertMessage from AlertMessage"
                sql2 = sql2 & " where AlertToUserID=" & userID & " and (status=1 or status =2)"
                conn_r.Open()
                sqlcmd2 = New SqlCommand(sql2, conn_r)
                sqlcmd2.CommandTimeout = 60
                sqlResult2 = sqlcmd2.ExecuteReader
                While sqlResult2.Read
                    unreadMsg.Text = sqlResult2.Item("TotalUnReadAlertMessage")
                End While
                conn_r.Close()

                sql3 = "select count(*) As countIT from AlertMessage where eventid <> 1 and AlertToUserID=" & userID & " and ((status=1) "
                sql3 = sql3 & " or ((POPUpAlert=1) and (status <>3)))"
                conn_r.Open()
                sqlcmd3 = New SqlCommand(sql3, conn_r)
                sqlcmd3.CommandTimeout = 60
                sqlResult3 = sqlcmd3.ExecuteReader
                While sqlResult3.Read
                    OtherUnRead = sqlResult3.Item("countIt")
                End While
                conn_r.Close()

                sql4 = "select count(*) as total from usergroup "
                sql4 = sql4 & " where GroupName in ('AC', 'AD', 'CS', 'EN', 'M2K', 'SS','WH','staff','administrator') "
                sql4 = sql4 & " and GroupName='" & Trim(Session("GroupName") & "") & "'"
                conn_r.Open()
                sqlcmd4 = New SqlCommand(sql4, conn_r)
                sqlResult4 = sqlcmd4.ExecuteReader
                While sqlResult4.Read
                    permitDL = sqlResult4.Item("total")
                End While
                conn_r.Close()
                dispose()
                If permitDL > 0 Then
                    BNGHandBook.Visible = True
                Else
                    BNGHandBook.Visible = False
                End If

                CheckModulePermission()

                If Not IsPostBack Then
                    If OtherUnRead > 0 Then
                        Session("AlertAgrCount") = "0"
                        alertMsg = "alert('You have new alert or Pop-up Alert message!');"
                        client1.RegisterStartupScript(Me.GetType(), "Message", alertMsg, True)
                    Else
                        If Session("AlertAgrCount") = "1" Then
                            Session("AlertAgrCount") = "0"
                            alertMsg = "alert('You have new alert or Pop-up Alert message!');"
                            client1.RegisterStartupScript(Me.GetType(), "Message", alertMsg, True)
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub CheckModulePermission()
        Dim userPermit As String = Session("CCSpermission")
        Dim gpName As String = Session("GroupName")
        Dim custGPName As String = Session("CustomerGroup")

        If custGPName = "" Then
            otherNotCreate.visible = False
            radWinUnassign.visible = False
        End If

        'SCMP Group Not allow to search agreement while add service call and not allow to view Job Status, Today Roster and Blank Report
        If Session("CustomerGroup") = "SCMP" Then
            blankReportTable.Visible = False
            jobRow.Visible = False
            rosterRow.Visible = False
            AddSRSerial.Visible = False
        End If

        otherNotCreate.Text = custGPName & " Follow Not Create New Call"
        radWinUnassign.Text = custGPName & " Un-assign Service Call"

        'Check New Service Call Box permission
        If Mid(userPermit, 11, 1) = "1" Then
            NewServiceBox.Visible = True
        Else
            NewServiceBox.Visible = False
        End If

        'Check Service Report Box permission
        If Mid(userPermit, 12, 1) >= "1" Then
            ServiceReportBox.Visible = True
            If gpName = "AD" Or gpName = "CS" Or gpName = "Administrator" Then
                ur.Visible = True
            Else
                ur.Visible = False
            End If
        Else
            ServiceReportBox.Visible = False
        End If

        'Check Incomplete Call Box permission
        If Mid(userPermit, 14, 1) >= "1" Then
            IncompleteBox.Visible = True
            If Len(Trim(Session("CustomerGroup") & "")) > 0 Then
                radUnassign.Visible = False
                notCreate.Visible = False
            Else
                radUnassign.Visible = True
                notCreate.Visible = True
            End If
        Else
            IncompleteBox.Visible = False
        End If

        'Check Note Report Box permission
        If Mid(userPermit, 13, 1) >= "1" Then
            NoteReportBox.Visible = True
        Else
            NoteReportBox.Visible = False
        End If

        'Check Alert Message Box permission
        If Mid(userPermit, 96, 1) >= "1" Then
            AlertMessageBox.Visible = True
        Else
            AlertMessageBox.Visible = False
        End If

        'Check View Alert permission
        If Mid(userPermit, 96, 1) >= "1" Then
            ViewAlert.Visible = True
        Else
            ViewAlert.Visible = False
        End If

        'Check Send Alert permission
        If Mid(userPermit, 97, 1) >= "1" Then
            SendAlert.Visible = True
        Else
            SendAlert.Visible = False
        End If

        'Check Alert Event Admin permission
        If Mid(userPermit, 98, 1) >= "1" Then
            EventAdmin.Visible = True
        Else
            EventAdmin.Visible = False
        End If

        'Check System Report Box permission
        If Mid(userPermit, 16, 1) >= "1" Then
            SystemReportBox.Visible = True
        Else
            SystemReportBox.Visible = False
        End If

        'Check Service Report Statistic and Main. Service Analysis Report permission
        If Mid(userPermit, 17, 1) >= "1" Then
            SerRepSta.Visible = True
            SysRepSearch.Visible = True
        Else
            SerRepSta.Visible = False
            SysRepSearch.Visible = False
        End If

        'Check Call Amt Report, District Call Amt Report, Case Type Call Amt Report, Service Report Amt permission
        If Mid(userPermit, 18, 1) >= "1" Then
            CallAmtReport.Visible = True
            DisCallAmtReport.Visible = True
            CaseTypeAmtReport.Visible = True
            SerRepAmtReport.Visible = True
        Else
            CallAmtReport.Visible = False
            DisCallAmtReport.Visible = False
            CaseTypeAmtReport.Visible = False
            SerRepAmtReport.Visible = False
        End If

        'Check Analysis Report permission
        If Mid(userPermit, 19, 1) >= "1" Then
            AnalysisRep.Visible = True
        Else
            AnalysisRep.Visible = False
        End If

        'Check HPIM Report Permission
        'If Mid(userPermit, 160, 1) >= "1" Then
        '    HPIMRow.Visible = True
        'Else
        '    HPIMRow.Visible = False
        'End If

        'Check Per Time Report Permission
        If Mid(userPermit, 20, 1) >= "1" Then
            PerTimeRep.Visible = True
        Else
            PerTimeRep.Visible = False
        End If

        'Check OutStanding Report, Service Call Sum, Service Report Sum, Service Report Return Report permission
        If Mid(userPermit, 22, 1) >= "1" Then
            OutStandReport.Visible = True
            SerCallSummary.Visible = True
            SerRepSummary.Visible = True
            SerRepReturn.Visible = True
        Else
            OutStandReport.Visible = False
            SerCallSummary.Visible = False
            SerRepSummary.Visible = False
            SerRepReturn.Visible = False
        End If

        'Check SLA Report Permission
        'If Mid(userPermit, 163, 1) >= "1" Then
        '    SLAReport.Visible = True
        'Else
        '    SLAReport.Visible = False
        'End If

        'Check Note without PD number Report Permission
        If Mid(userPermit, 159, 1) >= "1" Then
            NOPDReport.Visible = True
        Else
            NOPDReport.Visible = False
        End If

        'Check Engineer Report Box permission
        If Mid(userPermit, 23, 1) >= "1" Then
            EngineerReportBox.Visible = True
        Else
            EngineerReportBox.Visible = False
        End If

        'Check CS Not Check Service Report permission
        If Mid(userPermit, 30, 1) >= "1" Then
            CSNotCheck.Visible = True
        Else
            CSNotCheck.Visible = False
        End If

        'Check Engineer Not Complete Service Report permission
        If Mid(userPermit, 30, 1) >= "1" Then
            EngNotComplete.Visible = True
        Else
            EngNotComplete.Visible = False
        End If

        'Check Engineer Service Report Static permission
        If Mid(userPermit, 24, 1) >= "1" Then
            EngSerRepSearch.Visible = True
        Else
            EngSerRepSearch.Visible = False
        End If

        'Check Engineer Performed Report permission
        If Mid(userPermit, 25, 1) >= "1" Then
            EngPerfReport.Visible = True
        Else
            EngPerfReport.Visible = False
        End If

        'Check Engineer Travel Fare Report permission
        If Mid(userPermit, 26, 1) >= "1" Then
            EngTravelReport.Visible = True
        Else
            EngTravelReport.Visible = False
        End If

        'Check Admin Box permission
        If Mid(userPermit, 15, 1) >= "1" Then
            AdminBox.Visible = True
        Else
            AdminBox.Visible = False
        End If

        'Check Edit Group Name permission
        If Mid(userPermit, 101, 1) >= "1" Then
            EditGpName.Visible = True
        Else
            EditGpName.Visible = False
        End If

        'Check Edit Login Account permission
        If Mid(userPermit, 102, 1) >= "1" Then
            EditLogin.Visible = True
        Else
            EditLogin.Visible = False
        End If

        'Check Edit Customer Information permission
        If Mid(userPermit, 103, 1) >= "1" Then
            EditCustomer.Visible = True
            AllCustomer.Visible = True
        Else
            EditCustomer.Visible = False
            AllCustomer.Visible = False
        End If

        'Check Edit Report Type permission
        If Mid(userPermit, 104, 1) >= "1" Then
            EditReport.Visible = True
        Else
            EditReport.Visible = False
        End If

        'Check Edit Case Type Permission
        If Mid(userPermit, 105, 1) >= "1" Then
            EditCase.Visible = True
        Else
            EditCase.Visible = False
        End If

        'Check Edit Service Category permission
        If Mid(userPermit, 106, 1) >= "1" Then
            EditSerCat.Visible = True
        Else
            EditSerCat.Visible = False
        End If

        'Check Edit Company Name Permission
        If Mid(userPermit, 107, 1) >= "1" Then
            EditCompany.Visible = True
        Else
            EditCompany.Visible = False
        End If

        'Check Agreement Box permission
        If Mid(userPermit, 121, 1) >= "1" Then
            AgreementBox.Visible = True
        Else
            AgreementBox.Visible = False
        End If

        'Check Agreement Box Detail permission
        If Mid(userPermit, 121, 1) >= "1" Then
            AgrBoxRow1.Visible = True
            AgrBoxRow2.Visible = True
            AgrBoxRow3.Visible = True
            If (Mid(userPermit, 129, 1)) = "1" Then
                AgrBoxRow4.Visible = True
            Else
                AgrBoxRow4.Visible = False
            End If
        Else
            AgrBoxRow1.Visible = False
            AgrBoxRow2.Visible = False
            AgrBoxRow3.Visible = False
        End If

        'Edit Agreement type permission
        If Mid(userPermit, 123, 1) >= "1" Then
            AgrBoxEditAgrType.Visible = True
        Else
            AgrBoxEditAgrType.Visible = False
        End If

        'Edit Agreement Machine PC Type permission
        If Mid(userPermit, 125, 1) >= "1" Then
            AgrBoxEditAgrPC.Visible = True
        Else
            AgrBoxEditAgrPC.Visible = False
        End If

        'Check Agreement Report Box permission
        If Mid(userPermit, 122, 1) >= "1" Then
            AgreementReportBox.Visible = True
        Else
            AgreementReportBox.Visible = False
        End If

        'Check Agreement Amount Report
        If Mid(userPermit, 139, 1) >= "1" Then
            AgrAmtReport.Visible = True
        Else
            AgrAmtReport.Visible = False
        End If

        'Check Agreement PC Information, Agreement Non PC Information
        If Mid(userPermit, 122, 1) >= "1" Then
            AgrPCInfo.Visible = True
            AgrNonPCInfo.Visible = True
        Else
            AgrPCInfo.Visible = False
            AgrNonPCInfo.Visible = False
        End If

        'Check Non-Maintenance Report
        If Mid(userPermit, 140, 1) >= "1" Then
            NonMainReport.Visible = True
        Else
            NonMainReport.Visible = False
        End If

        'Check Archive Box
        'If Mid(userPermit, 28, 1) >= "1" Then
        '    ArchiveBox.Visible = True
        'Else
        '    ArchiveBox.Visible = False
        'End If
		
		If Mid(userPermit, 165, 1) >= "1" Then
            LeaveRecordBox.Visible = True
			
        Else
            LeaveRecordBox.Visible = False
        End If
		
		If Mid(userPermit, 166, 1) >= "1" Then
            ServicesBox.Visible = True
			
        Else
            ServicesBox.Visible = False
        End If


    End Sub

    Protected Sub logOut_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles logOut.Click
        Dim conn_r As New SqlConnection(Application("CCSConn"))
        Dim sql As String
        Dim sqlcmd As SqlCommand
        Dim ckwKey As String = Session("UserID") & "ckw"
        Dim ccriKey As String = Session("UserID") & "ccri"
        Dim skwKey As String = Session("UserID") & "skw"
        Dim scriKey As String = Session("UserID") & "scri"
        Dim dKey As String = Session("UserID") & "d"

        sql = "update Log set LogoutTime=getdate()"
        If Len(Session("LogID") & "") > 0 Then
            sql = sql & " where LogID=" & Session("LogID")
        Else
            sql = sql & " where LogID=(select top 1 LogID from log"
            sql = sql & " where UserID='" & Session("UserID") & "'"
            sql = sql & " order by loginTime desc)"
        End If
        conn_r.Open()
        sqlcmd = New SqlCommand(sql, conn_r)
        sqlcmd.ExecuteNonQuery()
        conn_r.Close()
        dispose()

        Cache.Remove(ckwKey)
        Cache.Remove(ccriKey)
        Cache.Remove(skwKey)
        Cache.Remove(scriKey)
        Cache.Remove(dKey)
        
        Session.Clear()

        Response.Redirect("Login.aspx")
    End Sub

    Protected Sub blankFormList_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles blankFormList.Load
        If Not IsPostBack Then
            Dim conn_r As New SqlConnection(Application("CCSConn"))
            Dim sql As String
            Dim sqlcmd As SqlCommand
            Dim sqlResult As SqlDataReader
            Dim listItem As ListItem

            sql = "select CompanyID, EnglishCompanyName from company "
            If Len(Trim(Session("CustomerGroup") & "")) > 0 Then
                sql = sql & "where EnglishCompanyName like '" & Trim(Session("CustomerGroup") & "") & "%' "
                sql = sql & "or ServiceReportHead = '" & Trim(Session("CustomerGroup") & "") & "' "
            End If
            sql = sql & "order by DefaultCompany desc,EnglishCompanyName"
            conn_r.Open()
            sqlcmd = New SqlCommand(sql, conn_r)
            sqlResult = sqlcmd.ExecuteReader
            While sqlResult.Read
                listItem = New ListItem(sqlResult.Item("EnglishCompanyName"), sqlResult.Item("CompanyID"))
                blankFormList.Items.Add(listItem)
            End While
            conn_r.Close()
            conn_r = Nothing
        End If
    End Sub

    Protected Sub btnViewForm_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewForm.Click
        Select Case blankFormList.SelectedValue
            Case "6"
                Response.Redirect("NewService/HPReport.aspx?t=bHP")
            Case "30"
                Response.Redirect("NewService/HPReport.aspx?t=b")
            Case "10"
                Response.Redirect("NewService/WincorReport.aspx?t=b")
            Case Else
                Response.Redirect("Administration/ServiceReportPrint.aspx?t=b&cid=" & blankFormList.SelectedValue)
        End Select
    End Sub

    Protected Sub btnViewNote_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewNote.Click
        Response.Redirect("NoteReport/PrintNote.aspx?f=def&cid=6&tp=" & NoteList.SelectedValue)
    End Sub

    Protected Sub btnViewNMNote_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewNMNote.Click
        Response.Redirect("NoteReport/PrintNote.aspx?f=def&cid=1&tp=" & NoteList.SelectedValue)
    End Sub
End Class
