﻿<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        Application("CCSConn") = "server=localhost;uid=sa;pwd=CzqetumB1;database=CCS;Min Pool Size=10;Max Pool Size=300"
        Application("InvConn") = "server=localhost;uid=sa;pwd=CzqetumB1;database=inventory"
        Application("ASWConn") = "server=localhost;uid=sa;pwd=CzqetumB1;database=ASWInventory"
        'Application("CCSConn") = "server=localhost;uid=sa;pwd=czqetumb;database=CCS"
        'Application("InvConn") = "server=localhost;uid=sa;pwd=czqetumb;database=inventory"
        'Application("ITPConn") = "server=localhost;uid=sa;pwd=czqetumb;database=ITPInventory"
        Application("localMail") = "127.0.0.1"
        ' Code that runs on application startup
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub
       
</script>