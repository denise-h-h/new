<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ForGetPassword.aspx.vb" Inherits="ForGetPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="javascript" type ="text/javascript">
function startForm(){
    window.status = "Change Password";
    document.form1.UserName.focus();
}

function validate_form()
    {
        var chkEmptyLogin=(document.getElementById("<%=UserName.ClientID%>").value.split(" ").join(""))        
        var logName=document.getElementById("<%=UserName.ClientID%>").value
                
        if (chkEmptyLogin.length == 0)
        {    
            alert("Please enter the username before processing");              
            document.getElementById("<%=UserName.ClientID%>").focus();
            return false;
        }
        if (chkEmptyLogin.length > 0)
        {
            if (logName.indexOf("<") >=0 || logName.indexOf("!") >=0 || logName.indexOf("text/javascript") >=0 || logName.indexOf("=") >=0 || 
                logName.indexOf(">") >=0 || logName.indexOf("select") >=0 || logName.indexOf("@") >=0 || logName.indexOf("?") >=0 ||
                logName.indexOf(",") >=0 || logName.indexOf("'") >=0 || logName.indexOf("*") >=0 || logName.indexOf("table") >=0 ||
                logName.indexOf("insert") >=0 || logName.indexOf("update") >=0 || logName.indexOf("where") >=0 || logName.indexOf("#") >=0 ||
                logName.indexOf("delete") >=0 || logName.indexOf("drop") >=0)
                {
                    alert("Any script type language or symbol is not allowed here, please re-enter");
                    document.getElementById("<%=UserName.ClientID%>").value = "";
                    document.getElementById("<%=UserName.ClientID%>").focus();
                    return false;
                }
        }             
    }
    
function submitForm(){
    if (window.event.keyCode==13){                      
        if (validate_form() == false) {                
        }else{
            __doPostBack('btnConfirm', '');
        }                         
    }
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=950" />
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <title>Nationmark (HK) Ltd. Call Checking System - Forget Password</title>
    <link rel="stylesheet" type="text/css" href="Css/default.css" />
</head>
<body background="images/Bg-0064.gif" bgcolor="white" text="#000000" onload="javascript:startForm();">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="660">
            <tr>
                <td class='TBox' valign="top" width="500">
                    <h3><b>Nationmark(HK) Ltd.</b></h3>
        		    <h4><u>CALL CHECKING SYSTEM</u></h4>
	            </td>
                <td class='TBox' width="160">
                    <a href="Login.aspx"><img src="images/Nmark.gif" alt="Nationmark (H.K.) Ltd." border="0" width="144" height="80" /></a></td>
            </tr>
        </table>
        <hr />
        <br />
        
        <div align="center">
            <table border="1" width="660" style="text-align:left" cellpadding="2" bgcolor="Silver" borderColorDark="#ffffff" borderColorLight="#cccccc" cellspacing="0">
	            <tr><td bordercolordark="#ffffff" bordercolorlight="#cccccc" class='TBox' colspan="2" align="center">Forget Password</td></tr>
		        <tr><td bordercolordark="#ffffff" bordercolorlight="#cccccc" class='TBox'>Please Enter User Name:</td>
		            <td bordercolordark="#ffffff" bordercolorlight="#cccccc">
		                <asp:TextBox ID="UserName" runat="server" MaxLength="20" onkeypress="javascript:submitForm();"></asp:TextBox></td></tr>	
	            <tr><td bordercolordark="#ffffff" bordercolorlight="#cccccc" colspan="2" class='TBox'>
	                    <asp:LinkButton ID="btnConfirm" runat="server" Text="Confirm" CausesValidation="false" OnClientClick="return validate_form()"></asp:LinkButton>
				        <a href="javascript:javascript:window.history.back();">Cancel</td></a>
	            </tr>

            </table>
        </div>    
    </div>
    </form>
</body>
</html>
